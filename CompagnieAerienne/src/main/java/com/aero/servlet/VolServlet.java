package com.aero.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.aero.dao.AeroportDAO;
import com.aero.dao.VolDAO;
import com.aero.model.Aeroport;
import com.aero.model.Vol;

/**
 * Servlet pour la gestion des vols (trajets)
 * URL : /vols
 */
@WebServlet("/vols")
public class VolServlet extends HttpServlet {
    private VolDAO volDAO;
    private AeroportDAO aeroportDAO;

    @Override
    public void init() throws ServletException {
        volDAO = new VolDAO();
        aeroportDAO = new AeroportDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            listVols(request, response);
        } else if (action.equals("view")) {
            viewVol(request, response);
        } else if (action.equals("edit")) {
            editVol(request, response);
        } else if (action.equals("new")) {
            newVol(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("save")) {
            saveVol(request, response);
        } else if (action.equals("update")) {
            updateVol(request, response);
        } else if (action.equals("delete")) {
            deleteVol(request, response);
        }
    }

    private void listVols(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Vol> vols = volDAO.findAll();
        request.setAttribute("vols", vols);
        request.getRequestDispatcher("/jsp/vols/list.jsp").forward(request, response);
    }

    private void viewVol(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Vol vol = volDAO.findById(id);
        request.setAttribute("vol", vol);
        request.getRequestDispatcher("/jsp/vols/view.jsp").forward(request, response);
    }

    private void newVol(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Aeroport> aeroports = aeroportDAO.findAll();
        request.setAttribute("aeroports", aeroports);
        request.getRequestDispatcher("/jsp/vols/form.jsp").forward(request, response);
    }

    private void editVol(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Vol vol = volDAO.findById(id);
        List<Aeroport> aeroports = aeroportDAO.findAll();
        request.setAttribute("vol", vol);
        request.setAttribute("aeroports", aeroports);
        request.getRequestDispatcher("/jsp/vols/form.jsp").forward(request, response);
    }

    private void saveVol(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String code_vol = request.getParameter("code_vol");
            int id_origine = Integer.parseInt(request.getParameter("id_aeroport_origine"));
            int id_destination = Integer.parseInt(request.getParameter("id_aeroport_destination"));
            int id_type = Integer.parseInt(request.getParameter("id_type_vol"));

            Vol vol = new Vol(code_vol, id_origine, id_destination, id_type);
            volDAO.create(vol);

            response.sendRedirect(request.getContextPath() + "/vols?message=Vol créé");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/vols?error=" + e.getMessage());
        }
    }

    private void updateVol(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String code_vol = request.getParameter("code_vol");
            int id_origine = Integer.parseInt(request.getParameter("id_aeroport_origine"));
            int id_destination = Integer.parseInt(request.getParameter("id_aeroport_destination"));
            int id_type = Integer.parseInt(request.getParameter("id_type_vol"));

            Vol vol = new Vol(id, code_vol, id_origine, id_destination, id_type);
            volDAO.update(vol);

            response.sendRedirect(request.getContextPath() + "/vols?message=Vol mis à jour");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/vols?error=" + e.getMessage());
        }
    }

    private void deleteVol(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            volDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/vols?message=Vol supprimé");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/vols?error=" + e.getMessage());
        }
    }
}
