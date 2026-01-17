<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.aero.model.Avion" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%
    String contextPath = request.getContextPath();
    Avion avion = (Avion) request.getAttribute("avion");
    Integer nbPremiereClasse = (Integer) request.getAttribute("nbPremiereClasse");
    Integer nbEconomique = (Integer) request.getAttribute("nbEconomique");
    Long revenuMaximal = (Long) request.getAttribute("revenuMaximal");
    
    // Format pour afficher les montants
    NumberFormat formatAriary = NumberFormat.getNumberInstance(Locale.FRANCE);
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails Avion</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
    <style>
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
            <h1>Détails de l'Avion</h1>
        </header>
        <div class="container">
            <div class="content-wrapper">
                <% if (avion == null) { %>
                    <div class="alert alert-error">Avion non trouvé</div>
                <% } else { %>
                    <div class="detail-section">
                        <h2>Informations Générales</h2>
                        <div class="info-grid">
                            <span class="info-label">Immatriculation:</span>
                            <span class="info-value"><%= avion.getImmatriculation() %></span>
                            <span class="info-label">Modèle:</span>
                            <span class="info-value"><%= avion.getModele() %></span>
                            <span class="info-label">Constructeur:</span>
                            <span class="info-value"><%= avion.getConstructeur() %></span>
                        </div>
                    </div>

                    <div class="detail-section">
                        <h2>Caractéristiques</h2>
                        <div class="info-grid">
                            <span class="info-label">Capacité Totale:</span>
                            <span class="info-value highlight-box"><%= avion.getCapacite() %> passagers</span>
                            <span class="info-label">Année Fabrication:</span>
                            <span class="info-value"><%= avion.getAnnee_fabrication() %></span>
                            <span class="info-label">Date Mise en Service:</span>
                            <span class="info-value"><%= avion.getDate_mise_service() %></span>
                        </div>
                    </div>

                    <!-- Configuration des Sièges et Revenu Maximal -->
                    <div class="detail-section">
                        <h2>💺 Configuration des Sièges et Potentiel de Revenu</h2>
                        
                        <div class="seat-breakdown" style="background: #f8f9fa; padding: 20px; border-radius: 8px; justify-content: flex-start;">
                            <div style="flex: 1; min-width: 200px;">
                                <div style="background: #fef3c7; padding: 15px; border-radius: 8px; border-left: 4px solid #f59e0b;">
                                    <div style="font-size: 12px; color: #92400e; margin-bottom: 5px;">✨ Première Classe</div>
                                    <div style="font-size: 28px; font-weight: bold; color: #b45309;"><%= nbPremiereClasse != null ? nbPremiereClasse : 0 %> sièges</div>
                                </div>
                            </div>
                            <div style="flex: 1; min-width: 200px;">
                                <div style="background: #dbeafe; padding: 15px; border-radius: 8px; border-left: 4px solid #3b82f6;">
                                    <div style="font-size: 12px; color: #1e40af; margin-bottom: 5px;">🪑 Classe Économique</div>
                                    <div style="font-size: 28px; font-weight: bold; color: #1e40af;"><%= nbEconomique != null ? nbEconomique : 0 %> sièges</div>
                                </div>
                            </div>
                        </div>
                        
                    <div class="button-group">
                        <a href="<%= contextPath %>/avions?action=edit&id=<%= avion.getId() %>" class="btn btn-primary">
                            Éditer
                        </a>
                        <a href="<%= contextPath %>/avions" class="btn">
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

