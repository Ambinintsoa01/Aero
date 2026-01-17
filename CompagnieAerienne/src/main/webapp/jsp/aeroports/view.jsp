<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.aero.model.Aeroport" %>
<%
    String contextPath = request.getContextPath();
    Aeroport aeroport = (Aeroport) request.getAttribute("aeroport");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails Aéroport</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
</head>
<body>
    <jsp:include page="/jsp/components/sidebar.jsp" />
    <div class="main-content">
        <header class="header">
            <h1>Détails de l'Aéroport</h1>
        </header>
        <div class="container">
            <div class="content-wrapper">
                <% if (aeroport == null) { %>
                    <div class="alert alert-error">Aéroport non trouvé</div>
                <% } else { %>
                    <div class="detail-section">
                        <h2>Informations Générales</h2>
                        <div class="info-grid">
                            <span class="info-label">Code:</span>
                            <span class="info-value"><%= aeroport.getCode() %></span>
                            <span class="info-label">Nom:</span>
                            <span class="info-value"><%= aeroport.getNom() %></span>
                            <span class="info-label">Pays:</span>
                            <span class="info-value"><%= aeroport.getPays() %></span>
                            <span class="info-label">Ville:</span>
                            <span class="info-value"><%= aeroport.getVille() %></span>
                        </div>
                    </div>

                    <div class="button-group">
                        <a href="<%= contextPath %>/aeroports?action=edit&id=<%= aeroport.getId_aeroport() %>" class="btn btn-primary">
                            Éditer
                        </a>
                        <a href="<%= contextPath %>/aeroports" class="btn">
                            Retour à la liste
                        </a>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
    <footer>
        <p>&copy; 2026 Compagnie Aérienne</p>
    </footer>
</body>
</html>

