<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:if test="${vol == null}">Créer</c:if><c:if test="${vol != null}">Éditer</c:if> Vol</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modern-theme.css">
</head>
<body>
    <jsp:include page="/jsp/components/sidebar.jsp" />
    <div class="main-content">
        <header class="header">
            <h1>🛫 <c:if test="${vol == null}">Créer un Vol</c:if><c:if test="${vol != null}">Éditer le Vol</c:if></h1>
        </header>
        <div class="container">
            <div class="content-wrapper">
                <form method="POST" action="${pageContext.request.contextPath}/vols" class="form">
                    <input type="hidden" name="action" value="${vol == null ? 'save' : 'update'}">
                    <c:if test="${vol != null}">
                        <input type="hidden" name="id" value="${vol.id_vol}">
                    </c:if>

                    <div class="form-group">
                        <label for="codeVol">Code Vol *</label>
                        <input type="text" id="codeVol" name="codeVol" 
                               value="${vol != null ? vol.codeVol : ''}" required maxlength="20" placeholder="Ex: AF123">
                    </div>

                    <div class="form-group">
                        <label for="id_avion">Avion *</label>
                        <select id="id_avion" name="id_avion" required>
                            <option value="">-- Sélectionner un avion --</option>
                            <c:forEach var="avion" items="${requestScope.avions}">
                                <option value="${avion.id}" <c:if test="${vol != null && vol.id_avion == avion.id}">selected</c:if>>
                                    ${avion.immatriculation} - ${avion.modele}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="id_aeroport_depart">Aéroport Départ *</label>
                        <select id="id_aeroport_depart" name="id_aeroport_depart" required>
                            <option value="">-- Sélectionner un aéroport --</option>
                            <c:forEach var="aeroport" items="${requestScope.aeroports}">
                                <option value="${aeroport.id_aeroport}" <c:if test="${vol != null && vol.id_aeroport_depart == aeroport.id_aeroport}">selected</c:if>>
                                    ${aeroport.code} - ${aeroport.nom}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="id_aeroport_arrivee">Aéroport Arrivée *</label>
                        <select id="id_aeroport_arrivee" name="id_aeroport_arrivee" required>
                            <option value="">-- Sélectionner un aéroport --</option>
                            <c:forEach var="aeroport" items="${requestScope.aeroports}">
                                <option value="${aeroport.id_aeroport}" <c:if test="${vol != null && vol.id_aeroport_arrivee == aeroport.id_aeroport}">selected</c:if>>
                                    ${aeroport.code} - ${aeroport.nom}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="heure_depart_prevue">Heure Départ Prévue *</label>
                        <input type="datetime-local" id="heure_depart_prevue" name="heure_depart_prevue" 
                               value="${vol != null ? vol.heure_depart_prevue : ''}" required>
                    </div>

                    <div class="form-group">
                        <label for="heure_arrivee_prevue">Heure Arrivée Prévue *</label>
                        <input type="datetime-local" id="heure_arrivee_prevue" name="heure_arrivee_prevue" 
                               value="${vol != null ? vol.heure_arrivee_prevue : ''}" required>
                    </div>

                    <div class="button-group">
                        <button type="submit" class="btn btn-primary">
                            <c:if test="${vol == null}">✈️ Créer</c:if>
                            <c:if test="${vol != null}">✈️ Mettre à jour</c:if>
                        </button>
                        <a href="${pageContext.request.contextPath}/vols" class="btn">❌ Annuler</a>
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

