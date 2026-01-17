<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:if test="${aeroport == null}">Créer</c:if><c:if test="${aeroport != null}">Éditer</c:if> Aéroport</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modern-theme.css">
</head>
<body>
    <jsp:include page="/jsp/components/sidebar.jsp" />
    <div class="main-content">
        <header class="header">
            <h1>🏢 <c:if test="${aeroport == null}">Créer un Aéroport</c:if><c:if test="${aeroport != null}">Éditer l'Aéroport</c:if></h1>
        </header>
        <div class="container">
            <div class="content-wrapper">
                <form method="POST" action="${pageContext.request.contextPath}/aeroports" class="form">
                    <input type="hidden" name="action" value="${aeroport == null ? 'save' : 'update'}">
                    <c:if test="${aeroport != null}">
                        <input type="hidden" name="id" value="${aeroport.id_aeroport}">
                    </c:if>

                    <div class="form-group">
                        <label for="code">Code *</label>
                        <input type="text" id="code" name="code" 
                               value="${aeroport != null ? aeroport.code : ''}" required maxlength="10" placeholder="Ex: CDG">
                    </div>

                    <div class="form-group">
                        <label for="nom">Nom *</label>
                        <input type="text" id="nom" name="nom" 
                               value="${aeroport != null ? aeroport.nom : ''}" required placeholder="Nom de l'aéroport">
                    </div>

                    <div class="form-group">
                        <label for="pays">Pays *</label>
                        <input type="text" id="pays" name="pays" 
                               value="${aeroport != null ? aeroport.pays : ''}" required placeholder="Pays">
                    </div>

                    <div class="form-group">
                        <label for="ville">Ville *</label>
                        <input type="text" id="ville" name="ville" 
                               value="${aeroport != null ? aeroport.ville : ''}" required placeholder="Ville">
                    </div>

                    <div class="button-group">
                        <button type="submit" class="btn btn-primary">
                            <c:if test="${aeroport == null}">✈️ Créer</c:if>
                            <c:if test="${aeroport != null}">✈️ Mettre à jour</c:if>
                        </button>
                        <a href="${pageContext.request.contextPath}/aeroports" class="btn">❌ Annuler</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <footer>
        <p>&copy; 2026 Compagnie Aérienne</p>
    </footer>
</body>
</html>

