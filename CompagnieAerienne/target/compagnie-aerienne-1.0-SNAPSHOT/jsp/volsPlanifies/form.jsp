<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.aero.model.Vol" %>
<%@ page import="com.aero.model.Avion" %>
<%@ page import="com.aero.model.VolPlanifie" %>
<%
    String contextPath = request.getContextPath();
    VolPlanifie volPlanifie = (VolPlanifie) request.getAttribute("volPlanifie");
    List<Vol> vols = (List<Vol>) request.getAttribute("vols");
    List<Avion> avions = (List<Avion>) request.getAttribute("avions");
    boolean isEdit = (volPlanifie != null);
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isEdit ? "Éditer" : "Créer" %> Vol Planifié</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
    <style>
        .tarif-section {
            background: #f0f9ff;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
            border-left: 4px solid #3b82f6;
            display: none;
        }
        .tarif-section.active {
            display: block;
        }
        .tarif-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-top: 15px;
        }
        .tarif-input-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        .tarif-input-group label {
            font-weight: 600;
            color: #1e40af;
            font-size: 14px;
        }
        .tarif-input-group input {
            padding: 10px;
            border: 1px solid #cbd5e1;
            border-radius: 4px;
            font-size: 14px;
        }
        .tarif-info {
            background: #e0e7ff;
            padding: 10px 15px;
            border-radius: 4px;
            font-size: 13px;
            color: #1e40af;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <jsp:include page="/jsp/components/sidebar.jsp" />
    <div class="main-content">
        <header class="header">
            <h1>📅 <%= isEdit ? "Éditer la Planification" : "Planifier un Vol" %></h1>
        </header>
        <div class="container">
            <div class="content-wrapper">
                <form method="POST" action="<%= contextPath %>/volsPlanifies" class="form">
                    <input type="hidden" name="action" value="<%= isEdit ? "update" : "save" %>">
                    <% if (isEdit) { %>
                        <input type="hidden" name="id" value="<%= volPlanifie.getId() %>">
                    <% } %>

                    <div class="form-group">
                        <label for="id_vol_mere">Vol *</label>
                        <select id="id_vol_mere" name="id_vol_mere" required>
                            <option value="">-- Sélectionner un vol --</option>
                            <% 
                                if (vols != null) {
                                    for (Vol vol : vols) {
                                        boolean selected = isEdit && volPlanifie.getId_vol_mere() == vol.getId();
                            %>
                                        <option value="<%= vol.getId() %>" <%= selected ? "selected" : "" %>>
                                            <%= vol.getCode_vol() %> : 
                                            <%= vol.getAeroport_origine_code() %> - <%= vol.getAeroport_destination_code() %> 
                                        </option>
                            <% 
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="id_avion">Avion *</label>
                        <select id="id_avion" name="id_avion" required>
                            <option value="">-- Sélectionner un avion --</option>
                            <% 
                                if (avions != null) {
                                    for (Avion avion : avions) {
                                        boolean selected = isEdit && volPlanifie.getId_avion() == avion.getId();
                            %>
                                        <option value="<%= avion.getId() %>" 
                                                data-id="<%= avion.getId() %>"
                                                data-immatriculation="<%= avion.getImmatriculation() %>"
                                                <%= selected ? "selected" : "" %>>
                                            <%= avion.getImmatriculation() %> - <%= avion.getModele() %>
                                        </option>
                            <% 
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <!-- Section Tarifs - S'affichera quand un avion est sélectionné -->
                    <div class="tarif-section" id="tarifSection">
                        <h3 style="margin-top: 0; color: #1e40af; margin-bottom: 15px;">💰 Configuration des Tarifs</h3>
                        <p style="font-size: 13px; color: #475569; margin: 0 0 15px 0;">Définissez les tarifs pour chaque classe de ce vol</p>
                        
                        <div class="tarif-grid">
                            <div class="tarif-input-group">
                                <label for="tarif_premiere_classe">✨ Tarif Première Classe (Ar)</label>
                                <input type="number" id="tarif_premiere_classe" name="tarif_premiere_classe" 
                                       value="1200000" min="0" step="10000" placeholder="Ex: 1200000">
                                <div class="tarif-info">Tarif par siège première classe</div>
                            </div>
                            <div class="tarif-input-group">
                                <label for="tarif_economique">🪑 Tarif Classe Économique (Ar)</label>
                                <input type="number" id="tarif_economique" name="tarif_economique" 
                                       value="700000" min="0" step="10000" placeholder="Ex: 700000">
                                <div class="tarif-info">Tarif par siège classe économique</div>
                            </div>
                        </div>
                    </div>


                    <div class="form-group">
                        <label for="date_reelle_depart">Date Réelle Départ *</label>
                        <input type="datetime-local" id="date_reelle_depart" name="date_reelle_depart" 
                               value="<%= isEdit && volPlanifie.getDate_reelle_depart() != null ? volPlanifie.getDate_reelle_depart().toString() : "" %>" required>
                    </div>

                    <div class="form-group">
                        <label for="date_reelle_arrivee">Date Réelle Arrivée *</label>
                        <input type="datetime-local" id="date_reelle_arrivee" name="date_reelle_arrivee" 
                               value="<%= isEdit && volPlanifie.getDate_reelle_arrivee() != null ? volPlanifie.getDate_reelle_arrivee().toString() : "" %>" required>
                    </div>

                    <% if (isEdit) { %>
                    <div class="form-group">
                        <label for="status">Statut *</label>
                        <select id="status" name="status" required>
                            <option value="PROGRAMME" <%= "PROGRAMME".equals(volPlanifie.getStatus()) ? "selected" : "" %>>PROGRAMME</option>
                            <option value="EN_VOL" <%= "EN_VOL".equals(volPlanifie.getStatus()) ? "selected" : "" %>>EN VOL</option>
                            <option value="TERMINE" <%= "TERMINE".equals(volPlanifie.getStatus()) ? "selected" : "" %>>TERMINÉ</option>
                            <option value="ANNULE" <%= "ANNULE".equals(volPlanifie.getStatus()) ? "selected" : "" %>>ANNULÉ</option>
                            <option value="REPORTE" <%= "REPORTE".equals(volPlanifie.getStatus()) ? "selected" : "" %>>REPORTÉ</option>
                        </select>
                    </div>
                    <% } %>

                    <div class="button-group">
                        <button type="submit" class="btn btn-primary">
                            <%= isEdit ? "📅 Mettre à jour" : "📅 Planifier" %>
                        </button>
                        <a href="<%= contextPath %>/volsPlanifies" class="btn">❌ Annuler</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <footer>
        <p>&copy; 2026 Compagnie Aérienne</p>
    </footer>

    <script>
        // Afficher/masquer la section tarifs selon la sélection d'avion
        document.getElementById('id_avion').addEventListener('change', function() {
            const tarifSection = document.getElementById('tarifSection');
            const tarifPremiere = document.getElementById('tarif_premiere_classe');
            const tarifEco = document.getElementById('tarif_economique');
            
            if (this.value) {
                tarifSection.classList.add('active');
                
                // Charger les tarifs existants de l'avion sélectionné via AJAX
                const avionId = this.value;
                fetch('<%= contextPath %>/api/tarifs?avionId=' + avionId)
                    .then(response => {
                        if (response.ok) {
                            return response.json();
                        }
                        // Si pas de tarifs trouvés, utiliser les valeurs par défaut
                        return null;
                    })
                    .then(data => {
                        if (data && data.tarifPremiere) {
                            tarifPremiere.value = data.tarifPremiere;
                            tarifEco.value = data.tarifEco;
                        }
                    })
                    .catch(error => {
                        console.log('Tarifs par défaut appliqués');
                    });
            } else {
                tarifSection.classList.remove('active');
            }
        });

        // Trigger au chargement de la page pour afficher la section si un avion est pré-sélectionné
        window.addEventListener('load', function() {
            if (document.getElementById('id_avion').value) {
                document.getElementById('id_avion').dispatchEvent(new Event('change'));
            }
        });
    </script>
</body>
</html>

