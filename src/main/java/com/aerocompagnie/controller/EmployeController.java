package com.aerocompagnie.controller;

import com.aerocompagnie.model.Employe;
import com.aerocompagnie.model.RoleEmploye;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@WebServlet("/employes/*")
public class EmployeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            listerEmployes(request, response);
        } else if (pathInfo.equals("/nouveau")) {
            afficherFormulaireAjouter(request, response);
        } else if (pathInfo.startsWith("/planning/")) {
            String employeId = pathInfo.substring("/planning/".length());
            afficherPlanning(request, response, Integer.parseInt(employeId));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("ajouter".equals(action)) {
            ajouterEmploye(request, response);
        }
    }

    private void listerEmployes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Employe> employes = Employe.findAll("Employes");
        List<RoleEmploye> roles = RoleEmploye.findAll("Role_employe");

        String nom = trimLower(request.getParameter("nom"));
        String prenom = trimLower(request.getParameter("prenom"));
        String role = trimLower(request.getParameter("role"));
        String specialisation = trimLower(request.getParameter("specialisation"));

        List<Employe> filtres = employes.stream()
                .filter(e -> nom == null || containsIgnoreCase(e.getNom(), nom))
                .filter(e -> prenom == null || containsIgnoreCase(e.getPrenom(), prenom))
                .filter(e -> role == null || roleMatches(e, role))
                .filter(e -> specialisation == null || containsIgnoreCase(e.getSpecialisation(), specialisation))
                .collect(Collectors.toList());

        request.setAttribute("employes", filtres);
        request.setAttribute("roles", roles);
        request.setAttribute("nom", request.getParameter("nom"));
        request.setAttribute("prenom", request.getParameter("prenom"));
        request.setAttribute("roleFilter", request.getParameter("role"));
        request.setAttribute("specialisation", request.getParameter("specialisation"));
        request.getRequestDispatcher("/jsp/employes/liste.jsp").forward(request, response);
    }

    private void afficherFormulaireAjouter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<RoleEmploye> roles = RoleEmploye.findAll("Role_employe");
        request.setAttribute("roles", roles);
        request.getRequestDispatcher("/jsp/employes/formulaire.jsp").forward(request, response);
    }

    private void afficherPlanning(HttpServletRequest request, HttpServletResponse response,
            int employeId) throws ServletException, IOException {
        Employe employe = Employe.findAll("Employes").stream()
                .filter(e -> e.getEmploye_id() == employeId)
                .findFirst()
                .orElse(null);

        if (employe != null) {
            List<String> planning = employe.getPlanning(employeId);
            int heuresMois = employe.calculerHeuresVolMensuelles(employeId, 
                    java.time.LocalDate.now().getMonthValue());
            request.setAttribute("employe", employe);
            request.setAttribute("planning", planning);
            request.setAttribute("heuresMois", heuresMois);
            request.getRequestDispatcher("/jsp/employes/planning.jsp").forward(request, response);
        } else {
            response.sendError(404, "Employé non trouvé");
        }
    }

    private void ajouterEmploye(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        int role = Integer.parseInt(request.getParameter("role"));
        String specialisation = request.getParameter("specialisation");

        Employe employe = new Employe();
        employe.setNom(nom);
        employe.setPrenom(prenom);
        employe.setRole(role);
        employe.setSpecialisation(specialisation);
        employe.setHeures_vol_mois(200); // Valeur par défaut

        if (employe.save("Employes")) {
            request.setAttribute("message", "Employé ajouté avec succès!");
        } else {
            request.setAttribute("erreur", "Erreur lors de l'ajout");
        }
        listerEmployes(request, response);
    }

    private static String trimLower(String value) {
        if (value == null) return null;
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed.toLowerCase(Locale.ROOT);
    }

    private static boolean containsIgnoreCase(String source, String needle) {
        return source != null && source.toLowerCase(Locale.ROOT).contains(needle);
    }

    private static boolean roleMatches(Employe employe, String role) {
        if (employe == null || role == null) return false;
        List<RoleEmploye> allRoles = RoleEmploye.findAll("Role_employe");
        return allRoles.stream()
                .filter(r -> r.getRole_id() == employe.getRole())
                .anyMatch(r -> containsIgnoreCase(r.getRole_nom(), role));
    }
}
