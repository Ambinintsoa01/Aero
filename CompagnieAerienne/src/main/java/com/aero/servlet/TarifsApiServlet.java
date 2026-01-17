package com.aero.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import com.aero.dao.VolPlanifieDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet API pour récupérer les tarifs d'un avion
 * URL: /api/tarifs?avionId=X
 */
@WebServlet("/api/tarifs")
public class TarifsApiServlet extends HttpServlet {

    private VolPlanifieDAO volPlanifieDAO;

    @Override
    public void init() throws ServletException {
        volPlanifieDAO = new VolPlanifieDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        
        try {
            int avionId = Integer.parseInt(request.getParameter("avionId"));
            int id_class_premiere = 2;
            int id_class_eco = 1;
            
            // Récupérer les tarifs de l'avion
            double tarifPremiere = volPlanifieDAO.getTarifAvion(avionId, id_class_premiere);
            double tarifEco = volPlanifieDAO.getTarifAvion(avionId, id_class_eco);
            
            // Construire la réponse JSON manuellement
            StringBuilder json = new StringBuilder();
            json.append("{");
            json.append("\"tarifPremiere\": ").append(tarifPremiere);
            json.append(", \"tarifEco\": ").append(tarifEco);
            json.append("}");
            
            PrintWriter out = response.getWriter();
            out.print(json.toString());
            out.flush();
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            PrintWriter out = response.getWriter();
            out.print("{\"error\":\"" + escapeJson(e.getMessage()) + "\"}");
            out.flush();
        }
    }

    /**
     * Échappe les caractères spéciaux pour JSON
     */
    private String escapeJson(String value) {
        if (value == null) return "";
        return value.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }
}
