<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.aero.model.Billet" %>
<%
    String contextPath = request.getContextPath();
    String message = request.getParameter("message");
    String error = request.getParameter("error");
    String filterNumeroBillet = request.getParameter("filterNumeroBillet") != null ? request.getParameter("filterNumeroBillet") : "";
    String filterNom = request.getParameter("filterNom") != null ? request.getParameter("filterNom") : "";
    String filterPrenom = request.getParameter("filterPrenom") != null ? request.getParameter("filterPrenom") : "";
    String filterEmail = request.getParameter("filterEmail") != null ? request.getParameter("filterEmail") : "";
    String filterStatut = request.getParameter("filterStatut") != null ? request.getParameter("filterStatut") : "";
    List<Billet> billets = (List<Billet>) request.getAttribute("billets");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Réservations</title>
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
            <h1>Liste des Réservations</h1>
        </header>
        <div class="container">
            <div class="content-wrapper">

    <h1>Gestion des Réservations</h1>

    <% if (message != null) { %>
        <div class="alert alert-success"><%= message %></div>
    <% } %>
    <% if (error != null) { %>
        <div class="alert alert-error"><%= error %></div>
    <% } %>

    <div class="button-group">
        <a href="<%= contextPath %>/reservations?action=new" class="btn btn-primary">
            + Nouvelle Réservation
        </a>
    </div>

    <!-- Barre de Filtres -->
    <form method="GET" action="<%= contextPath %>/reservations" class="filter-container">
        <div class="filter-group">
            <label for="filterNumeroBillet">N° Billet</label>
            <input type="text" id="filterNumeroBillet" name="filterNumeroBillet" value="<%= filterNumeroBillet %>" placeholder="Rechercher...">
        </div>
        <div class="filter-group">
            <label for="filterNom">Nom</label>
            <input type="text" id="filterNom" name="filterNom" value="<%= filterNom %>" placeholder="Rechercher...">
        </div>
        <div class="filter-group">
            <label for="filterPrenom">Prénom</label>
            <input type="text" id="filterPrenom" name="filterPrenom" value="<%= filterPrenom %>" placeholder="Rechercher...">
        </div>
        <div class="filter-group">
            <label for="filterEmail">Email</label>
            <input type="text" id="filterEmail" name="filterEmail" value="<%= filterEmail %>" placeholder="Rechercher...">
        </div>
        <div class="filter-group">
            <label for="filterStatut">Statut</label>
            <select id="filterStatut" name="filterStatut">
                <option value="">-- Tous --</option>
                <option value="EMIS" <%= "EMIS".equals(filterStatut) ? "selected" : "" %>>ÉMIS</option>
                <option value="UTILISE" <%= "UTILISE".equals(filterStatut) ? "selected" : "" %>>UTILISÉ</option>
                <option value="ANNULE" <%= "ANNULE".equals(filterStatut) ? "selected" : "" %>>ANNULÉ</option>
                <option value="REMBOURSE" <%= "REMBOURSE".equals(filterStatut) ? "selected" : "" %>>REMBOURSÉ</option>
            </select>
        </div>
        <div class="filter-buttons">
            <button type="submit" class="btn-filter">🔍 Filtrer</button>
            <a href="<%= contextPath %>/reservations" class="btn-reset" style="padding: 8px 15px; border-radius: 4px; text-decoration: none; text-align: center;">↻ Réinitialiser</a>
        </div>
    </form>

    <table class="table">
        <thead>
            <tr>
                <th>N° Billet</th>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Email</th>
                <th>Statut</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% if (billets != null) {
                for (Billet billet : billets) {
                    boolean matchesFilter = true;
                    if (!filterNumeroBillet.isEmpty() && !billet.getNumero_billet().toLowerCase().contains(filterNumeroBillet.toLowerCase())) {
                        matchesFilter = false;
                    }
                    if (!filterNom.isEmpty() && !billet.getNom().toLowerCase().contains(filterNom.toLowerCase())) {
                        matchesFilter = false;
                    }
                    if (!filterPrenom.isEmpty() && !billet.getPrenom().toLowerCase().contains(filterPrenom.toLowerCase())) {
                        matchesFilter = false;
                    }
                    if (!filterEmail.isEmpty() && !billet.getEmail().toLowerCase().contains(filterEmail.toLowerCase())) {
                        matchesFilter = false;
                    }
                    if (!filterStatut.isEmpty() && !billet.getStatus().equals(filterStatut)) {
                        matchesFilter = false;
                    }
                    
                    if (matchesFilter) {
            %>
                <tr>
                    <td><%= billet.getNumero_billet() %></td>
                    <td><%= billet.getNom() %></td>
                    <td><%= billet.getPrenom() %></td>
                    <td><%= billet.getEmail() %></td>
                    <td><span class="badge badge-<%= billet.getStatus() %>"><%= billet.getStatus() %></span></td>
                    <td>
                        <a href="<%= contextPath %>/reservations?action=view&id=<%= billet.getId() %>" class="btn btn-small">Voir</a>
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
