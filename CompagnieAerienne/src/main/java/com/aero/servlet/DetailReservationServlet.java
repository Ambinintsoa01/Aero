package com.aero.servlet;

import java.io.IOException;
import java.util.List;

import com.aero.dao.DetailReservationDAO;
import com.aero.model.DetailReservation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet pour afficher les détails des réservations
 */
@WebServlet("/reservation-details")
public class DetailReservationServlet extends HttpServlet {
    private DetailReservationDAO detailReservationDAO;

    @Override
    public void init() throws ServletException {
        detailReservationDAO = new DetailReservationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            listReservations(request, response);
        } else if (action.equals("view")) {
            viewReservationDetail(request, response);
        } else if (action.equals("search")) {
            searchReservation(request, response);
        }
    }

    /**
     * Affiche la liste de toutes les réservations
     */
    private void listReservations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<DetailReservation> reservations = detailReservationDAO.findAll();
        long totalReservations = detailReservationDAO.countTotal();
        
        request.setAttribute("reservations", reservations);
        request.setAttribute("totalReservations", totalReservations);
        request.getRequestDispatcher("/jsp/reservations/list-details.jsp").forward(request, response);
    }

    /**
     * Affiche les détails d'une réservation spécifique
     */
    private void viewReservationDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        long idBillet = Long.parseLong(request.getParameter("id"));
        DetailReservation detail = detailReservationDAO.findByIdBillet(idBillet);
        
        if (detail == null) {
            response.sendRedirect(request.getContextPath() + "/reservation-details?error=Réservation non trouvée");
            return;
        }
        
        request.setAttribute("detail", detail);
        request.getRequestDispatcher("/jsp/reservations/view-details.jsp").forward(request, response);
    }

    /**
     * Recherche une réservation par numéro de billet ou numéro de passeport
     */
    private void searchReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchType = request.getParameter("searchType"); // "billet" ou "passport"
        String searchValue = request.getParameter("searchValue");
        
        List<DetailReservation> results = null;
        
        if ("billet".equals(searchType) && searchValue != null && !searchValue.isEmpty()) {
            DetailReservation detail = detailReservationDAO.findByNumeroBillet(searchValue);
            if (detail != null) {
                results = new java.util.ArrayList<>();
                results.add(detail);
            }
        } else if ("passport".equals(searchType) && searchValue != null && !searchValue.isEmpty()) {
            results = detailReservationDAO.findByNumeroPassport(searchValue);
        }
        
        request.setAttribute("reservations", results != null ? results : new java.util.ArrayList<>());
        request.setAttribute("searchType", searchType);
        request.setAttribute("searchValue", searchValue);
        request.getRequestDispatcher("/jsp/reservations/list-details.jsp").forward(request, response);
    }
}
