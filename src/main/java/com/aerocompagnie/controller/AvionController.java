package com.aerocompagnie.controller;

import com.aerocompagnie.model.Avion;
import com.aerocompagnie.model.StatutAvion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@WebServlet("/avions/*")
public class AvionController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            listerAvions(request, response);
        } else if (pathInfo.equals("/nouveau")) {
            afficherFormulaireAjouter(request, response);
        } else if (pathInfo.startsWith("/details/")) {
            String avionId = pathInfo.substring("/details/".length());
            afficherDetailsAvion(request, response, Integer.parseInt(avionId));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("ajouter".equals(action)) {
            ajouterAvion(request, response);
        } else if ("mettre_a_jour".equals(action)) {
            mettreAJourAvion(request, response);
        }
    }

    private void listerAvions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Avion> avions = Avion.findAll("Avions");
        List<StatutAvion> statuts = StatutAvion.findAll("Statut_Avion");

        String immat = trimLower(request.getParameter("immat"));
        String modele = trimLower(request.getParameter("modele"));
        String statutParam = request.getParameter("statut");

        List<Avion> filtres = avions.stream()
                .filter(a -> immat == null || containsIgnoreCase(a.getImmatriculation(), immat))
                .filter(a -> modele == null || containsIgnoreCase(a.getModele(), modele))
                .filter(a -> statutParam == null || statutParam.isEmpty() || matchesStatut(a.getStatut(), statutParam))
                .collect(Collectors.toList());

        request.setAttribute("avions", filtres);
        request.setAttribute("statuts", statuts);
        request.setAttribute("immat", request.getParameter("immat"));
        request.setAttribute("modele", request.getParameter("modele"));
        request.setAttribute("statutFiltre", statutParam);
        request.getRequestDispatcher("/jsp/avions/liste.jsp").forward(request, response);
    }

    private static String trimLower(String value) {
        if (value == null) return null;
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed.toLowerCase(Locale.ROOT);
    }

    private static boolean containsIgnoreCase(String source, String needle) {
        return source != null && source.toLowerCase(Locale.ROOT).contains(needle);
    }

    private static boolean matchesStatut(int avionStatut, String statutParam) {
        try {
            int s = Integer.parseInt(statutParam);
            return avionStatut == s;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    private void afficherFormulaireAjouter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<StatutAvion> statuts = StatutAvion.findAll("Statut_Avion");
        request.setAttribute("statuts", statuts);
        request.getRequestDispatcher("/jsp/avions/formulaire.jsp").forward(request, response);
    }

    private void afficherDetailsAvion(HttpServletRequest request, HttpServletResponse response,
            int avionId) throws ServletException, IOException {
        Avion avion = Avion.findAll("Avions").stream()
                .filter(a -> a.getAvion_id() == avionId)
                .findFirst()
                .orElse(null);

        if (avion != null) {
            double moyenne = avion.getMoyenneRemplissage(avionId);
            request.setAttribute("avion", avion);
            request.setAttribute("moyenneRemplissage", moyenne);
            request.getRequestDispatcher("/jsp/avions/details.jsp").forward(request, response);
        } else {
            response.sendError(404, "Avion non trouvé");
        }
    }

    private void ajouterAvion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String immatriculation = request.getParameter("immatriculation");
        String modele = request.getParameter("modele");
        int capaciteEco = Integer.parseInt(request.getParameter("capacite_eco"));
        int capaciteBusiness = Integer.parseInt(request.getParameter("capacite_business"));
        int statut = Integer.parseInt(request.getParameter("statut"));

        Avion avion = new Avion();
        avion.setImmatriculation(immatriculation);
        avion.setModele(modele);
        avion.setCapacite_eco(capaciteEco);
        avion.setCapacite_business(capaciteBusiness);
        avion.setStatut(statut);

        if (avion.save("Avions")) {
            request.setAttribute("message", "Avion ajouté avec succès!");
        } else {
            request.setAttribute("erreur", "Erreur lors de l'ajout");
        }
        listerAvions(request, response);
    }

    private void mettreAJourAvion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int avionId = Integer.parseInt(request.getParameter("avion_id"));
        int statut = Integer.parseInt(request.getParameter("statut"));

        Avion avion = new Avion();
        avion.setAvion_id(avionId);
        avion.setStatut(statut);

        if (avion.update("Avions", "avion_id")) {
            request.setAttribute("message", "Avion mis à jour!");
        } else {
            request.setAttribute("erreur", "Erreur lors de la mise à jour");
        }
        listerAvions(request, response);
    }
}
