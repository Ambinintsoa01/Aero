<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails Avion - Compagnie Aérienne</title>
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
        .btn { display: inline-block; padding: 10px 20px; background: #3498db; color: white; text-decoration: none; border-radius: 5px; border: none; cursor: pointer; font-size: 14px; transition: background 0.3s; }
        .btn:hover { background: #2980b9; }
        .btn-primary { background: #3498db; }
        .btn-primary:hover { background: #2980b9; }
        .btn-danger { background: #e74c3c; }
        .btn-danger:hover { background: #c0392b; }
        .btn-sm { padding: 6px 12px; font-size: 12px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; background: white; border: 1px solid #ddd; }
        table thead { background: #f8f9fa; }
        table th { padding: 12px; text-align: left; font-weight: 600; border-bottom: 2px solid #ddd; color: #2c3e50; }
        table td { padding: 12px; border-bottom: 1px solid #eee; }
        table tbody tr:hover { background: #f9f9f9; }
        .btn-group { display: flex; gap: 8px; }
        .card { background: white; padding: 20px; border-radius: 8px; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: 600; color: #2c3e50; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-family: inherit; }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus { outline: none; border-color: #3498db; box-shadow: 0 0 5px rgba(52,152,219,0.3); }
        .alert { padding: 15px; border-radius: 5px; margin-bottom: 20px; border-left: 4px solid; }
        .alert-success { background: #d4edda; color: #155724; border-left-color: #28a745; }
        .alert-danger { background: #f8d7da; color: #721c24; border-left-color: #dc3545; }
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
            <a href="${pageContext.request.contextPath}/">
                <span class="icon">🏠</span>
                <span>Accueil</span>
            </a>
            <a href="${pageContext.request.contextPath}/aeroports">
                <span class="icon">✈️</span>
                <span>Aéroports</span>
            </a>
            <a href="${pageContext.request.contextPath}/avions" class="active">
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
            <div>
                <h1>Détails de l'avion</h1>
                <div class="breadcrumb">
                    <a href="${pageContext.request.contextPath}/">Accueil</a>
                    <span class="separator">/</span>
                    <a href="${pageContext.request.contextPath}/avions">Avions</a>
                    <span class="separator">/</span>
                    <span>Détails</span>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="card">
                <h2 class="card-title">Informations de l'avion ${avion.immatriculation}</h2>
                <p class="card-subtitle">Détails techniques et statistiques de remplissage</p>
                
                <ul class="info-list">
                    <li>
                        <span class="label">Immatriculation</span>
                        <span class="value"><strong>${avion.immatriculation}</strong></span>
                    </li>
                    <li>
                        <span class="label">Modèle</span>
                        <span class="value">${avion.modele}</span>
                    </li>
                    <li>
                        <span class="label">Capacité Économique</span>
                        <span class="value">${avion.capacite_eco} places</span>
                    </li>
                    <li>
                        <span class="label">Capacité Business</span>
                        <span class="value">${avion.capacite_business} places</span>
                    </li>
                    <li>
                        <span class="label">Capacité Totale</span>
                        <span class="value"><strong>${avion.capacite_eco + avion.capacite_business} places</strong></span>
                    </li>
                </ul>

                <div class="mt-4">
                    <h3 class="card-subtitle mb-2">Taux de Remplissage (Année)</h3>
                    <div style="background: #f1f3f4; padding: 20px; border-radius: 8px;">
                        <div style="background: #e8eaed; height: 40px; border-radius: 20px; overflow: hidden; position: relative;">
                            <div style="background: linear-gradient(90deg, #1e8e3e, #34a853); height: 100%; width: ${moyenneRemplissage * 100}%; display: flex; align-items: center; justify-content: center; color: white; font-weight: 600; font-size: 16px; transition: width 0.3s ease;">
                                ${String.format("%.1f", moyenneRemplissage * 100)}%
                            </div>
                        </div>
                    </div>
                </div>

                <div class="btn-group mt-4">
                    <a href="${pageContext.request.contextPath}/avions" class="btn btn-secondary">
                        <span>←</span>
                        Retour à la liste
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
