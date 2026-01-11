<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recherche de Vol - Compagnie Aérienne</title>
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
        .btn-secondary { background: #95a5a6; }
        .btn-secondary:hover { background: #7f8c8d; }
        .btn-success { background: #27ae60; }
        .btn-success:hover { background: #229954; }
        .card { background: white; padding: 20px; border-radius: 8px; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: 600; color: #2c3e50; }
        .form-group input, .form-group select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-family: inherit; }
        .form-group input:focus, .form-group select:focus { outline: none; border-color: #3498db; box-shadow: 0 0 5px rgba(52,152,219,0.3); }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .search-card { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 12px; margin-bottom: 30px; }
        .search-card h2 { margin-bottom: 20px; }
        .search-card .form-group label { color: white; }
        .search-card input, .search-card select { background: white; }
        .results-container { margin-top: 30px; }
        .flight-card { background: white; border-radius: 8px; padding: 20px; margin-bottom: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); border-left: 4px solid #3498db; }
        .flight-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
        .flight-route { font-size: 20px; font-weight: bold; color: #2c3e50; }
        .flight-time { color: #7f8c8d; font-size: 14px; }
        .flight-details { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-top: 15px; }
        .detail-item { padding: 10px; background: #f8f9fa; border-radius: 6px; }
        .detail-label { font-size: 12px; color: #7f8c8d; margin-bottom: 5px; }
        .detail-value { font-weight: 600; color: #2c3e50; }
        .seats-info { display: flex; gap: 20px; margin-top: 10px; }
        .seats-badge { padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .seats-eco { background: #d5f4e6; color: #27ae60; }
        .seats-business { background: #ffeaa7; color: #f39c12; }
        .price-tag { font-size: 24px; font-weight: bold; color: #27ae60; }
        .alert { padding: 15px; border-radius: 5px; margin-bottom: 20px; border-left: 4px solid; }
        .alert-info { background: #d6eaf8; color: #1f618d; border-left-color: #3498db; }
        .alert-warning { background: #fcf3cf; color: #7d6608; border-left-color: #f39c12; }
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
            <a href="${pageContext.request.contextPath}/reservations" class="active">
                <span class="icon">🎫</span>
                <span>Réservations</span>
            </a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="topbar">
            <div>
                <h1>🔍 Recherche de Vol</h1>
                <p>Trouvez votre vol idéal</p>
            </div>
        </div>

        <div class="container">
            <!-- Formulaire de recherche -->
            <div class="search-card">
                <h2>✈️ Où souhaitez-vous voyager ?</h2>
                <form method="GET" action="${pageContext.request.contextPath}/reservations/recherche">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="aeroport_depart">🛫 Aéroport de départ</label>
                            <select id="aeroport_depart" name="aeroport_depart" required>
                                <option value="">-- Sélectionnez un aéroport --</option>
                                <c:forEach var="aeroport" items="${aeroports}">
                                    <option value="${aeroport.code_iata}" ${aeroportDepart == aeroport.code_iata ? 'selected' : ''}>
                                        ${aeroport.code_iata} - ${aeroport.nom} (${aeroport.ville})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="aeroport_arrivee">🛬 Aéroport d'arrivée</label>
                            <select id="aeroport_arrivee" name="aeroport_arrivee" required>
                                <option value="">-- Sélectionnez un aéroport --</option>
                                <c:forEach var="aeroport" items="${aeroports}">
                                    <option value="${aeroport.code_iata}" ${aeroportArrivee == aeroport.code_iata ? 'selected' : ''}>
                                        ${aeroport.code_iata} - ${aeroport.nom} (${aeroport.ville})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="date_depart">📅 Date de départ</label>
                            <input type="date" id="date_depart" name="date_depart" value="${dateDepart}" required>
                        </div>
                        <div class="form-group">
                            <label for="heure_depart">🕐 Heure souhaitée (optionnel)</label>
                            <input type="time" id="heure_depart" name="heure_depart" value="${heureDepart}">
                        </div>
                    </div>
                    <div style="margin-top: 20px;">
                        <button type="submit" class="btn btn-success" style="padding: 12px 30px; font-size: 16px;">
                            🔍 Rechercher des vols
                        </button>
                        <a href="${pageContext.request.contextPath}/reservations" class="btn btn-secondary">Annuler</a>
                    </div>
                </form>
            </div>

            <!-- Résultats de recherche -->
            <c:if test="${not empty volsDisponibles}">
                <div class="results-container">
                    <h2 style="margin-bottom: 20px;">📋 Vols disponibles (${volsDisponibles.size()} résultat(s))</h2>
                    
                    <c:choose>
                        <c:when test="${empty volsDisponibles}">
                            <div class="alert alert-warning">
                                ⚠️ Aucun vol disponible pour ces critères. Essayez avec d'autres dates ou aéroports.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="volInfo" items="${volsDisponibles}">
                                <div class="flight-card">
                                    <div class="flight-header">
                                        <div>
                                            <div class="flight-route">
                                                ${volInfo.aeroportDepart} → ${volInfo.aeroportArrivee}
                                            </div>
                                            <div class="flight-time">
                                                Vol ${volInfo.numeroVol} | ${volInfo.dateDepart} - ${volInfo.heureDepart} → ${volInfo.heureArrivee}
                                            </div>
                                        </div>
                                        <div class="price-tag">
                                            ${volInfo.prix} €
                                        </div>
                                    </div>
                                    
                                    <div class="flight-details">
                                        <div class="detail-item">
                                            <div class="detail-label">Avion</div>
                                            <div class="detail-value">${volInfo.avionImmat} - ${volInfo.avionModele}</div>
                                        </div>
                                        <div class="detail-item">
                                            <div class="detail-label">Places disponibles</div>
                                            <div class="seats-info">
                                                <span class="seats-badge seats-eco">Éco: ${volInfo.placesEco} places</span>
                                                <span class="seats-badge seats-business">Business: ${volInfo.placesBusiness} places</span>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div style="margin-top: 15px; text-align: right;">
                                        <a href="${pageContext.request.contextPath}/reservations/reserver?instance_id=${volInfo.instanceId}" 
                                           class="btn btn-primary">
                                            🎫 Réserver ce vol
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
            
            <c:if test="${empty volsDisponibles && not empty aeroportDepart}">
                <div class="alert alert-info">
                    💡 Entrez vos critères de recherche ci-dessus pour trouver des vols disponibles.
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>
