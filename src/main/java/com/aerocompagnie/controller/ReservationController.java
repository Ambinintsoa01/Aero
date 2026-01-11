package com.aerocompagnie.controller;

import com.aerocompagnie.dto.VolDisponibleDTO;
import com.aerocompagnie.model.Aeroport;
import com.aerocompagnie.model.InstanceVol;
import com.aerocompagnie.model.Passager;
import com.aerocompagnie.model.Reservation;
import com.aerocompagnie.model.SeatInfo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@WebServlet("/reservations/*")
public class ReservationController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            listerReservations(request, response);
        } else if (pathInfo.equals("/nouveau")) {
            afficherFormulaireCreer(request, response);
        } else if (pathInfo.startsWith("/details/")) {
            String reservationId = pathInfo.substring("/details/".length());
            afficherDetailsReservation(request, response, Integer.parseInt(reservationId));
        } else if (pathInfo.equals("/complet")) {
            afficherFormulaireComplet(request, response);
        } else if (pathInfo.equals("/recherche")) {
            rechercherVols(request, response);
        } else if (pathInfo.equals("/reserver")) {
            afficherFormulaireReserver(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("creer".equals(action)) {
            creerReservation(request, response);
        } else if ("annuler".equals(action)) {
            annulerReservation(request, response);
        } else if ("generer_pdf".equals(action)) {
            genererBilletPDF(request, response);
        } else if ("creation_complet".equals(action)) {
            creerReservationComplet(request, response);
        }
    }

    private void listerReservations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Reservation> reservations = Reservation.findAll("Reservations");

        String pnr = trimLower(request.getParameter("pnr"));
        String statut = trimLower(request.getParameter("statut"));
        String passagerIdParam = request.getParameter("passager_id");
        String dateFromParam = request.getParameter("date_from");
        String dateToParam = request.getParameter("date_to");

        Integer passagerId = parseIntOrNull(passagerIdParam);
        LocalDate dateFrom = parseDate(dateFromParam);
        LocalDate dateTo = parseDate(dateToParam);

        List<Reservation> filtres = reservations.stream()
                .filter(r -> pnr == null || containsIgnoreCase(r.getPnr(), pnr))
                .filter(r -> statut == null || containsIgnoreCase(r.getStatut_paiement(), statut))
                .filter(r -> passagerId == null || r.getPassager_id() == passagerId)
                .filter(r -> dateFrom == null || (r.getDate_reservation() != null && !r.getDate_reservation().toLocalDate().isBefore(dateFrom)))
                .filter(r -> dateTo == null || (r.getDate_reservation() != null && !r.getDate_reservation().toLocalDate().isAfter(dateTo)))
                .collect(Collectors.toList());

        request.setAttribute("reservations", filtres);
        request.setAttribute("pnr", request.getParameter("pnr"));
        request.setAttribute("statutFiltre", request.getParameter("statut"));
        request.setAttribute("passagerFiltre", passagerIdParam);
        request.setAttribute("dateFrom", dateFromParam);
        request.setAttribute("dateTo", dateToParam);
        request.getRequestDispatcher("/jsp/reservations/liste.jsp").forward(request, response);
    }

    private void afficherFormulaireCreer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Passager> passagers = Passager.findAll("Passagers");
        List<InstanceVol> instances = InstanceVol.findAll("Instances_Vols");
        request.setAttribute("passagers", passagers);
        request.setAttribute("instances", instances);
        request.getRequestDispatcher("/jsp/reservations/formulaire.jsp").forward(request, response);
    }

    private void afficherFormulaireComplet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Passager> passagers = Passager.findAll("Passagers");
        List<InstanceVol> instances = InstanceVol.findAll("Instances_Vols");
        request.setAttribute("passagers", passagers);
        request.setAttribute("instances", instances);
        request.getRequestDispatcher("/jsp/reservations/formulaireComplet.jsp").forward(request, response);
    }

    private void afficherDetailsReservation(HttpServletRequest request, HttpServletResponse response,
            int reservationId) throws ServletException, IOException {
        List<Reservation> reservations = Reservation.findAll("Reservations");
        Reservation reservation = reservations.stream()
                .filter(r -> r.getReservation_id() == reservationId)
                .findFirst()
                .orElse(null);

        if (reservation != null) {
            request.setAttribute("reservation", reservation);
            request.getRequestDispatcher("/jsp/reservations/details.jsp").forward(request, response);
        } else {
            response.sendError(404, "Réservation non trouvée");
        }
    }

    private void creerReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int passagerId = Integer.parseInt(request.getParameter("passager_id"));
        String instanceIdsParam = request.getParameter("instance_ids");
        
        List<Integer> instanceIds = Arrays.stream(instanceIdsParam.split(","))
                .map(String::trim)
                .map(Integer::parseInt)
                .collect(Collectors.toList());

        Reservation reservation = new Reservation();
        String pnr = reservation.creerReservation(passagerId, instanceIds);

        if (pnr != null) {
            request.setAttribute("message", "Réservation créée! PNR: " + pnr);
        } else {
            request.setAttribute("erreur", "Erreur: pas de sièges disponibles ou données invalides");
        }
        listerReservations(request, response);
    }

    private void creerReservationComplet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int passagerId = Integer.parseInt(request.getParameter("passager_id"));
        String instanceIdsParam = request.getParameter("instance_ids");
        LocalDateTime date_reservation = LocalDateTime.parse(request.getParameter("date_reservation"));
        int classe = Integer.parseInt(request.getParameter("classe"));
        String siegeAssigne = request.getParameter("siege_assigne");
        
        List<Integer> instanceIds = Arrays.stream(instanceIdsParam.split(","))
                .map(String::trim)
                .map(Integer::parseInt)
                .collect(Collectors.toList());

        Reservation reservation = new Reservation();
        String pnr = reservation.creerReservationComplet(passagerId, instanceIds, date_reservation, classe, siegeAssigne);

        if (pnr != null) {
            request.setAttribute("message", "Réservation créée! PNR: " + pnr);
        } else {
            request.setAttribute("erreur", "Erreur: pas de sièges disponibles ou données invalides");
        }
        listerReservations(request, response); 
    }

    private void annulerReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int reservationId = Integer.parseInt(request.getParameter("reservation_id"));

        Reservation reservation = new Reservation();
        reservation.setReservation_id(reservationId);

        if (reservation.annulerReservation("Reservations", "reservation_id")) {
            request.setAttribute("message", "Réservation annulée!");
        } else {
            request.setAttribute("erreur", "Erreur lors de l'annulation");
        }
        listerReservations(request, response);
    }

    private void genererBilletPDF(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int reservationId = Integer.parseInt(request.getParameter("reservation_id"));

        Reservation reservation = new Reservation();
        if (reservation.genererBilletPDF(reservationId)) {
            request.setAttribute("message", "Billet généré avec succès!");
            // TODO: envoyer le PDF au client
        } else {
            request.setAttribute("erreur", "Erreur lors de la génération du billet");
        }
        afficherDetailsReservation(request, response, reservationId);
    }

    private static String trimLower(String value) {
        if (value == null) return null;
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed.toLowerCase(Locale.ROOT);
    }

    private static boolean containsIgnoreCase(String source, String needle) {
        return source != null && source.toLowerCase(Locale.ROOT).contains(needle);
    }

    private static Integer parseIntOrNull(String value) {
        if (value == null || value.trim().isEmpty()) return null;
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private static LocalDate parseDate(String value) {
        if (value == null || value.trim().isEmpty()) return null;
        try {
            return LocalDate.parse(value.trim());
        } catch (Exception e) {
            return null;
        }
    }

    private void rechercherVols(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Aeroport> aeroports = Aeroport.findAll("Aeroports");
        request.setAttribute("aeroports", aeroports);

        String aeroportDepartCode = request.getParameter("aeroport_depart");
        String aeroportArriveeCode = request.getParameter("aeroport_arrivee");
        String dateStr = request.getParameter("date_depart");
        String heureStr = request.getParameter("heure_depart");

        if (aeroportDepartCode != null && aeroportArriveeCode != null && dateStr != null) {
            LocalDate dateDepart = LocalDate.parse(dateStr);
            LocalTime heureDepart = heureStr != null && !heureStr.trim().isEmpty() 
                ? LocalTime.parse(heureStr) 
                : LocalTime.MIDNIGHT;

            List<VolDisponibleDTO> vols = rechercherVolsDisponibles(
                aeroportDepartCode, 
                aeroportArriveeCode, 
                dateDepart, 
                heureDepart
            );
            request.setAttribute("vols", vols);
            request.setAttribute("recherche_effectuee", true);
        }

        request.setAttribute("aeroportDepartCode", aeroportDepartCode);
        request.setAttribute("aeroportArriveeCode", aeroportArriveeCode);
        request.setAttribute("dateDepart", dateStr);
        request.setAttribute("heureDepart", heureStr);
        
        request.getRequestDispatcher("/jsp/reservations/rechercheVol.jsp").forward(request, response);
    }

    private List<VolDisponibleDTO> rechercherVolsDisponibles(String aeroportDepart, String aeroportArrivee, 
                                                              LocalDate dateDepart, LocalTime heureDepart) {
        List<VolDisponibleDTO> volsDisponibles = new ArrayList<>();
        
        String sql = "SELECT iv.instance_id, v.numero_vol, a.avion_id, " +
                     "ad.code AS depart_code, ad.nom AS depart_nom, " +
                     "aa.code AS arrivee_code, aa.nom AS arrivee_nom, " +
                     "iv.date_depart_reel, sv.heure_depart_utc, sv.heure_arrivee_utc, " +
                     "a.immatriculation, a.modele, iv.prix " +
                     "FROM Instances_Vols iv " +
                     "JOIN Segments_Vol sv ON iv.segment_id = sv.segment_id " +
                     "JOIN Vols v ON sv.vol_id = v.vol_id " +
                     "JOIN Aeroports ad ON sv.aeroport_depart = ad.code " +
                     "JOIN Aeroports aa ON sv.aeroport_arrivee = aa.code " +
                     "JOIN Avions a ON iv.avion_id = a.avion_id " +
                     "WHERE ad.code = ? AND aa.code = ? " +
                     "AND iv.date_depart_reel = ? " +
                     "AND sv.heure_depart_utc >= ? " +
                     "AND iv.etat = 'planifié' " +
                     "ORDER BY sv.heure_depart_utc";

        try (Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/compagnie_aerienne", "postgres", "eto")) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, aeroportDepart);
            stmt.setString(2, aeroportArrivee);
            stmt.setDate(3, java.sql.Date.valueOf(dateDepart));
            stmt.setTime(4, java.sql.Time.valueOf(heureDepart));

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int instanceId = rs.getInt("instance_id");
                int avionId = rs.getInt("avion_id");
                InstanceVol instance = new InstanceVol();
                instance.setInstance_id(instanceId);
                SeatInfo seatInfo = instance.getSeatInfo(instanceId, avionId);
                if (seatInfo == null) {
                    continue; // skip if seat info unavailable
                }

                VolDisponibleDTO vol = new VolDisponibleDTO();
                vol.setInstanceId(instanceId);
                vol.setNumeroVol(rs.getString("numero_vol"));
                vol.setAeroportDepart(rs.getString("depart_code") + " - " + rs.getString("depart_nom"));
                vol.setAeroportArrivee(rs.getString("arrivee_code") + " - " + rs.getString("arrivee_nom"));
                vol.setDateDepart(rs.getDate("date_depart_reel").toLocalDate());
                vol.setHeureDepart(rs.getTime("heure_depart_utc").toLocalTime());
                vol.setHeureArrivee(rs.getTime("heure_arrivee_utc").toLocalTime());
                vol.setAvionImmat(rs.getString("immatriculation"));
                vol.setAvionModele(rs.getString("modele"));
                vol.setPlacesEco(seatInfo.getAvailableEco());
                vol.setPlacesBusiness(seatInfo.getAvailableBusiness());
                vol.setPrix(rs.getBigDecimal("prix"));

                if (seatInfo.getAvailableEco() > 0 || seatInfo.getAvailableBusiness() > 0) {
                    volsDisponibles.add(vol);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return volsDisponibles;
    }

    private void afficherFormulaireReserver(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String instanceIdParam = request.getParameter("instance_id");
        if (instanceIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/reservations/recherche");
            return;
        }

        int instanceId = Integer.parseInt(instanceIdParam);
        List<Passager> passagers = Passager.findAll("Passagers");
        
        request.setAttribute("passagers", passagers);
        request.setAttribute("instanceId", instanceId);
        request.getRequestDispatcher("/jsp/reservations/formulaireReserver.jsp").forward(request, response);
    }
}
