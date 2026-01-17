<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.aero.model.Avion" %>
<%
    String contextPath = request.getContextPath();
    String message = request.getParameter("message");
    String error = request.getParameter("error");
    String filterImmatriculation = request.getParameter("filterImmatriculation") != null ? request.getParameter("filterImmatriculation") : "";
    String filterModele = request.getParameter("filterModele") != null ? request.getParameter("filterModele") : "";
    String filterConstructeur = request.getParameter("filterConstructeur") != null ? request.getParameter("filterConstructeur") : "";
    List<Avion> avions = (List<Avion>) request.getAttribute("avions");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Avions</title>
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
            <h1>Gestion des Avions</h1>
        </header>
        <div class="container">
            <div class="content-wrapper">
                <h1>Gestion des Avions</h1>

    <% if (message != null) { %>
        <div class="alert alert-success"><%= message %></div>
    <% } %>
    <% if (error != null) { %>
        <div class="alert alert-error"><%= error %></div>
    <% } %>

    <div class="button-group">
        <a href="<%= contextPath %>/avions?action=new" class="btn btn-primary">
            + Ajouter un Avion
        </a>
    </div>

    <!-- Barre de Filtres -->
    <form method="GET" action="<%= contextPath %>/avions" class="filter-container">
        <div class="filter-group">
            <label for="filterImmatriculation">Immatriculation</label>
            <input type="text" id="filterImmatriculation" name="filterImmatriculation" value="<%= filterImmatriculation %>" placeholder="Rechercher...">
        </div>
        <div class="filter-group">
            <label for="filterModele">Modèle</label>
            <input type="text" id="filterModele" name="filterModele" value="<%= filterModele %>" placeholder="Rechercher...">
        </div>
        <div class="filter-group">
            <label for="filterConstructeur">Constructeur</label>
            <input type="text" id="filterConstructeur" name="filterConstructeur" value="<%= filterConstructeur %>" placeholder="Rechercher...">
        </div>
        <div class="filter-buttons">
            <button type="submit" class="btn-filter">🔍 Filtrer</button>
            <a href="<%= contextPath %>/avions" class="btn-reset" style="padding: 8px 15px; border-radius: 4px; text-decoration: none; text-align: center;">↻ Réinitialiser</a>
        </div>
    </form>

    <table class="table">
        <thead>
            <tr>
                <th>Immatriculation</th>
                <th>Modèle</th>
                <th>Constructeur</th>
                <th>Capacité</th>
                <th>Année</th>
                <th>Date Mise en Service</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% if (avions != null) {
                for (Avion avion : avions) {
                    boolean matchesFilter = true;
                    if (!filterImmatriculation.isEmpty() && !avion.getImmatriculation().toLowerCase().contains(filterImmatriculation.toLowerCase())) {
                        matchesFilter = false;
                    }
                    if (!filterModele.isEmpty() && !avion.getModele().toLowerCase().contains(filterModele.toLowerCase())) {
                        matchesFilter = false;
                    }
                    if (!filterConstructeur.isEmpty() && !avion.getConstructeur().toLowerCase().contains(filterConstructeur.toLowerCase())) {
                        matchesFilter = false;
                    }
                    
                    if (matchesFilter) {
            %>
                <tr>
                    <td><%= avion.getImmatriculation() %></td>
                    <td><%= avion.getModele() %></td>
                    <td><%= avion.getConstructeur() %></td>
                    <td><%= avion.getCapacite() %></td>
                    <td><%= avion.getAnnee_fabrication() %></td>
                    <td><%= avion.getDate_mise_service() %></td>
                    <td>
                        <a href="<%= contextPath %>/avions?action=view&id=<%= avion.getId() %>" class="btn btn-small">Voir</a>
                        <a href="<%= contextPath %>/avions?action=edit&id=<%= avion.getId() %>" class="btn btn-small">Éditer</a>
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
