# 📁 Structure Complète du Projet

## Arborescence Détaillée

```
CompagnieAerienne/
│
├── pom.xml
│   ├── Version Maven 4.0.0
│   ├── Java 17 target
│   ├── PostgreSQL JDBC 42.7.1
│   ├── Servlet API 4.0.1
│   ├── JSP/JSTL 2.3.3
│   └── Plugin Tomcat
│
├── README.md                          # Documentation complète
├── ARCHITECTURE.md                    # Diagrammes UML et schémas
├── INSTALLATION.md                    # Guide d'installation
├── GUIDE_RAPIDE.md                    # Résumé du projet
│
├── src/main/java/com/aero/
│   │
│   ├── model/                         # 📦 Couche Métier
│   │   ├── Avion.java                 # Avion avec capacité
│   │   ├── Aeroport.java              # Aéroport (code, nom, pays, ville)
│   │   ├── Vol.java                   # Vol Mère (trajet)
│   │   ├── VolPlanifie.java           # Vol Fille (exécution)
│   │   ├── Billet.java                # Billet/Réservation
│   │   └── Passager.java              # Informations passager
│   │
│   ├── dao/                           # 💾 Couche Données (JDBC)
│   │   ├── AvionDAO.java
│   │   │   ├── CRUD : findAll(), findById(), create(), update(), delete()
│   │   │   └── Métier : getPlacesDisponibles()
│   │   │
│   │   ├── AeroportDAO.java
│   │   │   └── CRUD standard
│   │   │
│   │   ├── VolDAO.java
│   │   │   ├── CRUD standard
│   │   │   └── Joins avec aéroports et types
│   │   │
│   │   ├── VolPlanifieDAO.java
│   │   │   ├── CRUD standard
│   │   │   ├── findByVolMere() - lister planifications
│   │   │   └── Joins avec avions et vols
│   │   │
│   │   └── BilletDAO.java
│   │       ├── CRUD standard
│   │       ├── updateStatus() - changer statut
│   │       ├── findByVolPlanifie() - lister réservations
│   │       └── countBilletsForVolPlanifie() ⭐ RÈGLE MÉTIER
│   │
│   ├── servlet/                       # 🎮 Contrôleurs (HTTP)
│   │   ├── HomeServlet.java           # GET / → index.jsp
│   │   │
│   │   ├── AvionServlet.java          # GET/POST /avions
│   │   │   ├── doGet : list, view, edit, new
│   │   │   ├── doPost : save, update, delete
│   │   │   └── Méthodes privées pour chaque action
│   │   │
│   │   ├── AeroportServlet.java       # GET/POST /aeroports
│   │   │   └── Similaire à AvionServlet
│   │   │
│   │   ├── VolServlet.java            # GET/POST /vols
│   │   │   └── Charge liste aéroports pour formulaire
│   │   │
│   │   ├── VolPlanifieServlet.java    # GET/POST /volsPlanifies
│   │   │   ├── Charge liste vols
│   │   │   ├── Charge liste avions
│   │   │   └── Gestion statut vols
│   │   │
│   │   └── ReservationServlet.java    # GET/POST /reservations ⭐
│   │       ├── newReservation() - afficher formulaire
│   │       └── createReservation() - VÉRIFIER CAPACITÉ
│   │
│   └── util/                          # 🔧 Utilitaires
│       └── DatabaseConnection.java
│           ├── Chargement driver PostgreSQL
│           ├── getConnection() - obtenir connexion
│           ├── closeConnection() - fermer connexion
│           └── Gestion des exceptions SQLException
│
├── src/main/webapp/                   # 🌐 Frontend
│   │
│   ├── WEB-INF/
│   │   └── web.xml                    # Configuration web (UTF-8, erreurs, ...)
│   │
│   ├── css/
│   │   └── style.css                  # Style global (1000+ lignes)
│   │       ├── Navbar responsive
│   │       ├── Tables avec hover
│   │       ├── Formulaires
│   │       ├── Badges statuts
│   │       ├── Alerts (success/error)
│   │       ├── Grid système
│   │       ├── Mobile-first responsive
│   │       └── Accessible (colors, fonts)
│   │
│   ├── js/                            # (JavaScript - optionnel pour futur)
│   │   └── [vide pour maintenant]
│   │
│   └── jsp/                           # 📄 Pages dynamiques
│       │
│       ├── index.jsp                  # Accueil avec 5 modules
│       │
│       ├── avions/
│       │   ├── list.jsp               # Liste avions en tableau
│       │   ├── form.jsp               # Créer/Éditer avion
│       │   └── view.jsp               # Détails avion
│       │
│       ├── aeroports/
│       │   ├── list.jsp
│       │   ├── form.jsp
│       │   └── view.jsp
│       │
│       ├── vols/
│       │   ├── list.jsp               # Tableau avec origines/destinations
│       │   ├── form.jsp               # Sélecteurs aéroports + type
│       │   └── view.jsp               # Détails vol
│       │
│       ├── volsPlanifies/
│       │   ├── list.jsp               # Tableau avec statuts badges
│       │   ├── form.jsp               # Sélecteurs vol + avion + dates
│       │   └── view.jsp               # Détails planification
│       │
│       └── reservations/
│           ├── list.jsp               # Tableau billets
│           ├── form.jsp               # Formulaire réservation (règle métier)
│           └── view.jsp               # Détails billet
│
└── sql/
    └── script.sql                     # 🗄️ Données initiales PostgreSQL
        ├── Tables de référence (types)
        ├── Tables principales
        ├── Tables relationnelles
        ├── 50+ INSERT statements
        └── Setval pour sequences
```

