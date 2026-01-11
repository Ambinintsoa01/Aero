package com.aerocompagnie.controller;

import com.aerocompagnie.model.Aeroport;
import com.aerocompagnie.model.Avion;
import com.aerocompagnie.model.InstanceVol;
import com.aerocompagnie.model.SegmentVol;
import com.aerocompagnie.model.Vol;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalTime;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@WebServlet("/vols/*")
public class VolController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            listerVols(request, response);
        } else if (pathInfo.equals("/nouveau")) {
            afficherFormulaireAjouter(request, response);
        } else if (pathInfo.startsWith("/details/")) {
            String volId = pathInfo.substring("/details/".length());
            afficherDetailsVol(request, response, Integer.parseInt(volId));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("ajouter_vol".equals(action)) {
            ajouterVol(request, response);
        } else if ("ajouter_segment".equals(action)) {
            ajouterSegment(request, response);
        }
    }

    private void listerVols(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Vol> vols = Vol.findAll("Vols");

        String numeroVol = trimLower(request.getParameter("numero_vol"));
        String description = trimLower(request.getParameter("description"));

        List<Vol> filtres = vols.stream()
                .filter(v -> numeroVol == null || containsIgnoreCase(v.getNumero_vol(), numeroVol))
                .filter(v -> description == null || containsIgnoreCase(v.getDescription(), description))
                .collect(Collectors.toList());

        request.setAttribute("vols", filtres);
        request.setAttribute("numero_vol", request.getParameter("numero_vol"));
        request.setAttribute("description", request.getParameter("description"));
        request.getRequestDispatcher("/jsp/vols/liste.jsp").forward(request, response);
    }

    private void afficherFormulaireAjouter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Aeroport> aeroports = Aeroport.findAll("Aeroports");
        request.setAttribute("aeroports", aeroports);
        request.getRequestDispatcher("/jsp/vols/formulaire.jsp").forward(request, response);
    }

    private void afficherDetailsVol(HttpServletRequest request, HttpServletResponse response,
            int volId) throws ServletException, IOException {
        Vol vol = Vol.findAll("Vols").stream()
                .filter(v -> v.getVol_id() == volId)
                .findFirst()
                .orElse(null);

        if (vol != null) {
            List<SegmentVol> segments = vol.getItineraireComplet(volId);
            
            // Récupérer toutes les instances de ce vol
            List<InstanceVol> instances = InstanceVol.findAll("Instances_Vols").stream()
                    .filter(iv -> segments.stream().anyMatch(s -> s.getSegment_id() == iv.getSegment_id()))
                    .collect(Collectors.toList());
            
            // Charger les informations d'avions et calculer les places disponibles
            List<Avion> avions = Avion.findAll("Avions");
            
            // Pour chaque instance, obtenir les informations de places
            java.util.Map<Integer, com.aerocompagnie.model.SeatInfo> seatInfoMap = new java.util.HashMap<>();
            for (InstanceVol instance : instances) {
                InstanceVol iv = new InstanceVol();
                com.aerocompagnie.model.SeatInfo seatInfo = iv.getSeatInfo(instance.getInstance_id(), instance.getAvion_id());
                if (seatInfo != null) {
                    seatInfoMap.put(instance.getInstance_id(), seatInfo);
                }
            }
            
            request.setAttribute("vol", vol);
            request.setAttribute("segments", segments);
            request.setAttribute("instances", instances);
            request.setAttribute("avions", avions);
            request.setAttribute("seatInfoMap", seatInfoMap);
            request.getRequestDispatcher("/jsp/vols/details.jsp").forward(request, response);
        } else {
            response.sendError(404, "Vol non trouvé");
        }
    }

    private void ajouterVol(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String numeroVol = request.getParameter("numero_vol");
        String description = request.getParameter("description");

        Vol vol = new Vol();
        vol.setNumero_vol(numeroVol);
        vol.setDescription(description);

        if (vol.save("Vols")) {
            request.setAttribute("message", "Vol créé avec succès!");
        } else {
            request.setAttribute("erreur", "Erreur lors de la création");
        }
        listerVols(request, response);
    }

    private void ajouterSegment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int volId = Integer.parseInt(request.getParameter("vol_id"));
        String aeroportDepart = request.getParameter("aeroport_depart");
        String aeroportArrivee = request.getParameter("aeroport_arrivee");
        int ordreSegment = Integer.parseInt(request.getParameter("ordre_segment"));
        String heureDepartStr = request.getParameter("heure_depart_UTC");
        String heureArriveeStr = request.getParameter("heure_arrivee_UTC");

        SegmentVol segment = new SegmentVol();
        segment.setVol_id(volId);
        segment.setAeroport_depart(aeroportDepart);
        segment.setAeroport_arrivee(aeroportArrivee);
        segment.setOrdre_segment(ordreSegment);
        segment.setHeure_depart_UTC(LocalTime.parse(heureDepartStr));
        segment.setHeure_arrivee_UTC(LocalTime.parse(heureArriveeStr));

        if (segment.save("Segments_Vol")) {
            request.setAttribute("message", "Segment ajouté avec succès!");
        } else {
            request.setAttribute("erreur", "Erreur lors de l'ajout du segment");
        }
        afficherDetailsVol(request, response, volId);
    }

    private static String trimLower(String value) {
        if (value == null) return null;
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed.toLowerCase(Locale.ROOT);
    }

    private static boolean containsIgnoreCase(String source, String needle) {
        return source != null && source.toLowerCase(Locale.ROOT).contains(needle);
    }
}
