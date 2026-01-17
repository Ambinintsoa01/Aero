package com.aero.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.aero.dao.AeroportDAO;
import com.aero.model.Aeroport;

/**
 * Servlet pour la gestion des aéroports
 * URL : /aeroports
 */
@WebServlet("/aeroports")
public class AeroportServlet extends HttpServlet {
    private AeroportDAO aeroportDAO;

    @Override
    public void init() throws ServletException {
        aeroportDAO = new AeroportDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            listAeroports(request, response);
        } else if (action.equals("view")) {
            viewAeroport(request, response);
        } else if (action.equals("edit")) {
            editAeroport(request, response);
        } else if (action.equals("new")) {
            newAeroport(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("save")) {
            saveAeroport(request, response);
        } else if (action.equals("update")) {
            updateAeroport(request, response);
        } else if (action.equals("delete")) {
            deleteAeroport(request, response);
        }
    }

    private void listAeroports(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Aeroport> aeroports = aeroportDAO.findAll();
        request.setAttribute("aeroports", aeroports);
        request.getRequestDispatcher("/jsp/aeroports/list.jsp").forward(request, response);
    }

    private void viewAeroport(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Aeroport aeroport = aeroportDAO.findById(id);
        request.setAttribute("aeroport", aeroport);
        request.getRequestDispatcher("/jsp/aeroports/view.jsp").forward(request, response);
    }

    private void newAeroport(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/aeroports/form.jsp").forward(request, response);
    }

    private void editAeroport(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Aeroport aeroport = aeroportDAO.findById(id);
        request.setAttribute("aeroport", aeroport);
        request.getRequestDispatcher("/jsp/aeroports/form.jsp").forward(request, response);
    }

    private void saveAeroport(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String code = request.getParameter("code");
            String nom = request.getParameter("nom");
            String pays = request.getParameter("pays");
            String ville = request.getParameter("ville");

            Aeroport aeroport = new Aeroport(code, nom, pays, ville);
            aeroportDAO.create(aeroport);

            response.sendRedirect(request.getContextPath() + "/aeroports?message=Aéroport créé");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/aeroports?error=" + e.getMessage());
        }
    }

    private void updateAeroport(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String code = request.getParameter("code");
            String nom = request.getParameter("nom");
            String pays = request.getParameter("pays");
            String ville = request.getParameter("ville");

            Aeroport aeroport = new Aeroport(id, code, nom, pays, ville);
            aeroportDAO.update(aeroport);

            response.sendRedirect(request.getContextPath() + "/aeroports?message=Aéroport mis à jour");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/aeroports?error=" + e.getMessage());
        }
    }

    private void deleteAeroport(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            aeroportDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/aeroports?message=Aéroport supprimé");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/aeroports?error=" + e.getMessage());
        }
    }
}