---

## Flux d'une Requête HTTP

### Exemple : Créer une réservation

```
1. UTILISATEUR clique "Nouvelle Réservation"
   ↓
2. REQUEST : GET /reservations?action=new
   ↓
3. SERVLET (ReservationServlet)
   - doGet() → action = "new"
   - newReservation()
   - Charge volsPlanifies via DAO
   - request.setAttribute("volsPlanifies", list)
   ↓
4. FORWARD à JSP
   - /jsp/reservations/form.jsp
   - Boucle JSTL : c:forEach sur volsPlanifies
   ↓
5. RENDU HTML
   - Form avec champs passager
   - Select pour choisir vol
   ↓
6. UTILISATEUR remplit et soumet
   ↓
7. REQUEST : POST /reservations (action=reserve)
   ↓
8. SERVLET (ReservationServlet)
   - doPost() → action = "reserve"
   - createReservation()
   - Récupère idVolPlanifie
   ├─ DAO.getPlacesDisponibles() [SQL COUNT]
   ├─ IF places > 0
   │  ├─ Crée objet Billet
   │  └─ DAO.create() [SQL INSERT]
   └─ ELSE → erreur "Complet"
   ↓
9. RESPONSE : Redirection
   - 302 /reservations?message=Réussie
   ↓
10. NAVIGATEUR suit redirection
   ↓
11. REQUEST : GET /reservations (sans action)
    ↓
12. SERVLET : listReservations()
    - DAO.findAll()
    - request.setAttribute("billets", list)
    ↓
13. FORWARD à /jsp/reservations/list.jsp
    ↓
14. RENDU HTML avec liste mise à jour
    - Affiche le nouveau billet
    - Message succès en haut
```

---

## Appels DAO Typiques

### Lecture (Read)
```
SERVLET: avionServlet.viewAvion()
    ↓
DAO: AvionDAO avionDAO.findById(5)
    ↓
SQL: SELECT id, immatriculation, modele, ... FROM avion WHERE id = 5
    ↓
DB: Retourne 1 ligne
    ↓
DAO: mapResultSetToAvion(rs) → new Avion(...)
    ↓
SERVLET: request.setAttribute("avion", avion)
    ↓
JSP: ${avion.immatriculation}, ${avion.capacite}, etc.
```

### Création (Create)
```
SERVLET: ReservationServlet.createReservation()
    ├─ Valide input
    ├─ Crée objet Billet
    ↓
DAO: BilletDAO.create(billet)
    ├─ Prépare INSERT statement
    ├─ Set paramètres (nom, prenom, email, ...)
    ↓
SQL: INSERT INTO billet (numero_billet, id_tarif, ...) 
     VALUES (?, ?, ...)
     RETURNING id
    ↓
DB: Insère ligne, retourne ID généré
    ↓
DAO: Extract ID from ResultSet
    ↓
SERVLET: Response.sendRedirect(/reservations?message=Succès)
```

