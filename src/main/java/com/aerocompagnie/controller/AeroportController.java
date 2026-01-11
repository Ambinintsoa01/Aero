package com.aerocompagnie.controller;

import com.aerocompagnie.model.Aeroport;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@WebServlet("/aeroports/*")
public class AeroportController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            listerAeroports(request, response);
        } else if (pathInfo.equals("/nouveau")) {
            afficherFormulaireAjouter(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("ajouter".equals(action)) {
            ajouterAeroport(request, response);
        } else if ("supprimer".equals(action)) {
            supprimerAeroport(request, response);
        }
    }

    private void listerAeroports(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Aeroport> aeroports = Aeroport.findAll("Aeroports");

            String code = trimLower(request.getParameter("code"));
            String nom = trimLower(request.getParameter("nom"));
            String ville = trimLower(request.getParameter("ville"));
            String pays = trimLower(request.getParameter("pays"));

            List<Aeroport> filtres = aeroports.stream()
                    .filter(a -> code == null || containsIgnoreCase(a.getCode_iata(), code))
                    .filter(a -> nom == null || containsIgnoreCase(a.getNom(), nom))
                    .filter(a -> ville == null || containsIgnoreCase(a.getVille(), ville))
                    .filter(a -> pays == null || containsIgnoreCase(a.getPays(), pays))
                    .collect(Collectors.toList());

            request.setAttribute("aeroports", filtres);
            request.setAttribute("code", request.getParameter("code"));
            request.setAttribute("nom", request.getParameter("nom"));
            request.setAttribute("ville", request.getParameter("ville"));
            request.setAttribute("pays", request.getParameter("pays"));
            request.getRequestDispatcher("/jsp/aeroports/liste.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Erreur dans listerAeroports: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors du chargement: " + e.getMessage());
            request.getRequestDispatcher("/jsp/aeroports/liste.jsp").forward(request, response);
        }
    }

    private void afficherFormulaireAjouter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/aeroports/formulaire.jsp").forward(request, response);
    }

    private void ajouterAeroport(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String codeIata = request.getParameter("code_iata");
        String nom = request.getParameter("nom");
        String ville = request.getParameter("ville");
        String pays = request.getParameter("pays");
        String fuseauHoraire = request.getParameter("fuseau_horaire");

        Aeroport aero = new Aeroport();
        aero.setCode_iata(codeIata);
        aero.setNom(nom);
        aero.setVille(ville);
        aero.setPays(pays);
        aero.setFuseau_horaire(fuseauHoraire);

        if (aero.save("Aeroports")) {
            request.setAttribute("message", "Aéroport ajouté avec succès!");
        } else {
            request.setAttribute("erreur", "Erreur lors de l'ajout de l'aéroport");
        }
        listerAeroports(request, response);
    }

    private void supprimerAeroport(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String codeIata = request.getParameter("code_iata");

        if (Aeroport.delete(codeIata, "Aeroports")) {
            request.setAttribute("message", "Aéroport supprimé avec succès!");
        } else {
            request.setAttribute("erreur", "Erreur lors de la suppression");
        }
        listerAeroports(request, response);
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
