<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:if test="${avion == null}">Créer</c:if><c:if test="${avion != null}">Éditer</c:if> Avion</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modern-theme.css">
</head>
<body>
    <jsp:include page="/jsp/components/sidebar.jsp" />
    <div class="main-content">
        <header class="header">
            <h1>✈️ <c:if test="${avion == null}">Créer un nouvel Avion</c:if><c:if test="${avion != null}">Éditer l'Avion</c:if></h1>
        </header>
        <div class="container">
            <div class="content-wrapper">

    <form method="POST" action="${pageContext.request.contextPath}/avions" class="form">
        <input type="hidden" name="action" value="${avion == null ? 'save' : 'update'}">
        <c:if test="${avion != null}">
            <input type="hidden" name="id" value="${avion.id}">
        </c:if>

        <div class="form-group">
            <label for="immatriculation">Immatriculation *</label>
            <input type="text" id="immatriculation" name="immatriculation" 
                   value="${avion != null ? avion.immatriculation : ''}" required>
        </div>

        <div class="form-group">
            <label for="modele">Modèle *</label>
            <input type="text" id="modele" name="modele" 
                   value="${avion != null ? avion.modele : ''}" required>
        </div>

        <div class="form-group">
            <label for="constructeur">Constructeur *</label>
            <input type="text" id="constructeur" name="constructeur" 
                   value="${avion != null ? avion.constructeur : ''}" required>
        </div>

        <div class="form-group">
            <label for="capacite">Capacité (passagers) *</label>
            <input type="number" id="capacite" name="capacite" 
                   value="${avion != null ? avion.capacite : ''}" required>
        </div>

        <div class="form-group">
            <label for="annee_fabrication">Année Fabrication *</label>
            <input type="number" id="annee_fabrication" name="annee_fabrication" 
                   value="${avion != null ? avion.annee_fabrication : ''}" required>
        </div>

        <div class="form-group">
            <label for="date_mise_service">Date Mise en Service *</label>
            <input type="date" id="date_mise_service" name="date_mise_service" 
                   value="${avion != null ? avion.date_mise_service : ''}" required>
        </div>

        <div class="button-group">
            <button type="submit" class="btn btn-primary">
                <c:if test="${avion == null}">Créer</c:if>
                <c:if test="${avion != null}">Mettre à jour</c:if>
            </button>
            <a href="${pageContext.request.contextPath}/avions" class="btn">Annuler</a>
        </div>
    </form>
</div>

<footer>
    <p>&copy; 2026 Compagnie Aérienne</p>
</footer>
</body>
</html>
