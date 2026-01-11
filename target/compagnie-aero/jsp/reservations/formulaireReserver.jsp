<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nouvelle Réservation</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; padding: 30px; }
        .container { max-width: 800px; margin: 0 auto; }
        .header { background: white; padding: 30px; border-radius: 15px 15px 0 0; box-shadow: 0 5px 20px rgba(0,0,0,0.1); }
        .header h1 { color: #667eea; font-size: 2em; margin-bottom: 10px; }
        .breadcrumb { color: #666; font-size: 0.9em; }
        .breadcrumb a { color: #667eea; text-decoration: none; }
        .breadcrumb a:hover { text-decoration: underline; }
        .form-card { background: white; padding: 40px; border-radius: 0 0 15px 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 25px; }
        .form-group label { display: block; margin-bottom: 8px; color: #333; font-weight: 600; font-size: 0.95em; }
        .form-group input, .form-group select { width: 100%; padding: 12px 15px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 1em; transition: all 0.3s ease; }
        .form-group input:focus, .form-group select:focus { outline: none; border-color: #667eea; box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1); }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .btn-group { display: flex; gap: 15px; margin-top: 30px; }
        .btn { padding: 14px 28px; border: none; border-radius: 8px; font-size: 1em; font-weight: 600; cursor: pointer; transition: all 0.3s ease; text-decoration: none; display: inline-block; text-align: center; }
        .btn-primary { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4); }
        .btn-secondary { background: #e0e0e0; color: #333; }
        .btn-secondary:hover { background: #d0d0d0; }
        .instance-info { background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 25px; }
        .instance-info h3 { color: #667eea; margin-bottom: 15px; }
        .instance-info p { margin: 5px 0; color: #555; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>✈️ Nouvelle Réservation</h1>
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/">Accueil</a> &gt; 
                <a href="${pageContext.request.contextPath}/reservations">Réservations</a> &gt;
                <a href="${pageContext.request.contextPath}/reservations/recherche">Recherche</a> &gt;
                Réserver
            </div>
        </div>

        <div class="form-card">
            <form action="${pageContext.request.contextPath}/reservations" method="post">
                <input type="hidden" name="action" value="creer">
                <input type="hidden" name="instance_ids" value="${instanceId}">

                <div class="form-group">
                    <label for="passager_id">Passager *</label>
                    <select id="passager_id" name="passager_id" required>
                        <option value="">-- Sélectionner un passager --</option>
                        <c:forEach var="passager" items="${passagers}">
                            <option value="${passager.passager_id}">
                                ${passager.nom} ${passager.prenom} - ${passager.email}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">✓ Confirmer la Réservation</button>
                    <a href="${pageContext.request.contextPath}/reservations/recherche" class="btn btn-secondary">← Retour</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
