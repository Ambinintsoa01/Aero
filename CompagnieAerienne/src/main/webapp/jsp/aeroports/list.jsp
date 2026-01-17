<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.aero.model.Aeroport" %>
<%
    String contextPath = request.getContextPath();
    String message = request.getParameter("message");
    String filterCode = request.getParameter("filterCode") != null ? request.getParameter("filterCode") : "";
    String filterNom = request.getParameter("filterNom") != null ? request.getParameter("filterNom") : "";
    String filterPays = request.getParameter("filterPays") != null ? request.getParameter("filterPays") : "";
    String filterVille = request.getParameter("filterVille") != null ? request.getParameter("filterVille") : "";
    List<Aeroport> aeroports = (List<Aeroport>) request.getAttribute("aeroports");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Aéroports</title>
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
            <h1>Gestion des Aéroports</h1>
        </header>
        <div class="container">
            <div class="content-wrapper">

    <h1>Gestion des Aéroports</h1>

    <% if (message != null) { %>
        <div class="alert alert-success"><%= message %></div>
    <% } %>

    <div class="button-group">
        <a href="<%= contextPath %>/aeroports?action=new" class="btn btn-primary">
            + Ajouter un Aéroport
        </a>
    </div>

    <!-- Barre de Filtres -->
    <form method="GET" action="<%= contextPath %>/aeroports" class="filter-container">
        <div class="filter-group">
            <label for="filterCode">Code</label>
            <input type="text" id="filterCode" name="filterCode" value="<%= filterCode %>" placeholder="Rechercher...">
        </div>
        <div class="filter-group">
            <label for="filterNom">Nom</label>
            <input type="text" id="filterNom" name="filterNom" value="<%= filterNom %>" placeholder="Rechercher...">
        </div>
        <div class="filter-group">
            <label for="filterPays">Pays</label>
            <input type="text" id="filterPays" name="filterPays" value="<%= filterPays %>" placeholder="Rechercher...">
        </div>
        <div class="filter-group">
            <label for="filterVille">Ville</label>
            <input type="text" id="filterVille" name="filterVille" value="<%= filterVille %>" placeholder="Rechercher...">
        </div>
        <div class="filter-buttons">
            <button type="submit" class="btn-filter">🔍 Filtrer</button>
            <a href="<%= contextPath %>/aeroports" class="btn-reset" style="padding: 8px 15px; border-radius: 4px; text-decoration: none; text-align: center;">↻ Réinitialiser</a>
        </div>
    </form>

    <table class="table">
        <thead>
            <tr>
                <th>Code</th>
                <th>Nom</th>
                <th>Pays</th>
                <th>Ville</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% if (aeroports != null) {
                for (Aeroport aeroport : aeroports) {
                    boolean matchesFilter = true;
                    if (!filterCode.isEmpty() && !aeroport.getCode().toLowerCase().contains(filterCode.toLowerCase())) {
                        matchesFilter = false;
                    }
                    if (!filterNom.isEmpty() && !aeroport.getNom().toLowerCase().contains(filterNom.toLowerCase())) {
                        matchesFilter = false;
                    }
                    if (!filterPays.isEmpty() && !aeroport.getPays().toLowerCase().contains(filterPays.toLowerCase())) {
                        matchesFilter = false;
                    }
                    if (!filterVille.isEmpty() && !aeroport.getVille().toLowerCase().contains(filterVille.toLowerCase())) {
                        matchesFilter = false;
                    }
                    
                    if (matchesFilter) {
            %>
                <tr>
                    <td><%= aeroport.getCode() %></td>
                    <td><%= aeroport.getNom() %></td>
                    <td><%= aeroport.getPays() %></td>
                    <td><%= aeroport.getVille() %></td>
                    <td>
                        <a href="<%= contextPath %>/aeroports?action=view&id=<%= aeroport.getId_aeroport() %>" class="btn btn-small">Voir</a>
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
