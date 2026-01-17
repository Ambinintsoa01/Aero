<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.aero.model.Vol" %>
<%
    String contextPath = request.getContextPath();
    String message = request.getParameter("message");
    String filterCode = request.getParameter("filterCode") != null ? request.getParameter("filterCode") : "";
    String filterOrigine = request.getParameter("filterOrigine") != null ? request.getParameter("filterOrigine") : "";
    String filterDestination = request.getParameter("filterDestination") != null ? request.getParameter("filterDestination") : "";
    List<Vol> vols = (List<Vol>) request.getAttribute("vols");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Vols</title>
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
        .filter-group input {
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
            <h1>Gestion des Vols</h1>
        </header>
        <div class="container">
            <div class="content-wrapper">

    <h1>Gestion des Vols</h1>

    <% if (message != null) { %>
        <div class="alert alert-success"><%= message %></div>
    <% } %>

    <div class="button-group">
        <a href="<%= contextPath %>/vols?action=new" class="btn btn-primary">
            + Créer un Vol
        </a>
    </div>

    <!-- Barre de Filtres -->
    <form method="GET" action="<%= contextPath %>/vols" class="filter-container">
        <div class="filter-group">
            <label for="filterCode">Code Vol</label>
            <input type="text" id="filterCode" name="filterCode" value="<%= filterCode %>" placeholder="Rechercher...">
        </div>
        <div class="filter-group">
            <label for="filterOrigine">Origine</label>
            <input type="text" id="filterOrigine" name="filterOrigine" value="<%= filterOrigine %>" placeholder="Rechercher...">
        </div>
        <div class="filter-group">
            <label for="filterDestination">Destination</label>
            <input type="text" id="filterDestination" name="filterDestination" value="<%= filterDestination %>" placeholder="Rechercher...">
        </div>
        <div class="filter-buttons">
            <button type="submit" class="btn-filter">🔍 Filtrer</button>
            <a href="<%= contextPath %>/vols" class="btn-reset" style="padding: 8px 15px; border-radius: 4px; text-decoration: none; text-align: center;">↻ Réinitialiser</a>
        </div>
    </form>

    <table class="table">
        <thead>
            <tr>
                <th>Code Vol</th>
                <th>Origine</th>
                <th>Destination</th>
                <th>Type</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% if (vols != null) {
                for (Vol vol : vols) {
                    boolean matchesFilter = true;
                    if (!filterCode.isEmpty() && !vol.getCode_vol().toLowerCase().contains(filterCode.toLowerCase())) {
                        matchesFilter = false;
                    }
                    if (!filterOrigine.isEmpty() && !vol.getAeroport_origine_code().toLowerCase().contains(filterOrigine.toLowerCase())) {
                        matchesFilter = false;
                    }
                    if (!filterDestination.isEmpty() && !vol.getAeroport_destination_code().toLowerCase().contains(filterDestination.toLowerCase())) {
                        matchesFilter = false;
                    }
                    
                    if (matchesFilter) {
            %>
                <tr>
                    <td><%= vol.getCode_vol() %></td>
                    <td><%= vol.getAeroport_origine_code() %></td>
                    <td><%= vol.getAeroport_destination_code() %></td>
                    <td><%= vol.getType_vol_libelle() %></td>
                    <td>
                        <a href="<%= contextPath %>/vols?action=view&id=<%= vol.getId() %>" class="btn btn-small">Voir</a>
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
