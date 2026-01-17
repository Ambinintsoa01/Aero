<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.aero.model.Billet" %>
<%@ page import="com.aero.model.DetailReservation" %>
<%
    String contextPath = request.getContextPath();
    DetailReservation detail = (DetailReservation) request.getAttribute("detail");
    Billet billet = (Billet) request.getAttribute("billet");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails Réservation</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
    <style>
        @media print {
            .sidebar, .btn, .button-group { display: none; }
            .main-content { margin-left: 0; }
        }
    </style>
</head>
<body>
    <!-- Include Sidebar -->
    <jsp:include page="/jsp/components/sidebar.jsp" />

    <!-- Main Content Area -->
    <div class="main-content">
        <!-- Header -->
        <header class="header">
            <h1>Détails de la Réservation</h1>
        </header>

        <!-- Content Container -->
        <div class="container">
            <div class="content-wrapper">
                <% if (detail != null) { %>
                    <!-- En-tête avec numéro de billet et statut -->
                    <div class="detail-section">
                        <h2>Billet N° <%= detail.getNumeroBillet() %></h2>
                        <div class="info-grid">
                            <span class="info-label">Statut:</span>
                            <span class="info-value">
                                <span class="status-badge status-<%= detail.getBilletStatus() %>"><%= detail.getBilletStatus() %></span>
                            </span>
                            <span class="info-label">Date d'émission:</span>
                            <span class="info-value"><%= detail.getDateEmission() %></span>
                        </div>
                    </div>

                    <!-- Informations du Vol -->
                    <div class="detail-section">
                        <h2>Informations du Vol</h2>
                        <div class="info-grid">
                            <span class="info-label">Code Vol:</span>
                            <span class="info-value"><strong><%= detail.getCodeVol() %></strong></span>
                            
                            <span class="info-label">Départ:</span>
                            <span class="info-value"><%= detail.getDateReelleDepart() %></span>
                            
                            <span class="info-label">Arrivée:</span>
                            <span class="info-value"><%= detail.getDateReelleArrivee() %></span>
                
                <span class="info-label">Avion:</span>
                <span class="info-value"><%= detail.getModele() %> (<%= detail.getImmatriculation() %>)</span>
                
                <span class="info-label">Statut Vol:</span>
                <span class="info-value">
                    <span class="status-badge status-<%= detail.getVolStatus() %>"><%= detail.getVolStatus() %></span>
                </span>
            </div>
        </div>

        <!-- Siège et Classe -->
        <div class="detail-section">
            <h2>Siège et Classe</h2>
            <div class="highlight-box">
                <div class="info-grid">
                    <span class="info-label">Numéro de Siège:</span>
                    <span class="seat-info"><%= detail.getNumeroSiege() %></span>
                    
                    <span class="info-label">Classe:</span>
                    <span class="seat-info"><%= detail.getClasse() %></span>
                </div>
            </div>

            <!-- Informations Passager -->
            <div class="detail-section">
                <h2>Informations Passager</h2>
                <div class="info-grid">
                    <span class="info-label">Nom Complet:</span>
                    <span class="info-value"><strong><%= detail.getNom() %> <%= detail.getPrenom() %></strong></span>
                    
                    <span class="info-label">Date de Naissance:</span>
                    <span class="info-value"><%= detail.getDateNaissance() %></span>
                    
                    <span class="info-label">Nationalité:</span>
                    <span class="info-value"><%= detail.getNationalite() %></span>
                    
                    <span class="info-label">N° Passeport:</span>
                    <span class="info-value"><strong><%= detail.getNumeroPassport() %></strong></span>
                    
                    <span class="info-label">Email:</span>
                    <span class="info-value"><%= detail.getEmail() %></span>
                    
                    <span class="info-label">Téléphone:</span>
                    <span class="info-value"><%= detail.getTelephone() %></span>
                </div>
            </div>

            <!-- Tarif -->
            <div class="detail-section">
                <h2>Tarif</h2>
                <div class="highlight-box">
                    <div class="info-grid">
                        <span class="info-label">Prix Total:</span>
                        <span class="price-info"><%= detail.getDeviseSynnbole() %> <%= detail.getPrixTotal() %></span>
                        
                        <span class="info-label">Devise:</span>
                        <span class="info-value"><%= detail.getDeviseCode() %></span>
                    </div>
                </div>
            </div>

                <% } else if (billet != null) { %>
                    <!-- Affichage simple si pas de détails complets -->
                    <div class="detail-section">
                        <table class="detail-table">
                            <tr>
                                <th>N° Billet</th>
                                <td><%= billet.getNumero_billet() %></td>
                            </tr>
                            <tr>
                                <th>Nom</th>
                                <td><%= billet.getNom() %></td>
                            </tr>
                            <tr>
                                <th>Prénom</th>
                                <td><%= billet.getPrenom() %></td>
                            </tr>
                            <tr>
                                <th>Date de Naissance</th>
                                <td><%= billet.getDate_naissance() %></td>
                            </tr>
                            <tr>
                                <th>Nationalité</th>
                                <td><%= billet.getNationalite() %></td>
                            </tr>
                            <tr>
                                <th>N° Passeport</th>
                                <td><%= billet.getNumero_passport() %></td>
                            </tr>
                            <tr>
                                <th>Email</th>
                                <td><%= billet.getEmail() %></td>
                            </tr>
                            <tr>
                                <th>Téléphone</th>
                                <td><%= billet.getTelephone() %></td>
                            </tr>
                            <tr>
                                <th>Statut</th>
                                <td><span class="badge badge-<%= billet.getStatus() %>"><%= billet.getStatus() %></span></td>
                            </tr>
                        </table>
                    </div>
                <% } %>

                <div class="button-group">
                    <button onclick="window.print()" class="btn">Imprimer</button>
                    <%= request.getAttribute("bouton") != null ? request.getAttribute("bouton") : "None" %>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer style="background: #2c3e50; color: #ecf0f1; padding: 15px; text-align: center; border-top: 1px solid #34495e;">
            <p>&copy; 2026 Compagnie Aérienne - Tous droits réservés</p>
        </footer>
    </div>
</body>
</html>
