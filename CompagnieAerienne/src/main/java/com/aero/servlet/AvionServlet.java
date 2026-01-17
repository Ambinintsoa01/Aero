package com.aero.servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import com.aero.dao.AvionDAO;
import com.aero.model.Avion;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet pour la gestion des avions
 * URL : /avions
 */
@WebServlet("/avions")
public class AvionServlet extends HttpServlet {
    private AvionDAO avionDAO;

    @Override
    public void init() throws ServletException {
        avionDAO = new AvionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            listAvions(request, response);
        } else if (action.equals("view")) {
            viewAvion(request, response);
        } else if (action.equals("edit")) {
            editAvion(request, response);
        } else if (action.equals("new")) {
            newAvion(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("save")) {
            saveAvion(request, response);
        } else if (action.equals("update")) {
            updateAvion(request, response);
        } else if (action.equals("delete")) {
            deleteAvion(request, response);
        }
    }

    private void listAvions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Avion> avions = avionDAO.findAll();
        request.setAttribute("avions", avions);
        request.getRequestDispatcher("/jsp/avions/list.jsp").forward(request, response);
    }

    private void viewAvion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Avion avion = avionDAO.findById(id);
        
        // Récupérer les informations de sièges et revenu
        int[] siegesParClasse = avionDAO.countSiegesByClasse(id);
        long revenuMaximal = avionDAO.calculateRevenuMaximal(id);
        
        request.setAttribute("avion", avion);
        request.setAttribute("nbPremiereClasse", siegesParClasse[0]);
        request.setAttribute("nbEconomique", siegesParClasse[1]);
        request.setAttribute("revenuMaximal", revenuMaximal);
        
        request.getRequestDispatcher("/jsp/avions/view.jsp").forward(request, response);
    }

    private void newAvion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/avions/form.jsp").forward(request, response);
    }

    private void editAvion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Avion avion = avionDAO.findById(id);
        request.setAttribute("avion", avion);
        request.getRequestDispatcher("/jsp/avions/form.jsp").forward(request, response);
    }

    private void saveAvion(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String immatriculation = request.getParameter("immatriculation");
            String modele = request.getParameter("modele");
            String constructeur = request.getParameter("constructeur");
            int capacite = Integer.parseInt(request.getParameter("capacite"));
            int annee = Integer.parseInt(request.getParameter("annee_fabrication"));
            LocalDate date = LocalDate.parse(request.getParameter("date_mise_service"));

            Avion avion = new Avion(immatriculation, modele, constructeur, capacite, annee, date);
            avionDAO.create(avion);

            response.sendRedirect(request.getContextPath() + "/avions?message=Avion créé avec succès");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/avions?error=" + e.getMessage());
        }
    }

    private void updateAvion(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String immatriculation = request.getParameter("immatriculation");
            String modele = request.getParameter("modele");
            String constructeur = request.getParameter("constructeur");
            int capacite = Integer.parseInt(request.getParameter("capacite"));
            int annee = Integer.parseInt(request.getParameter("annee_fabrication"));
            LocalDate date = LocalDate.parse(request.getParameter("date_mise_service"));

            Avion avion = new Avion(id, immatriculation, modele, constructeur, capacite, annee, date);
            avionDAO.update(avion);

            response.sendRedirect(request.getContextPath() + "/avions?message=Avion mis à jour");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/avions?error=" + e.getMessage());
        }
    }

    private void deleteAvion(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            avionDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/avions?message=Avion supprimé");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/avions?error=" + e.getMessage());
        }
    }
}
