<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Compagnie Aérienne - Accueil</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
</head>
<body>
    <!-- Include Sidebar -->
    <jsp:include page="/jsp/components/sidebar.jsp" />

    <!-- Main Content Area -->
    <div class="main-content">
        <!-- Header -->
        <header class="header">
            <h1>Bienvenue à la Compagnie Aérienne</h1>
        </header>

        <!-- Content Container -->
        <div class="container">
            <div class="content-wrapper">
                <section class="welcome">
                    <p>Système de gestion complète des vols et réservations</p>
                </section>

                <section class="features">
                    <div class="feature-card">
                        <h2>Gestion des Avions</h2>
                        <p>Ajoutez et gérez votre flotte d'avions avec leurs capacités</p>
                        <a href="<%= contextPath %>/avions?action=list" class="btn">Gérer les avions</a>
                    </div>

                    <div class="feature-card">
                        <h2>Gestion des Aéroports</h2>
                        <p>Définissez les aéroports de départ et d'arrivée</p>
                        <a href="<%= contextPath %>/aeroports?action=list" class="btn">Gérer les aéroports</a>
                    </div>

                    <div class="feature-card">
                        <h2>Gestion des Vols</h2>
                        <p>Créez les trajets entre aéroports</p>
                        <a href="<%= contextPath %>/vols?action=list" class="btn">Gérer les vols</a>
                    </div>

                    <div class="feature-card">
                        <h2>Planification des Vols</h2>
                        <p>Planifiez les exécutions des vols</p>
                        <a href="<%= contextPath %>/volsPlanifies?action=list" class="btn">Planifier les vols</a>
                    </div>

                    <div class="feature-card">
                        <h2>Réservations</h2>
                        <p>Gérez les réservations et billets</p>
                        <a href="<%= contextPath %>/reservations?action=list" class="btn">Réservations</a>
                    </div>
                </section>
            </div>
        </div>

        <!-- Footer -->
        <footer style="background: #2c3e50; color: #ecf0f1; padding: 15px; text-align: center; border-top: 1px solid #34495e;">
            <p>&copy; 2026 Compagnie Aérienne - Tous droits réservés</p>
        </footer>
    </div>
</body>
</html>