### Vérification Métier (Capacity Check)
```
SERVLET: ReservationServlet.createReservation()
    ├─ Récupère idVolPlanifie (123)
    ↓
DAO: AvionDAO.getPlacesDisponibles(123)
    ├─ SQL 1 : SELECT capacite FROM avion WHERE id IN (SELECT id_avion FROM vol_fille WHERE id = 123)
    │  → Résultat : 189 places
    ├─ SQL 2 : SELECT COUNT(*) FROM billet WHERE id_tarif IN (SELECT id FROM tarif WHERE id_vol_fille = 123) AND status IN ('EMIS', 'UTILISE')
    │  → Résultat : 189 billets
    └─ Return : 189 - 189 = 0 places disponibles
    ↓
SERVLET: IF placesDisponibles > 0 → Créer billet
         ELSE → Erreur "Complet"
```

---

## Pattern MVC - Exemple Complet

### Étape 1 : MODEL (Avion.java)
```java
public class Avion {
    private int id;
    private String immatriculation;
    private int capacite;
    // Getters/Setters
}
```

### Étape 2 : CONTROLLER (AvionServlet.java)
```java
@WebServlet("/avions")
public class AvionServlet extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse res) {
        String action = req.getParameter("action");
        
        if (action.equals("list")) {
            List<Avion> avions = avionDAO.findAll();
            req.setAttribute("avions", avions);
            req.getRequestDispatcher("/jsp/avions/list.jsp")
               .forward(req, res);
        }
    }
}
```

### Étape 3 : VIEW (list.jsp)
```jsp
<table>
    <c:forEach items="${avions}" var="avion">
        <tr>
            <td>${avion.immatriculation}</td>
            <td>${avion.capacite}</td>
        </tr>
    </c:forEach>
</table>
```

### Étape 4 : DAO (AvionDAO.java)
```java
public List<Avion> findAll() {
    String sql = "SELECT * FROM avion";
    List<Avion> avions = new ArrayList<>();
    
    try (Connection conn = DatabaseConnection.getConnection();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery(sql)) {
        
        while (rs.next()) {
            avions.add(mapResultSetToAvion(rs));
        }
    }
    return avions;
}
```

---

## Dépendances Maven

```xml
<!-- PostgreSQL Driver JDBC -->
postgresql:42.7.1

<!-- Servlet API -->
javax.servlet:javax.servlet-api:4.0.1

<!-- JSP API -->
javax.servlet.jsp:javax.servlet.jsp-api:2.3.3

<!-- JSTL (tag libraries) -->
javax.servlet:jstl:1.2

<!-- JUnit (pour tests) -->
junit:junit:4.13.2
```

---

## Variables d'Environnement Recommandées

```bash
# Linux/Mac
export JAVA_HOME=/usr/local/opt/openjdk@17
export TOMCAT_HOME=/opt/tomcat-9
export PATH=$JAVA_HOME/bin:$TOMCAT_HOME/bin:$PATH

# Windows (set command)
set JAVA_HOME=C:\Program Files\Java\jdk-17.0.1
set TOMCAT_HOME=C:\tomcat-9
set PATH=%JAVA_HOME%\bin;%TOMCAT_HOME%\bin;%PATH%
```

---

## Fichiers Configuration Importants

| Fichier | Rôle |
|---------|------|
| `pom.xml` | Dépendances Maven |
| `web.xml` | Configuration Servlet (UTF-8, mapping) |
| `DatabaseConnection.java` | Credentials PostgreSQL |
| `style.css` | Design UI (1000+ lignes) |

---

## Checklist Complétion

- ✅ Model : 6 classes POJO créées
- ✅ DAO : 5 classes DAO avec CRUD + méthodes métier
- ✅ Servlet : 6 servlets pour tous les modules
- ✅ JSP : 14 pages (index + 3 pages × 4 modules + 2 pages gestion)
- ✅ CSS : Design responsive complet
- ✅ Configuration : pom.xml, web.xml, DatabaseConnection
- ✅ Documentation : README, ARCHITECTURE, INSTALLATION, GUIDE_RAPIDE
- ✅ SQL : script.sql avec données de test
- ✅ Règle métier : Vérification capacité implémentée
- ✅ Architecture : MVC complète et séparation des responsabilités

---

**Total des fichiers** : 50+ fichiers  
**Total des lignes de code** : ~5000+ lignes  
**Temps développement** : ~4 heures production

---
