package com.aero.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import com.aero.dao.AvionDAO;
import com.aero.dao.BilletDAO;
import com.aero.dao.DetailReservationDAO;
import com.aero.dao.SiegeDAO;
import com.aero.dao.VolPlanifieDAO;
import com.aero.model.Billet;
import com.aero.model.DetailReservation;
import com.aero.model.Siege;
import com.aero.model.VolPlanifie;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet pour la gestion des réservations (billets) RÈGLE MÉTIER :
 * Vérification de la capacité disponible URL : /reservations
 */
@WebServlet("/reservations")
public class ReservationServlet extends HttpServlet {

    private BilletDAO billetDAO;
    private VolPlanifieDAO volPlanifieDAO;
    private AvionDAO avionDAO;
    private SiegeDAO siegeDAO;
    private DetailReservationDAO detailReservationDAO;

    @Override
    public void init() throws ServletException {
        billetDAO = new BilletDAO();
        volPlanifieDAO = new VolPlanifieDAO();
        avionDAO = new AvionDAO();
        siegeDAO = new SiegeDAO();
        detailReservationDAO = new DetailReservationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            listReservations(request, response);
        } else if (action.equals("new")) {
            newReservation(request, response);
        } else if (action.equals("view")) {
            viewReservation(request, response);
        } else if (action.equals("utiliser")) {
            utiliserBillet(request, response);
        } else if (action.equals("annuler")) {
            annulerBillet(request, response);
        } else if (action.equals("rembourser")) {
            rembourserBillet(request, response);
        } else if (action.equals("getVolsByDate")) {
            getVolsByDate(request, response);
        } else if (action.equals("getSieges")) {
            getSieges(request, response);
        } else if (action.equals("getVolDetails")) {
            getVolDetails(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action.equals("reserve")) {
            createReservation(request, response);
        }
    }

