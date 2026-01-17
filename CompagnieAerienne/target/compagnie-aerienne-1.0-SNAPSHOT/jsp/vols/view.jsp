<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.aero.model.Vol" %>
<%
    Vol vol = (Vol) request.getAttribute("vol");
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails Vol</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
</head>
<body>
    <jsp:include page="/jsp/components/sidebar.jsp" />
    <div class="main-content">
        <header class="header">
            <h1>Détails du Vol</h1>
        </header>
        <div class="container">
            <div class="content-wrapper">
                <% if (vol == null) { %>
                    <div class="alert alert-danger">Vol non trouvé</div>
                <% } else { %>
                    <div class="detail-section">
                        <h2>Informations du Vol</h2>
                        <div class="info-grid">
                            <span class="info-label">Code Vol:</span>
                            <span class="info-value"><%= vol.getCode_vol() %></span>
                            <span class="info-label">Aéroport Origine:</span>
                            <span class="info-value"><%= vol.getAeroport_origine_code() %></span>
                            <span class="info-label">Aéroport Destination:</span>
                            <span class="info-value"><%= vol.getAeroport_destination_code() %></span>
                            <span class="info-label">Type de Vol:</span>
                            <span class="info-value"><%= vol.getType_vol_libelle() %></span>
                        </div>
                    </div>

                    <div class="button-group">
                        <a href="<%= contextPath %>/vols?action=edit&id=<%= vol.getId() %>" class="btn btn-primary">
                            Éditer
                        </a>
                        <a href="<%= contextPath %>/vols" class="btn btn-secondary">
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
    </footer>
</body>
</html>

