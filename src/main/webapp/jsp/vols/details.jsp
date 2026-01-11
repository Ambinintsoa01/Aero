<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails Vol - Compagnie Aérienne</title>
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
        .info-group { margin-bottom: 15px; }
        .info-label { font-weight: 600; color: #2c3e50; }
        .segment { padding: 12px; background: #f8f9fa; border-left: 3px solid #3498db; margin-bottom: 10px; border-radius: 4px; }
        .seats-container { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 15px; margin-top: 20px; }
        .seat-card { background: #f8f9fa; padding: 15px; border-radius: 8px; border: 1px solid #e3e6ea; }
        .seat-card h4 { color: #2c3e50; margin-bottom: 10px; font-size: 16px; }
        .seat-info { display: flex; justify-content: space-between; margin-bottom: 8px; }
        .seat-label { font-weight: 600; color: #555; }
        .seat-value { color: #3498db; font-weight: bold; }
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
            <a href="${pageContext.request.contextPath}/avions">
                <span class="icon">🛫</span>
                <span>Avions</span>
            </a>
            <a href="${pageContext.request.contextPath}/employes">
                <span class="icon">👥</span>
                <span>Employés</span>
            </a>
            <a href="${pageContext.request.contextPath}/vols" class="active">
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
                <h1>Vol: ${vol.numero_vol}</h1>
                <p class="breadcrumb">
                    <a href="${pageContext.request.contextPath}/">Accueil</a> / 
                    <a href="${pageContext.request.contextPath}/vols">Vols</a> / 
                    Détails
                </p>
            </div>
        </div>

        <div class="card">
            <div class="info-group">
                <span class="info-label">Numéro du Vol:</span>
                <p>${vol.numero_vol}</p>
            </div>
            <div class="info-group">
                <span class="info-label">Description:</span>
                <p>${vol.description}</p>
            </div>

            <h3 style="margin-top: 30px; margin-bottom: 15px;">Instances & Avions Assignés</h3>
            <c:choose>
                <c:when test="${empty instances}">
                    <p>Aucune instance de vol définie.</p>
                </c:when>
                <c:otherwise>
                    <div class="seats-container">
                        <c:forEach var="instance" items="${instances}">
                            <c:set var="avionFound" value="false"/>
                            <c:set var="seatInfo" value="${seatInfoMap[instance.instance_id]}"/>
                            <c:forEach var="avion" items="${avions}">
                                <c:if test="${avion.avion_id == instance.avion_id && !avionFound}">
                                    <c:set var="avionFound" value="true"/>
                                    <div class="seat-card">
                                        <h4>✈️ Instance #${instance.instance_id}</h4>
                                        <div class="seat-info">
                                            <span class="seat-label">Avion:</span>
                                            <span class="seat-value">${avion.immatriculation}</span>
                                        </div>
                                        <div class="seat-info">
                                            <span class="seat-label">Modèle:</span>
                                            <span class="seat-value">${avion.modele}</span>
                                        </div>
                                        <div class="seat-info">
                                            <span class="seat-label">Départ:</span>
                                            <span class="seat-value">${instance.date_depart_reelle}</span>
                                        </div>
                                        <hr style="margin: 10px 0; border: none; border-top: 1px solid #e3e6ea;">
                                        <div class="seat-info">
                                            <span class="seat-label">Classe Économique:</span>
                                            <span class="seat-value">${seatInfo != null ? seatInfo.availableEco : avion.capacite_eco}/${avion.capacite_eco}</span>
                                        </div>
                                        <c:if test="${seatInfo != null}">
                                            <div style="font-size: 12px; color: #666; margin-left: 0;">
                                                Réservées: ${seatInfo.reservedEco} | Disponibles: ${seatInfo.availableEco}
                                            </div>
                                        </c:if>
                                        <div class="seat-info">
                                            <span class="seat-label">Classe Business:</span>
                                            <span class="seat-value">${seatInfo != null ? seatInfo.availableBusiness : avion.capacite_business}/${avion.capacite_business}</span>
                                        </div>
                                        <c:if test="${seatInfo != null}">
                                            <div style="font-size: 12px; color: #666; margin-left: 0;">
                                                Réservées: ${seatInfo.reservedBusiness} | Disponibles: ${seatInfo.availableBusiness}
                                            </div>
                                        </c:if>
                                        <c:if test="${seatInfo != null}">
                                            <hr style="margin: 10px 0; border: none; border-top: 1px solid #e3e6ea;">
                                            <div class="seat-info">
                                                <span class="seat-label">Total Disponible:</span>
                                                <span class="seat-value">${seatInfo.totalAvailable}/${seatInfo.totalSeats}</span>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>

            <h3 style="margin-top: 30px; margin-bottom: 15px;">Itinéraire Complet</h3>
            <c:choose>
                <c:when test="${empty segments}">
                    <p>Aucun segment défini.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach var="seg" items="${segments}" varStatus="status">
                        <div class="segment">
                            <strong>Tronçon ${seg.ordre_segment}:</strong><br>
                            ${seg.aeroport_depart} → ${seg.aeroport_arrivee}<br>
                            Départ: ${seg.heure_depart_UTC} | Arrivée: ${seg.heure_arrivee_UTC}
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

            <div style="margin-top: 20px;">
                <a href="${pageContext.request.contextPath}/vols" class="btn btn-secondary">Retour</a>
            </div>
            <div style="margin-top: 20px;">
                <a href="${pageContext.request.contextPath}/reservations/complet" class="btn btn-secondary">Reserver</a>
            </div>
            <div style="margin-top: 20px;">
                <a href="${pageContext.request.contextPath}/vols/liste" class="btn btn-secondary">Liste</a>
            </div>
        </div>
    </div>
</body>
</html>