    private void listReservations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Billet> billets = billetDAO.findAll();
        request.setAttribute("billets", billets);
        request.getRequestDispatcher("/jsp/reservations/list.jsp").forward(request, response);
    }

    private void newReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/reservations/form.jsp").forward(request, response);
    }

    private void viewReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        long id = Long.parseLong(request.getParameter("id"));
        DetailReservation detail = detailReservationDAO.findByIdBillet(id);

        if (detail == null) {
            // Si pas de détails, charger le billet simple
            Billet billet = billetDAO.findById(id);
            request.setAttribute("billet", billet);
        } else {
            String bouton = "";
            if ("EMIS".equals(detail.getBilletStatus())) {
                bouton = "<a href='" + request.getContextPath() + "/reservations?action=utiliser&id=" + id + "' class='btn'>Utiliser</a>"
                        + "<a href='" + request.getContextPath() + "/reservations?action=annuler&id=" + id + "' class='btn'>Annuler</a>"
                        + "<a href='" + request.getContextPath() + "/reservations?action=rembourser&id=" + id + "' class='btn'>Rembourser</a>";
            }
            request.setAttribute("bouton", bouton);
            request.setAttribute("rembourser", id);
            request.setAttribute("detail", detail);
        }

        request.getRequestDispatcher("/jsp/reservations/view.jsp").forward(request, response);
    }

    private void utiliserBillet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        long id = Long.parseLong(request.getParameter("id"));
        try {
            detailReservationDAO.updateBilletStatus(id, "UTILISE");
            response.sendRedirect(request.getContextPath() + "/reservations?action=view&id=" + id + "&message=Billet utilisé avec succès");
        } catch (SQLException e) {
            response.sendRedirect(request.getContextPath() + "/reservations?action=view&id=" + id + "&error=Erreur lors de l'utilisation du billet: " + e.getMessage());
        }
    }

    private void annulerBillet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        long id = Long.parseLong(request.getParameter("id"));
        try {
            detailReservationDAO.updateBilletStatus(id, "ANNULE");
            response.sendRedirect(request.getContextPath() + "/reservations?action=view&id=" + id + "&message=Billet annulé avec succès");
        } catch (SQLException e) {
            response.sendRedirect(request.getContextPath() + "/reservations?action=view&id=" + id + "&error=Erreur lors de l'annulation du billet: " + e.getMessage());
        }
    }

    private void rembourserBillet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        long id = Long.parseLong(request.getParameter("id"));
        try {
            detailReservationDAO.updateBilletStatus(id, "REMBOURSE");
            response.sendRedirect(request.getContextPath() + "/reservations?action=view&id=" + id + "&message=Billet remboursé avec succès");
        } catch (SQLException e) {
            response.sendRedirect(request.getContextPath() + "/reservations?action=view&id=" + id + "&error=Erreur lors du remboursement du billet: " + e.getMessage());
        }
    }

    /**
     * Récupère les vols pour une date donnée (AJAX)
     */
    private void getVolsByDate(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String dateStr = request.getParameter("date");
            System.out.println("DEBUG: getVolsByDate called with date=" + dateStr);
            LocalDate date = LocalDate.parse(dateStr);
            LocalDateTime startOfDay = date.atStartOfDay();
            LocalDateTime endOfDay = date.atTime(23, 59, 59);

            List<VolPlanifie> vols = volPlanifieDAO.findAll();
            System.out.println("DEBUG: Found " + vols.size() + " total PROGRAMME flights");
            StringBuilder json = new StringBuilder("[");

            boolean first = true;
            for (VolPlanifie vol : vols) {
                LocalDateTime volDate = vol.getDate_reelle_depart();
                System.out.println("DEBUG: Checking flight " + vol.getCode_vol() + " date=" + volDate + " against " + startOfDay + " to " + endOfDay);

                // Vérifier si le vol est le même jour (avec >= et <=)
                if ((volDate.isEqual(startOfDay) || volDate.isAfter(startOfDay))
                        && (volDate.isEqual(endOfDay) || volDate.isBefore(endOfDay))) {
                    System.out.println("DEBUG: Adding flight " + vol.getCode_vol() + " for date " + date);
                    if (!first) {
                        json.append(",");
                    }
                    json.append("{\"id\":").append(vol.getId())
                            .append(",\"codeVol\":\"").append(vol.getCode_vol())
                            .append("\",\"avion\":\"").append(vol.getImmatriculation_avion())
                            .append("\",\"depart\":\"").append(vol.getDate_reelle_depart())
                            .append("\",\"capacite\":").append(vol.getCapacite_avion())
                            .append("}");
                    first = false;
                }
            }
            json.append("]");

            System.out.println("DEBUG: Response JSON: " + json.toString());
            response.setContentType("application/json");
            response.getWriter().write(json.toString());
        } catch (Exception e) {
            response.sendError(500, e.getMessage());
        }
    }

    /**
     * Récupère TOUS les sièges pour un vol et une classe avec leur statut
     * (AJAX)
     */
    private void getSieges(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String volParam = request.getParameter("vol");
            String idVolFilleParam = request.getParameter("idVolFille");
            String classe = request.getParameter("classe");
            int idVolPlanifie = (volParam != null) ? Integer.parseInt(volParam) : Integer.parseInt(idVolFilleParam);

            // Récupérer TOUS les sièges (disponibles et réservés)
            List<Siege> tousLesSieges = siegeDAO.findByIdVolPlanifieWithStatus(idVolPlanifie);
            StringBuilder json = new StringBuilder("[");

            boolean first = true;
            for (Siege siege : tousLesSieges) {
                // Filtrer par classe si fournie
                if (classe != null && !classe.isEmpty() && !classe.equals("ALL")) {
                    if (!siege.getClasse().equals(classe)) {
                        continue;
                    }
                }
                if (!first) {
                    json.append(",");
                }
                json.append("{\"id\":").append(siege.getId())
                        .append(",\"numero\":\"").append(siege.getNumero_siege())
                        .append("\",\"classe\":\"").append(siege.getClasse())
                        .append("\",\"disponible\":").append(siege.isDisponible())
                        .append("}");
                first = false;
            }
            json.append("]");

            response.setContentType("application/json");
            response.getWriter().write(json.toString());
        } catch (Exception e) {
            response.sendError(500, e.getMessage());
        }
    }

    /**
     * Récupère les détails d'un vol (avion, classes, capacité) (AJAX)
     */
    private void getVolDetails(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int idVolPlanifie = Integer.parseInt(request.getParameter("vol"));
            VolPlanifie vol = volPlanifieDAO.findById(idVolPlanifie);

            if (vol == null) {
                response.sendError(404, "Vol non trouvé");
                return;
            }

            // Récupérer TOUS les sièges du vol (pas seulement les disponibles)
            // pour extraire toutes les classes possibles
            List<Siege> tousLesSieges = siegeDAO.findByIdVolPlanifie(idVolPlanifie);
            java.util.Set<String> classesSet = new java.util.HashSet<>();

            if (tousLesSieges != null) {
                for (Siege siege : tousLesSieges) {
                    if (siege.getClasse() != null && !siege.getClasse().isEmpty()) {
                        classesSet.add(siege.getClasse());
                    }
                }
            }

            // Créer le JSON de réponse
            StringBuilder json = new StringBuilder("{");
            json.append("\"id\":").append(vol.getId())
                    .append(",\"codeVol\":\"").append(vol.getCode_vol())
                    .append("\",\"avion\":\"").append(vol.getImmatriculation_avion())
                    .append("\",\"depart\":\"").append(vol.getDate_reelle_depart())
                    .append("\",\"capacite\":").append(vol.getCapacite_avion())
                    .append(",\"classes\":[");

            // Ajouter les classes
            boolean first = true;
            for (String classe : classesSet) {
                if (!first) {
                    json.append(",");
                }
                json.append("\"").append(classe).append("\"");
                first = false;
            }

            json.append("]}");

            System.out.println("DEBUG: getVolDetails - Total sieges: " + (tousLesSieges != null ? tousLesSieges.size() : 0));
            System.out.println("DEBUG: getVolDetails - Classes found: " + classesSet);
            System.out.println("DEBUG: getVolDetails - Response: " + json.toString());

            response.setContentType("application/json");
            response.getWriter().write(json.toString());
        } catch (Exception e) {
            System.out.println("ERROR in getVolDetails: " + e.getMessage());
            e.printStackTrace();
            response.sendError(500, e.getMessage());
        }
    }

    /**
     * Crée une réservation RÈGLE MÉTIER : Vérifier que la capacité de l'avion
     * n'est pas dépassée
     */
    private void createReservation(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int idVolPlanifie = Integer.parseInt(request.getParameter("id_vol_planifie"));
            String classe = request.getParameter("classe");

            // Identifiants transmis par le formulaire (tarif, type passager, classe)
            long idTarif = request.getParameter("id_tarif") != null && !request.getParameter("id_tarif").isEmpty()
                ? Long.parseLong(request.getParameter("id_tarif"))
                : -1L;
            long idTypePassager = request.getParameter("id_type_passager") != null
                && !request.getParameter("id_type_passager").isEmpty()
                    ? Long.parseLong(request.getParameter("id_type_passager"))
                    : 1L; // Par défaut: Adulte
            int idClasse = volPlanifieDAO.findClasseIdByLibelle(classe);

            if (idClasse <= 0) {
                response.sendRedirect(request.getContextPath()
                        + "/reservations?action=new&error=Classe invalide: " + classe);
                return;
            }

            // Récupérer les IDs des sièges (plusieurs possibles)
            String[] idSiegesParam = request.getParameterValues("id_sieges");
            if (idSiegesParam == null || idSiegesParam.length == 0) {
                response.sendRedirect(request.getContextPath()
                        + "/reservations?action=new&error=Veuillez sélectionner au moins un siège");
                return;
            }

            // Convertir en liste de long
            long[] idSieges = new long[idSiegesParam.length];
            for (int i = 0; i < idSiegesParam.length; i++) {
                idSieges[i] = Long.parseLong(idSiegesParam[i]);
            }

            // Récupérer le vol planifié et l'avion pour vérifier la capacité
            VolPlanifie volPlanifie = volPlanifieDAO.findById(idVolPlanifie);
            int placesDisponibles = avionDAO.getPlacesDisponibles(idVolPlanifie);
            int siegesDisponiblesClasse = siegeDAO.countSiegesDisponibles(idVolPlanifie, classe);

            // Résoudre le tarif applicable pour le vol + classe (et récupérer son prix)
            VolPlanifieDAO.TarifInfo tarifInfo = volPlanifieDAO.findTarifByVolAndClasse(idVolPlanifie, idClasse);
            if (tarifInfo == null) {
                response.sendRedirect(request.getContextPath()
                        + "/reservations?action=new&error=Tarif introuvable pour ce vol et cette classe");
                return;
            }
            if (idTarif <= 0) {
                idTarif = tarifInfo.getId();
            }
            double prixTarif = tarifInfo.getPrix();

            // Vérifier l'existence d'une remise pour ce couple (tarif, type_passager)
            Double remiseValue = volPlanifieDAO.findRemiseValue(idTarif, idTypePassager);
            Double prixAppliqueDouble = null;
            boolean remiseAppliquee = false;

            if (remiseValue != null) {
                // Remise fixe (newValue)
                prixAppliqueDouble = remiseValue;
                remiseAppliquee = true;
            } else {
                // Essayer une remise en pourcentage
                Double prixPourcentage = volPlanifieDAO.calculTarifPourcentage(idTarif, idTypePassager);
                if (prixPourcentage != null) {
                    prixAppliqueDouble = prixPourcentage;
                    remiseAppliquee = true;
                } else {
                    prixAppliqueDouble = prixTarif;
                }
            }
            double prixApplique = prixAppliqueDouble;

            if (placesDisponibles < idSieges.length || siegesDisponiblesClasse < idSieges.length) {
                response.sendRedirect(request.getContextPath()
                        + "/reservations?action=new&error=Capacité insuffisante pour ce vol (" + idSieges.length + " sièges demandés)");
                return;
            }

            // Récupérer les informations passager
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            LocalDate date_naissance = LocalDate.parse(request.getParameter("date_naissance"));
            String nationalite = request.getParameter("nationalite");
            String email = request.getParameter("email");
            String telephone = request.getParameter("telephone");

            // Créer un billet et une réservation pour CHAQUE siège sélectionné
            int successCount = 0;
            StringBuilder siegesReserves = new StringBuilder();

            for (long idSiege : idSieges) {
                try {
                    // Créer un billet unique pour chaque siège
                    String numero_billet = "BIL" + System.currentTimeMillis() + "_" + successCount;

                    Billet billet = new Billet(
                            numero_billet, idTarif, idTypePassager,
                            nom, prenom, date_naissance, nationalite, null, // numero_passport auto-généré
                            email, telephone, LocalDate.now(), "EMIS"
                    );

                    Billet billetCreated = billetDAO.create(billet);

                    // Vérifier que le billet a bien été créé
                    if (billetCreated == null || billetCreated.getId() == 0) {
                        continue; // Passer au siège suivant en cas d'erreur
                    }

                    // Ajouter la réservation de siège
                    boolean reservationCreated = siegeDAO.addReservationSiege(billetCreated.getId(), idSiege, idVolPlanifie);

                    if (reservationCreated) {
                        Siege siege = siegeDAO.findById(idSiege);
                        if (successCount > 0) {
                            siegesReserves.append(", ");
                        }
                        siegesReserves.append(siege.getNumero_siege());
                        successCount++;
                    }
                } catch (SQLException e) {
                    System.err.println("Erreur lors de la création du billet pour le siège " + idSiege + ": " + e.getMessage());
                    continue;
                }
            }

            if (successCount > 0) {
                response.sendRedirect(request.getContextPath()
                        + "/reservations?message=" + successCount + " réservation(s) effectuée(s) avec succès! Sièges: "
                        + siegesReserves.toString()
                        + ". Tarif appliqué: " + (long) prixApplique + " Ar"
                        + (remiseAppliquee ? " (remise détectée)" : "")
                        + ". Places restantes: " + (placesDisponibles - successCount));
            } else {
                response.sendRedirect(request.getContextPath()
                        + "/reservations?action=new&error=Erreur lors de la réservation des sièges");
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/reservations?action=new&error=" + e.getMessage());
        }
    }

}
