<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détails Réservation</title>
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
        .btn-danger { background: #e74c3c; }
        .btn-danger:hover { background: #c0392b; }
        .card { background: white; padding: 20px; border-radius: 8px; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .badge { display: inline-block; padding: 5px 10px; border-radius: 3px; font-size: 12px; font-weight: bold; background: #d4edda; color: #155724; }
        .info-group { margin-bottom: 15px; padding: 10px; background: #f9f9f9; border-radius: 3px; }
        .info-label { font-weight: bold; color: #2c3e50; }
        .mt-2 { margin-top: 15px; }
    </style>
</head>
<body>
    <nav>
        <a href="${pageContext.request.contextPath}/">🏠 Accueil</a>
        <a href="${pageContext.request.contextPath}/reservations">🎫 Réservations</a>
    </nav>

    <div class="container">
        <div class="card">
            <h1>Détails de la Réservation</h1>

            <div class="info-group">
                <span class="info-label">PNR:</span>
                <p><strong>${reservation.pnr}</strong></p>
            </div>

            <div class="info-group">
                <span class="info-label">Passager ID:</span>
                <p>${reservation.passager_id}</p>
            </div>

            <div class="info-group">
                <span class="info-label">Date de Réservation:</span>
                <p>${reservation.date_reservation}</p>
            </div>

            <div class="info-group">
                <span class="info-label">Statut de Paiement:</span>
                <p><span class="badge badge-confirmed">${reservation.statut_paiement}</span></p>
            </div>

            <form method="POST" action="${pageContext.request.contextPath}/reservations" style="margin-top: 20px;">
                <input type="hidden" name="reservation_id" value="${reservation.reservation_id}">
                <input type="hidden" name="action" value="generer_pdf">
                <button type="submit" class="btn">Générer Billet PDF</button>
            </form>

            <a href="${pageContext.request.contextPath}/reservations" class="btn" style="margin-top: 10px;">Retour</a>
        </div>
    </div>
</body>
</html>
