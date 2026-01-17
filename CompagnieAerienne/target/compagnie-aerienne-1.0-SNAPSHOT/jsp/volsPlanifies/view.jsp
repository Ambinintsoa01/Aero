<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.aero.model.VolPlanifie" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    VolPlanifie volPlanifie = (VolPlanifie) request.getAttribute("volPlanifie");
    String contextPath = request.getContextPath();

    @SuppressWarnings("unchecked")
    List<Map<String, Object>> classesInfos = (List<Map<String, Object>>) request.getAttribute("classesInfos");
    @SuppressWarnings("unchecked")
    List<Map<String, Object>> billetsDetail = (List<Map<String, Object>>) request.getAttribute("billetsDetail");
    Double revenuMaximal = (Double) request.getAttribute("revenuMaximal");
    Double caReel = (Double) request.getAttribute("caReel");
    
    String error = (String) request.getAttribute("error");
    
    // Format pour afficher les montants
    NumberFormat formatAriary = NumberFormat.getNumberInstance(Locale.FRANCE);
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails Vol Planifié</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
    <style>
        .status-badge {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 14px;
        }
        .status-badge.status-planifie {
            background: #dbeafe;
            color: #1e40af;
        }
        .status-badge.status-decole {
            background: #fef3c7;
            color: #92400e;
        }
        .status-badge.status-atterri {
            background: #dcfce7;
            color: #15803d;
        }
        .status-badge.status-annule {
            background: #fee2e2;
            color: #991b1b;
        }
        .trajet-highlight {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            margin: 20px 0;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .trajet-highlight h3 {
            margin: 0 0 10px 0;
            font-size: 16px;
            opacity: 0.9;
        }
        .trajet-route {
            font-size: 28px;
            font-weight: bold;
            margin: 10px 0;
        }
        .horaire-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-top: 15px;
        }
        .horaire-card {
            background: rgba(255,255,255,0.2);
            padding: 15px;
            border-radius: 8px;
            backdrop-filter: blur(10px);
        }
        .horaire-card-title {
            font-size: 12px;
            opacity: 0.9;
            margin-bottom: 8px;
        }
        .horaire-card-value {
            font-size: 16px;
            font-weight: bold;
        }
        .avion-info {
            background: #f0f9ff;
            padding: 15px;
            border-radius: 8px;
            margin-top: 10px;
            border-left: 4px solid #3b82f6;
        }
        .avion-info-title {
            font-weight: bold;
            color: #1e40af;
            margin-bottom: 10px;
        }
        .avion-row {
            display: flex;
            justify-content: space-between;
            padding: 5px 0;
            border-bottom: 1px solid #e5e7eb;
        }
        .avion-row:last-child {
            border-bottom: none;
        }
        .revenue-highlight {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            margin: 20px 0;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .revenue-highlight h3 {
            margin: 0 0 10px 0;
            font-size: 16px;
            opacity: 0.9;
        }
        .revenue-amount {
            font-size: 32px;
            font-weight: bold;
            margin: 10px 0;
        }
        .seat-breakdown {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 15px;
            flex-wrap: wrap;
        }
        .seat-card {
            background: rgba(255,255,255,0.2);
            padding: 15px 20px;
            border-radius: 8px;
            backdrop-filter: blur(10px);
        }
        .seat-card-title {
            font-size: 12px;
            opacity: 0.9;
            margin-bottom: 5px;
        }
        .seat-card-value {
            font-size: 24px;
            font-weight: bold;
        }
        .tarif-info {
            background: #f0f9ff;
            padding: 15px;
            border-radius: 8px;
            margin-top: 10px;
            border-left: 4px solid #3b82f6;
        }
        .tarif-info-title {
            font-weight: bold;
            color: #1e40af;
            margin-bottom: 10px;
        }
        .tarif-row {
            display: flex;
            justify-content: space-between;
            padding: 5px 0;
            border-bottom: 1px solid #e5e7eb;
        }
        .tarif-row:last-child {
            border-bottom: none;
            padding-top: 10px;
            font-weight: bold;
            color: #1e40af;
        }
    </style>
</head>
<body>
    <jsp:include page="/jsp/components/sidebar.jsp" />
    <div class="main-content">
        <header class="header">
            <h1>Détails du Vol Planifié</h1>
        </header>
        <div class="container">
            <div class="content-wrapper">
                <% if (error != null) { %>
                    <div class="alert alert-error"><%= error %></div>
                <% } %>
                
                <% if (volPlanifie == null) { %>
                    <div class="alert alert-error">Vol planifié non trouvé</div>
                <% } else { %>
                    <div class="detail-section">
                        <h2>Informations Générales</h2>
                        <div class="info-grid">
                            <span class="info-label">Code Vol:</span>
                            <span class="info-value"><%= volPlanifie.getCode_vol() %></span>
                            <span class="info-label">Statut:</span>
                            <span class="info-value">
                                <span class="status-badge status-<%= volPlanifie.getStatus().toLowerCase() %>"><%= volPlanifie.getStatus() %></span>
                            </span>
                        </div>
                    </div>

                    <!-- Trajet et Horaires -->
                    <div class="detail-section">
                        <h2>✈️ Trajet et Itinéraire</h2>
                        
                        <!-- Route Principale -->
                        <div class="trajet-highlight">
                            <h3>Route du Vol</h3>
                            <div class="trajet-route">
                                <%= volPlanifie.getAeroport_origine_code() != null ? volPlanifie.getAeroport_origine_code() : "?" %>
                                <span style="font-size: 24px;">→</span>
                                <%= volPlanifie.getAeroport_destination_code() != null ? volPlanifie.getAeroport_destination_code() : "?" %>
                            </div>
                        </div>

                        <!-- Horaires Détaillés -->
                        <h3 style="margin-top: 20px; margin-bottom: 15px;">🕐 Horaires</h3>
                        <div class="horaire-grid" style="background: #f8f9fa; padding: 20px; border-radius: 8px;">
                            <div style="background: #fef3c7; padding: 15px; border-radius: 8px; border-left: 4px solid #f59e0b;">
                                <div style="font-size: 12px; color: #92400e; margin-bottom: 5px;">📤 Départ Prévu</div>
                                <div style="font-size: 18px; font-weight: bold; color: #b45309;"><%= volPlanifie.getDate_prev_depart() %></div>
                            </div>
                            <div style="background: #dbeafe; padding: 15px; border-radius: 8px; border-left: 4px solid #3b82f6;">
                                <div style="font-size: 12px; color: #1e40af; margin-bottom: 5px;">📥 Arrivée Prévue</div>
                                <div style="font-size: 18px; font-weight: bold; color: #1e40af;"><%= volPlanifie.getDate_prev_arrivee() %></div>
                            </div>
                            <div style="background: #dcfce7; padding: 15px; border-radius: 8px; border-left: 4px solid #15803d;">
                                <div style="font-size: 12px; color: #15803d; margin-bottom: 5px;">📤 Départ Réel</div>
                                <div style="font-size: 18px; font-weight: bold; color: #15803d;"><%= volPlanifie.getDate_reelle_depart() != null ? volPlanifie.getDate_reelle_depart() : "-" %></div>
                            </div>
                            <div style="background: #fee2e2; padding: 15px; border-radius: 8px; border-left: 4px solid #991b1b;">
                                <div style="font-size: 12px; color: #991b1b; margin-bottom: 5px;">📥 Arrivée Réelle</div>
                                <div style="font-size: 18px; font-weight: bold; color: #991b1b;"><%= volPlanifie.getDate_reelle_arrivee() != null ? volPlanifie.getDate_reelle_arrivee() : "-" %></div>
                            </div>
                        </div>
                    </div>

                    <div class="detail-section">
                        <h2>✈️ Détails de l'Avion</h2>
                        <div class="info-grid">
                            <span class="info-label">Immatriculation:</span>
                            <span class="info-value"><%= volPlanifie.getImmatriculation_avion() %></span>
                            <span class="info-label">Capacité:</span>
                            <span class="info-value highlight-box"><%= volPlanifie.getCapacite_avion() %> passagers</span>
                        </div>
                        
                        <!-- Informations Avion détaillées -->
                        <div class="avion-info">
                            <div class="avion-info-title">ℹ️ Informations Détaillées</div>
                            <div class="avion-row">
                                <span>Immatriculation</span>
                                <span><strong><%= volPlanifie.getImmatriculation_avion() %></strong></span>
                            </div>
                            <div class="avion-row">
                                <span>Capacité Totale</span>
                                <span><strong><%= volPlanifie.getCapacite_avion() %> places</strong></span>
                            </div>
                        </div>
                    </div>

                    <!-- Configuration des Sièges et Revenu Maximal -->
                    <div class="detail-section">
                        <h2>💺 Configuration des Sièges et Potentiel de Revenu</h2>
                        
                        <div class="seat-breakdown" style="background: #f8f9fa; padding: 20px; border-radius: 8px; justify-content: flex-start;">
                            <% 
                            if (classesInfos != null && !classesInfos.isEmpty()) {
                                for (Map<String, Object> classeInfo : classesInfos) {
                                    String libelle = (String) classeInfo.get("libelle");
                                    int nbSieges = (Integer) classeInfo.get("nb_sieges");
                                    double tarif = (Double) classeInfo.get("tarif");
                            %>
                            <div style="flex: 1; min-width: 200px;">
                                <div style="background: #dbeafe; padding: 15px; border-radius: 8px; border-left: 4px solid #3b82f6;">
                                    <div style="font-size: 12px; color: #1e40af; margin-bottom: 5px;">✈️ <%= libelle %></div>
                                    <div style="font-size: 28px; font-weight: bold; color: #1e40af;"><%= nbSieges %> sièges</div>
                                    <div style="font-size: 13px; color: #1e40af; margin-top: 5px;"><%= formatAriary.format(tarif) %> Ar / siège</div>
                                </div>
                            </div>
                            <%
                                }
                            } else {
                            %>
                            <div>Aucune classe configurée</div>
                            <% } %>
                        </div>

                        <!-- Calcul du Revenu -->
                        <div class="tarif-info">
                            <div class="tarif-info-title">📊 Calcul du Revenu Maximal</div>
                            <% 
                            if (classesInfos != null && !classesInfos.isEmpty()) {
                                for (Map<String, Object> classeInfo : classesInfos) {
                                    String libelle = (String) classeInfo.get("libelle");
                                    int nbSieges = (Integer) classeInfo.get("nb_sieges");
                                    double tarif = (Double) classeInfo.get("tarif");
                                    double revenu = nbSieges * tarif;
                            %>
                            <div class="tarif-row">
                                <span><%= libelle %>: <%= nbSieges %> × <%= formatAriary.format(tarif) %> Ar</span>
                                <span><%= formatAriary.format(revenu) %> Ar</span>
                            </div>
                            <%
                                }
                            }
                            %>
                            <div class="tarif-row">
                                <span>REVENU MAXIMAL</span>
                                <span><%= formatAriary.format(revenuMaximal != null ? revenuMaximal : 0.0) %> Ar</span>
                            </div>
                        </div>

                        <!-- Encadré du Revenu Maximal -->
                        <div class="revenue-highlight">
                            <h3>💰 Revenu Maximal Potentiel par Vol</h3>
                            <div class="revenue-amount"><%= formatAriary.format(revenuMaximal != null ? revenuMaximal : 0.0) %> Ar</div>
                            <div style="font-size: 14px; opacity: 0.9;">Basé sur un vol complet</div>
                        </div>
                    </div>

                    <!-- CA Réel Généré -->
                    <% if (billetsDetail != null && !billetsDetail.isEmpty()) { %>
                    <div class="detail-section">
                        <h2>💵 Chiffre d'Affaires Réel Généré</h2>
                        
                        <div class="revenue-highlight" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%);">
                            <h3>💵 CA Réel du Vol (Billets Vendus)</h3>
                            <div class="revenue-amount"><%= formatAriary.format(caReel != null ? caReel : 0.0) %> Ar</div>
                            <div style="font-size: 14px; opacity: 0.9;"><%= billetsDetail.size() %> billet(s) vendu(s)</div>
                        </div>

                        <!-- Détail des billets vendus -->
                        <div class="tarif-info">
                            <div class="tarif-info-title">📋 Détail des Billets Vendus</div>
                            <table style="width: 100%; border-collapse: collapse;">
                                <thead style="background: #f3f4f6;">
                                    <tr style="border-bottom: 2px solid #e5e7eb;">
                                        <th style="padding: 10px; text-align: left;">N° Billet</th>
                                        <th style="padding: 10px; text-align: left;">Passager</th>
                                        <th style="padding: 10px; text-align: left;">Type</th>
                                        <th style="padding: 10px; text-align: left;">Classe</th>
                                        <th style="padding: 10px; text-align: right;">Tarif Base</th>
                                        <th style="padding: 10px; text-align: right;">Prix Payé</th>
                                        <th style="padding: 10px; text-align: center;">Remise</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                    for (Map<String, Object> billet : billetsDetail) {
                                        String numBillet = (String) billet.get("numero_billet");
                                        String passager = (String) billet.get("passager");
                                        String typePassager = (String) billet.get("type_passager");
                                        String classe = (String) billet.get("classe");
                                        double tarifBase = (Double) billet.get("tarif_base");
                                        double prixApplique = (Double) billet.get("prix_applique");
                                        boolean remiseAppliquee = (Boolean) billet.get("remise_appliquee");
                                    %>
                                    <tr style="border-bottom: 1px solid #e5e7eb;">
                                        <td style="padding: 10px;"><%= numBillet %></td>
                                        <td style="padding: 10px;"><%= passager %></td>
                                        <td style="padding: 10px;"><%= typePassager %></td>
                                        <td style="padding: 10px;"><%= classe %></td>
                                        <td style="padding: 10px; text-align: right; <%= remiseAppliquee ? "text-decoration: line-through; opacity: 0.6;" : "" %>">
                                            <%= formatAriary.format(tarifBase) %> Ar
                                        </td>
                                        <td style="padding: 10px; text-align: right; font-weight: bold; <%= remiseAppliquee ? "color: #059669;" : "" %>">
                                            <%= formatAriary.format(prixApplique) %> Ar
                                        </td>
                                        <td style="padding: 10px; text-align: center;">
                                            <% if (remiseAppliquee) { %>
                                                <span style="background: #dcfce7; color: #15803d; padding: 4px 8px; border-radius: 4px; font-size: 12px;">✓ Remise</span>
                                            <% } else { %>
                                                <span style="opacity: 0.5;">-</span>
                                            <% } %>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                                <tfoot style="background: #f3f4f6; font-weight: bold;">
                                    <tr>
                                        <td colspan="5" style="padding: 10px; text-align: right;">TOTAL CA:</td>
                                        <td style="padding: 10px; text-align: right; color: #059669; font-size: 16px;">
                                            <%= formatAriary.format(caReel != null ? caReel : 0.0) %> Ar
                                        </td>
                                        <td></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                    <% } %>

                    <div class="button-group">
                        <a href="<%= contextPath %>/volsPlanifies?action=edit&id=<%= volPlanifie.getId() %>" class="btn btn-primary">
                            Éditer
                        </a>
                        <a href="<%= contextPath %>/volsPlanifies" class="btn">
                            Retour à la liste
                        </a>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
    <footer>
        <p>&copy; 2026 Compagnie Aérienne</p>
    </footer>
</body>
</html>

