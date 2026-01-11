<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aéroports - Compagnie Aérienne</title>
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
        .card-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
        .filters { background: #f8f9fa; padding: 15px; border-radius: 8px; border: 1px solid #e3e6ea; margin-bottom: 15px; }
        .filter-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 12px; }
        .form-group { margin-bottom: 0; }
        .form-group label { display: block; margin-bottom: 6px; font-weight: 600; color: #2c3e50; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-family: inherit; }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus { outline: none; border-color: #3498db; box-shadow: 0 0 5px rgba(52,152,219,0.3); }
        .filter-actions { display: flex; gap: 10px; margin-top: 12px; }
        .btn-secondary { background: #95a5a6; }
        .btn-secondary:hover { background: #7f8c8d; }
        .badge { display: inline-block; padding: 4px 8px; border-radius: 4px; font-size: 12px; }
        .badge-primary { background: #3498db; color: white; }
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
            <a href="${pageContext.request.contextPath}/aeroports" class="active">
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
            <div>
                <h1>Aéroports</h1>
                <div class="breadcrumb">
                    <a href="${pageContext.request.contextPath}/">Accueil</a>
                    <span class="separator">/</span>
                    <span>Aéroports</span>
                </div>
            </div>
        </div>

        <div class="container">
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <c:if test="${not empty erreur}">
                <div class="alert alert-danger">${erreur}</div>
            </c:if>

            <div class="card">
                <div class="card-header">
                    <h2>Liste des aéroports</h2>
                    <a href="${pageContext.request.contextPath}/aeroports/nouveau" class="btn btn-primary">
                        <span>➕</span>
                        Ajouter un aéroport
                    </a>
                </div>

                <form method="GET" class="filters">
                    <div class="filter-grid">
                        <div class="form-group">
                            <label for="code">Code IATA</label>
                            <input type="text" id="code" name="code" value="${code}" placeholder="Ex: CDG">
                        </div>
                        <div class="form-group">
                            <label for="nom">Nom</label>
                            <input type="text" id="nom" name="nom" value="${nom}" placeholder="Rechercher par nom">
                        </div>
                        <div class="form-group">
                            <label for="ville">Ville</label>
                            <input type="text" id="ville" name="ville" value="${ville}" placeholder="Filtrer par ville">
                        </div>
                        <div class="form-group">
                            <label for="pays">Pays</label>
                            <input type="text" id="pays" name="pays" value="${pays}" placeholder="Filtrer par pays">
                        </div>
                    </div>
                    <div class="filter-actions">
                        <button type="submit" class="btn btn-primary">Filtrer</button>
                        <a href="${pageContext.request.contextPath}/aeroports" class="btn btn-secondary">Réinitialiser</a>
                    </div>
                </form>

                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Code IATA</th>
                                <th>Nom</th>
                                <th>Ville</th>
                                <th>Pays</th>
                                <th>Fuseau Horaire</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="aero" items="${aeroports}">
                                <tr>
                                    <td><span class="badge badge-primary">${aero.code_iata}</span></td>
                                    <td>${aero.nom}</td>
                                    <td>${aero.ville}</td>
                                    <td>${aero.pays}</td>
                                    <td>${aero.fuseau_horaire}</td>
                                    <td>
                                        <form method="POST" action="${pageContext.request.contextPath}/aeroports" style="display: inline;">
                                            <input type="hidden" name="action" value="supprimer">
                                            <input type="hidden" name="code_iata" value="${aero.code_iata}">
                                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet aéroport ?')">
                                                <span>🗑️</span>
                                                Supprimer
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
