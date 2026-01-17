package com.aero.servlet;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import com.aero.dao.AvionDAO;
import com.aero.dao.VolDAO;
import com.aero.dao.VolPlanifieDAO;
import com.aero.model.Avion;
import com.aero.model.Vol;
import com.aero.model.VolPlanifie;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet pour la gestion des vols planifiés URL : /volsPlanifies
 */
@WebServlet("/volsPlanifies")
public class VolPlanifieServlet extends HttpServlet {

    private VolPlanifieDAO volPlanifieDAO;
    private VolDAO volDAO;
    private AvionDAO avionDAO;

    @Override
    public void init() throws ServletException {
        volPlanifieDAO = new VolPlanifieDAO();
        volDAO = new VolDAO();
        avionDAO = new AvionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            listVolsPlanifies(request, response);
        } else if (action.equals("view")) {
            viewVolPlanifie(request, response);
        } else if (action.equals("edit")) {
            editVolPlanifie(request, response);
        } else if (action.equals("new")) {
            newVolPlanifie(request, response);
        } else if (action.equals("reserver")) {
            reserverVolPlanifie(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("save")) {
            saveVolPlanifie(request, response);
        } else if (action.equals("update")) {
            updateVolPlanifie(request, response);
        }
    }

    private void reserverVolPlanifie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idVol = Integer.parseInt(request.getParameter("idVol"));
        LocalDateTime date = LocalDateTime.parse(request.getParameter("date"));
        request.setAttribute("idVol", idVol);
        request.setAttribute("date", date);
        response.sendRedirect(request.getContextPath() + "/reservations?action=new");
    }

    private void listVolsPlanifies(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<VolPlanifie> volsPlanifies = volPlanifieDAO.findAll();
        
        // Enrichir chaque vol avec les places disponibles
        if (volsPlanifies != null) {
            for (VolPlanifie vol : volsPlanifies) {
                int placesDisponibles = avionDAO.getPlacesDisponibles(vol.getId());
                vol.setCapacite_avion(placesDisponibles);
            }
        }
        
        request.setAttribute("volsPlanifies", volsPlanifies);
        request.getRequestDispatcher("/jsp/volsPlanifies/list.jsp").forward(request, response);
    }

    private void viewVolPlanifie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            VolPlanifie volPlanifie = volPlanifieDAO.findById(id);

            // Vérification que le vol existe
            if (volPlanifie == null) {
                request.setAttribute("volPlanifie", null);
                request.getRequestDispatcher("/jsp/volsPlanifies/view.jsp").forward(request, response);
                return;
            }

            // Récupération dynamique des informations de toutes les classes
            List<Map<String, Object>> classesInfos = volPlanifieDAO.getClassesInfos(id);
            
            // Calcul du revenu maximal
            double revenuMax = 0;
            for (Map<String, Object> classeInfo : classesInfos) {
                int nbPlace = (Integer) classeInfo.get("nb_sieges");
                double tarif = (Double) classeInfo.get("tarif");
                revenuMax += nbPlace * tarif;
            }
            
            // Calcul du CA réel généré (avec remises appliquées)
            double caReel = volPlanifieDAO.calculateCAReel(id);
            List<Map<String, Object>> billetsDetail = volPlanifieDAO.getBilletsDetail(id);

            // Récupérer les remises en pourcentage configurées pour chaque classe/tarif
            java.util.Map<Integer, List<java.util.Map<String, Object>>> remisesPourClasse = new java.util.HashMap<>();
            if (classesInfos != null) {
                for (Map<String, Object> classeInfo : classesInfos) {
                    Integer idClasse = (Integer) classeInfo.get("id_classe");
                    // trouver le tarif en vigueur pour cette vol+classe
                    VolPlanifieDAO.TarifInfo tinfo = volPlanifieDAO.findTarifByVolAndClasse(id, idClasse);
                    if (tinfo != null) {
                        List<com.aero.dao.VolPlanifieDAO.RemisePourcentageInfo> remises = volPlanifieDAO.getRemisesPourTarif(tinfo.getId());
                        List<java.util.Map<String, Object>> remisesMap = new java.util.ArrayList<>();
                        if (remises != null) {
                            for (com.aero.dao.VolPlanifieDAO.RemisePourcentageInfo r : remises) {
                                java.util.Map<String, Object> m = new java.util.HashMap<>();
                                m.put("id", (int) r.getId());
                                m.put("idTarif", (int) r.getIdTarif());
                                m.put("idTypePassager", (int) r.getIdTypePassager());
                                m.put("idTypePassagerOrigine", (int) r.getIdTypePassagerOrigine());
                                m.put("pourcentage", r.getPourcentage());
                                remisesMap.add(m);
                            }
                        }
                        remisesPourClasse.put(idClasse, remisesMap);
                    }
                }
            }
            
            request.setAttribute("classesInfos", classesInfos);
            request.setAttribute("revenuMaximal", revenuMax);
            request.setAttribute("caReel", caReel);
            request.setAttribute("billetsDetail", billetsDetail);
            request.setAttribute("remisesPourClasse", remisesPourClasse);
            request.setAttribute("volPlanifie", volPlanifie);
            request.getRequestDispatcher("/jsp/volsPlanifies/view.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors de la récupération du vol: " + e.getMessage());
            request.setAttribute("volPlanifie", null);
            request.getRequestDispatcher("/jsp/volsPlanifies/view.jsp").forward(request, response);
        }
    }

    private void newVolPlanifie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Vol> vols = volDAO.findAll();
        List<Avion> avions = avionDAO.findAll();
        request.setAttribute("vols", vols);
        request.setAttribute("avions", avions);
        request.getRequestDispatcher("/jsp/volsPlanifies/form.jsp").forward(request, response);
    }

    private void editVolPlanifie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        VolPlanifie volPlanifie = volPlanifieDAO.findById(id);
        List<Vol> vols = volDAO.findAll();
        List<Avion> avions = avionDAO.findAll();
        request.setAttribute("volPlanifie", volPlanifie);
        request.setAttribute("vols", vols);
        request.setAttribute("avions", avions);
        request.getRequestDispatcher("/jsp/volsPlanifies/form.jsp").forward(request, response);
    }

    private void saveVolPlanifie(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id_vol_mere = Integer.parseInt(request.getParameter("id_vol_mere"));
            int id_avion = Integer.parseInt(request.getParameter("id_avion"));
            LocalDateTime date_reelle_depart = LocalDateTime.parse(
                    request.getParameter("date_reelle_depart").replace(" ", "T"));
            LocalDateTime date_reelle_arrivee = LocalDateTime.parse(
                    request.getParameter("date_reelle_arrivee").replace(" ", "T"));

            VolPlanifie volPlanifie = new VolPlanifie(
                    id_vol_mere, id_avion, null, null, date_reelle_depart, date_reelle_arrivee,
                    "PROGRAMME", LocalDateTime.now(), LocalDateTime.now()
            );
            volPlanifieDAO.create(volPlanifie);
            
            // Sauvegarder les tarifs
            double tarifPremiere = Double.parseDouble(request.getParameter("tarif_premiere_classe"));
            double tarifEco = Double.parseDouble(request.getParameter("tarif_economique"));
            int id_class_premiere = 2;
            int id_class_eco = 1;
            
            volPlanifieDAO.saveTarif(id_avion, id_class_premiere, tarifPremiere);
            volPlanifieDAO.saveTarif(id_avion, id_class_eco, tarifEco);

            response.sendRedirect(request.getContextPath() + "/volsPlanifies?message=Vol planifié créé");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/volsPlanifies?error=" + e.getMessage());
        }
    }

    private void updateVolPlanifie(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            VolPlanifie volPlanifie = volPlanifieDAO.findById(id);
            volPlanifie.setStatus(status);
            volPlanifie.setDate_modification(LocalDateTime.now());
            volPlanifieDAO.update(volPlanifie);

            response.sendRedirect(request.getContextPath() + "/volsPlanifies?message=Vol mis à jour");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/volsPlanifies?error=" + e.getMessage());
        }
    }
}
