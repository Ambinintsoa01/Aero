<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil - Compagnie Aérienne</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; color: #333; }
        .sidebar { position: fixed; left: 0; top: 0; width: 250px; height: 100vh; background: #2c3e50; color: white; overflow-y: auto; z-index: 1000; }
        .sidebar-header { padding: 20px; background: #34495e; border-bottom: 2px solid #3498db; }
        .sidebar-header h2 { font-size: 18px; margin-bottom: 5px; }
        .sidebar-header p { font-size: 12px; opacity: 0.8; }
        .sidebar-menu { list-style: none; padding: 20px 0; }
        .sidebar-menu a { display: block; padding: 12px 20px; color: #ecf0f1; text-decoration: none; border-left: 3px solid transparent; transition: all 0.3s; }
        .sidebar-menu a:hover { background: #34495e; border-left-color: #3498db; }
        .sidebar-menu a.active { background: #3498db; border-left-color: #3498db; font-weight: bold; }
        .main-content { margin-left: 250px; min-height: 100vh; }
        .topbar { background: white; padding: 20px 30px; border-bottom: 1px solid #ddd; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .topbar h1 { font-size: 28px; color: #2c3e50; }
        .container { padding: 30px; max-width: 1200px; }
        .welcome-card { background: linear-gradient(135deg, #3498db 0%, #2980b9 100%); color: white; padding: 40px; border-radius: 8px; margin-bottom: 30px; }
        .welcome-card h1 { font-size: 32px; margin-bottom: 10px; }
        .welcome-card p { font-size: 16px; opacity: 0.95; }
        .features-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; }
        .feature-card { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); border: 1px solid #eee; transition: all 0.3s; }
        .feature-card:hover { box-shadow: 0 4px 12px rgba(0,0,0,0.15); transform: translateY(-2px); }
        .feature-card .icon { font-size: 40px; margin-bottom: 15px; }
        .feature-card h3 { font-size: 20px; margin-bottom: 10px; color: #2c3e50; }
        .feature-card p { font-size: 14px; color: #666; margin-bottom: 15px; line-height: 1.6; }
        .btn { display: inline-block; padding: 10px 20px; background: #3498db; color: white; text-decoration: none; border-radius: 5px; border: none; cursor: pointer; font-size: 14px; transition: background 0.3s; }
        .btn:hover { background: #2980b9; }
        .btn-primary { background: #3498db; }
        .btn-primary:hover { background: #2980b9; }
        .mt-2 { margin-top: 15px; }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h2>✈️ Compagnie</h2>
            <p>Système de Gestion</p>
        </div>
        <nav class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/" class="active">
                <span class="icon">🏠</span>
                <span>Accueil</span>
            </a>
            <a href="${pageContext.request.contextPath}/aeroports">
                <span class="icon">✈️</span>
                <span>Aéroports</span>
            </a>
            <a href="${pageContext.request.contextPath}/avions">
                <span class="icon">🛫</span>
                <span>Avions</span>
            </a>
            <a href="${pageContext.request.contextPath}/employes">
                <span class="icon">👥</span>
                <span>Employés</span>
            </a>
            <a href="${pageContext.request.contextPath}/vols">
                <span class="icon">📅</span>
                <span>Vols</span>
            </a>
            <a href="${pageContext.request.contextPath}/reservations">
                <span class="icon">🎫</span>
                <span>Réservations</span>
            </a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="topbar">
            <h1>Tableau de bord</h1>
        </div>

        <div class="container">
            <div class="welcome-card">
                <h1>Bienvenue dans le système de gestion</h1>
                <p>Gérez efficacement votre compagnie aérienne avec notre plateforme complète</p>
            </div>

            <div class="features-grid">
                <div class="feature-card">
                    <div class="icon">✈️</div>
                    <h3>Aéroports</h3>
                    <p>Gestion complète des aéroports mondiaux avec fuseaux horaires et informations détaillées</p>
                    <a href="${pageContext.request.contextPath}/aeroports" class="btn btn-primary mt-2">Gérer les aéroports</a>
                </div>

                <div class="feature-card">
                    <div class="icon">🛫</div>
                    <h3>Avions</h3>
                    <p>Suivi de la flotte, statuts de maintenance, capacités et immatriculations des appareils</p>
                    <a href="${pageContext.request.contextPath}/avions" class="btn btn-primary mt-2">Gérer les avions</a>
                </div>

                <div class="feature-card">
                    <div class="icon">👥</div>
                    <h3>Employés</h3>
                    <p>Gestion du personnel navigant et technique, plannings d'équipage et heures de vol</p>
                    <a href="${pageContext.request.contextPath}/employes" class="btn btn-primary mt-2">Gérer les employés</a>
                </div>

                <div class="feature-card">
                    <div class="icon">📅</div>
                    <h3>Vols</h3>
                    <p>Programmation des vols, gestion des segments et instances avec états en temps réel</p>
                    <a href="${pageContext.request.contextPath}/vols" class="btn btn-primary mt-2">Gérer les vols</a>
                </div>

                <div class="feature-card">
                    <div class="icon">🎫</div>
                    <h3>Réservations</h3>
                    <p>Système de réservation complet avec PNR, gestion des passagers et paiements</p>
                    <a href="${pageContext.request.contextPath}/reservations" class="btn btn-primary mt-2">Gérer les réservations</a>
                </div>

                <div class="feature-card">
                    <div class="icon">🔍</div>
                    <h3>Rechercher un Vol</h3>
                    <p>Recherchez et réservez des vols selon votre destination et date de départ</p>
                    <a href="${pageContext.request.contextPath}/reservations/recherche" class="btn btn-primary mt-2">Rechercher des vols</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
