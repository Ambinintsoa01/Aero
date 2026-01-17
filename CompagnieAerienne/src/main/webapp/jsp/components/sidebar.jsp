<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Sidebar Navigation -->
<aside class="sidebar">
    <div class="sidebar-header">
        <h2>✈️ Aero App</h2>
        <p>Gestion Aérienne</p>
    </div>

    <ul class="sidebar-menu">
        <!-- Avions Module -->
        <li class="menu-item">
            <a href="#" onclick="toggleMenu(event, 'avions')">
                <span class="menu-icon">✈️</span>
                <span>Avions</span>
            </a>
            <ul class="submenu" id="avions">
                <li><a href="${pageContext.request.contextPath}/avions?action=new">➕ Ajouter</a></li>
                <li><a href="${pageContext.request.contextPath}/avions?action=list">📋 Liste</a></li>
            </ul>
        </li>

        <!-- Aéroports Module -->
        <li class="menu-item">
            <a href="#" onclick="toggleMenu(event, 'aeroports')">
                <span class="menu-icon">🏢</span>
                <span>Aéroports</span>
            </a>
            <ul class="submenu" id="aeroports">
                <li><a href="${pageContext.request.contextPath}/aeroports?action=new">➕ Ajouter</a></li>
                <li><a href="${pageContext.request.contextPath}/aeroports?action=list">📋 Liste</a></li>
            </ul>
        </li>

        <!-- Vols (Mère) Module -->
        <li class="menu-item">
            <a href="#" onclick="toggleMenu(event, 'vols')">
                <span class="menu-icon">🛫</span>
                <span>Vols</span>
            </a>
            <ul class="submenu" id="vols">
                <li><a href="${pageContext.request.contextPath}/vols?action=new">➕ Ajouter</a></li>
                <li><a href="${pageContext.request.contextPath}/vols?action=list">📋 Liste</a></li>
            </ul>
        </li>

        <!-- Vols Planifiés Module -->
        <li class="menu-item">
            <a href="#" onclick="toggleMenu(event, 'volsPlanifies')">
                <span class="menu-icon">📅</span>
                <span>Vols Planifiés</span>
            </a>
            <ul class="submenu" id="volsPlanifies">
                <li><a href="${pageContext.request.contextPath}/volsPlanifies?action=new">➕ Ajouter</a></li>
                <li><a href="${pageContext.request.contextPath}/volsPlanifies?action=list">📋 Liste</a></li>
            </ul>
        </li>

        <!-- Réservations Module -->
        <li class="menu-item">
            <a href="#" onclick="toggleMenu(event, 'reservations')">
                <span class="menu-icon">🎫</span>
                <span>Réservations</span>
            </a>
            <ul class="submenu" id="reservations">
                <li><a href="${pageContext.request.contextPath}/reservations?action=new">➕ Ajouter</a></li>
                <li><a href="${pageContext.request.contextPath}/reservations?action=list">📋 Liste</a></li>
            </ul>
        </li>
    </ul>

    <div class="sidebar-footer">
        <p>&copy; 2026<br>Compagnie Aérienne</p>
    </div>
</aside>

<script>
    function toggleMenu(event, menuId) {
        event.preventDefault();
        const menuItem = event.currentTarget.parentElement;
        
        // Fermer les autres menus
        document.querySelectorAll('.menu-item').forEach(item => {
            if (item !== menuItem) {
                item.classList.remove('open');
            }
        });
        
        // Toggler le menu courant
        menuItem.classList.toggle('open');
    }

    // Marquer le menu actif basé sur l'URL
    document.addEventListener('DOMContentLoaded', function() {
        const currentUrl = window.location.href;
        
        // Déterminer quel menu doit être ouvert
        const modules = ['avions', 'aeroports', 'vols', 'volsPlanifies', 'reservations'];
        for (let module of modules) {
            if (currentUrl.includes('/' + module)) {
                const menuItem = document.getElementById(module).parentElement;
                menuItem.classList.add('open');
                
                // Marquer le lien actif dans le submenu
                const links = document.querySelectorAll('#' + module + ' a');
                links.forEach(link => {
                    if (link.href.includes(currentUrl.split('?')[0])) {
                        link.classList.add('active');
                    }
                });
                break;
            }
        }
    });
</script>
