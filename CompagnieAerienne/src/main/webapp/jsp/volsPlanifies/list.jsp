<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.aero.model.VolPlanifie" %>
<%
    String contextPath = request.getContextPath();
    String message = request.getParameter("message");
    String filterCode = request.getParameter("filterCode") != null ? request.getParameter("filterCode") : "";
    String filterTrajet = request.getParameter("filterTrajet") != null ? request.getParameter("filterTrajet") : "";
    String filterAvion = request.getParameter("filterAvion") != null ? request.getParameter("filterAvion") : "";
    String filterStatut = request.getParameter("filterStatut") != null ? request.getParameter("filterStatut") : "";
    List<VolPlanifie> volsPlanifies = (List<VolPlanifie>) request.getAttribute("volsPlanifies");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Vols Planifiés</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
    <style>
        .filter-container {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin: 15px 0;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            align-items: flex-end;
        }
        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        .filter-group label {
            font-weight: bold;
            font-size: 12px;
            color: #333;
        }
        .filter-group input, .filter-group select {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 13px;
        }
        .filter-buttons {
            display: flex;
            gap: 8px;
        }
        .filter-buttons button {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 13px;
            font-weight: bold;
        }
        .btn-filter {
            background: #1e3a8a;
            color: white;
        }
        .btn-filter:hover {
            background: #1a2e5f;
        }
        .btn-reset {
            background: #e5e7eb;
            color: #333;
        }
        .btn-reset:hover {
            background: #d1d5db;
        }
    </style>
</head>
<body>
    <jsp:include page="/jsp/components/sidebar.jsp" />
    <div class="main-content">
        <header class="header">
            <h1>Gestion des Vols Planifiés</h1>
        </header>
        <div class="container">
            <div class="content-wrapper">

    <h1>Gestion des Vols Planifiés</h1>

    <% if (message != null) { %>
        <div class="alert alert-success"><%= message %></div>
    <% } %>

    <div class="button-group">
        <a href="<%= contextPath %>/volsPlanifies?action=new" class="btn btn-primary">
            + Planifier un Vol
        </a>
    </div>

    <!-- Barre de Filtres -->
    <form method="GET" action="<%= contextPath %>/volsPlanifies" class="filter-container">
        <div class="filter-group">
            <label for="filterCode">Code Vol</label>
            <input type="text" id="filterCode" name="filterCode" value="<%= filterCode %>" placeholder="Rechercher...">
        </div>
        <div class="filter-group">
            <label for="filterTrajet">Trajet</label>
            <input type="text" id="filterTrajet" name="filterTrajet" value="<%= filterTrajet %>" placeholder="Ex: CDG-ORY...">
        </div>
        <div class="filter-group">
            <label for="filterAvion">Avion</label>
            <input type="text" id="filterAvion" name="filterAvion" value="<%= filterAvion %>" placeholder="Rechercher...">
        </div>
        <div class="filter-group">
            <label for="filterStatut">Statut</label>
            <select id="filterStatut" name="filterStatut">
                <option value="">-- Tous --</option>
                <option value="PROGRAMME" <%= "PROGRAMME".equals(filterStatut) ? "selected" : "" %>>PROGRAMMÉ</option>
                <option value="EN_VOL" <%= "EN_VOL".equals(filterStatut) ? "selected" : "" %>>EN VOL</option>
                <option value="TERMINE" <%= "TERMINE".equals(filterStatut) ? "selected" : "" %>>TERMINÉ</option>
                <option value="ANNULE" <%= "ANNULE".equals(filterStatut) ? "selected" : "" %>>ANNULÉ</option>
            </select>
        </div>
        <div class="filter-buttons">
            <button type="submit" class="btn-filter">🔍 Filtrer</button>
            <a href="<%= contextPath %>/volsPlanifies" class="btn-reset" style="padding: 8px 15px; border-radius: 4px; text-decoration: none; text-align: center;">↻ Réinitialiser</a>
        </div>
    </form>

    <table class="table">
        <thead>
            <tr>
                <th>Code Vol</th>
                <th>Trajet</th>
                <th>Avion</th>
                <th>Départ</th>
                <th>Arrivée</th>
                <th>Places Disponibles</th>
                <th>Statut</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% if (volsPlanifies != null) {
                for (VolPlanifie vol : volsPlanifies) {
                    boolean matchesFilter = true;
                    if (!filterCode.isEmpty() && !vol.getCode_vol().toLowerCase().contains(filterCode.toLowerCase())) {
                        matchesFilter = false;
                    }
                    if (!filterTrajet.isEmpty()) {
                        String trajet = (vol.getAeroport_origine_code() != null ? vol.getAeroport_origine_code() : "") + 
                                       (vol.getAeroport_destination_code() != null ? vol.getAeroport_destination_code() : "");
                        if (!trajet.toLowerCase().contains(filterTrajet.toLowerCase())) {
                            matchesFilter = false;
                        }
                    }
                    if (!filterAvion.isEmpty() && !vol.getImmatriculation_avion().toLowerCase().contains(filterAvion.toLowerCase())) {
                        matchesFilter = false;
                    }
                    if (!filterStatut.isEmpty() && !vol.getStatus().equals(filterStatut)) {
                        matchesFilter = false;
                    }
                    
                    if (matchesFilter) {
            %>
                <tr>
                    <td><%= vol.getCode_vol() %></td>
                    <td>
                        <span style="font-weight: bold; color: #1e3a8a; font-size: 14px;">
                            <%= vol.getAeroport_origine_code() != null ? vol.getAeroport_origine_code() : "?" %>
                            <span style="color: #666;">→</span>
                            <%= vol.getAeroport_destination_code() != null ? vol.getAeroport_destination_code() : "?" %>
                        </span>
                    </td>
                    <td><%= vol.getImmatriculation_avion() %></td>
                    <td><%= vol.getDate_reelle_depart() != null ? vol.getDate_reelle_depart() : "-" %></td>
                    <td><%= vol.getDate_reelle_arrivee() != null ? vol.getDate_reelle_arrivee() : "-" %></td>
                    <td><span style="padding: 5px 10px; background: #818cf8; color: white; border-radius: 5px; font-weight: bold;"><%= vol.getCapacite_avion() %></span></td>
                    <td><span class="badge badge-<%= vol.getStatus() %>"><%= vol.getStatus() %></span></td>
                    <td>
                        <a href="<%= contextPath %>/volsPlanifies?action=view&id=<%= vol.getId() %>" class="btn btn-small">Voir</a>
                        <a href="<%= contextPath %>/reservations?action=new&idVol=<%= vol.getId() %>&date=<%= vol.getDate_prev_depart() != null ? vol.getDate_prev_depart() : "" %>" class="btn btn-small">Réserver</a>
                    </td>
                </tr>
            <% 
                    }
                }
            } %>
        </tbody>
    </table>
</div>

            </div>
        </div>
        <footer style="background: #2c3e50; color: #ecf0f1; padding: 15px; text-align: center; border-top: 1px solid #34495e;">
            <p>&copy; 2026 Compagnie Aérienne</p>
        </footer>
    </div>
</body>
</html>
