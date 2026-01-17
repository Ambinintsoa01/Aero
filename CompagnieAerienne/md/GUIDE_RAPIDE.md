# 📋 Résumé du Projet - Compagnie Aérienne

## Vue d'ensemble Rapide

**Objectif** : Application complète de gestion d'une compagnie aérienne  
**Technologie** : Java 17 + JDBC + Servlets + JSP (aucun framework)  
**Base de Données** : PostgreSQL 14+  
**Architecture** : MVC (Model-View-Controller)  
**Déploiement** : Tomcat 9+

---

## 📦 Fichiers Clés à Comprendre

### 1. **Model** (Classes Métier)
| Fichier | Rôle |
|---------|------|
| `Avion.java` | Représente un avion avec capacité |
| `Aeroport.java` | Représente un aéroport |
| `Vol.java` | Trajet entre deux aéroports |
| `VolPlanifie.java` | Exécution d'un vol (date+avion) |
| `Billet.java` | Réservation/billet |
| `Passager.java` | Informations du voyageur |

### 2. **DAO** (Accès Données - JDBC)
| Fichier | Rôle |
|---------|------|
| `DatabaseConnection.java` | Gère les connexions PostgreSQL |
| `AvionDAO.java` | CRUD avions + `getPlacesDisponibles()` |
| `AeroportDAO.java` | CRUD aéroports |
| `VolDAO.java` | CRUD vols |
| `VolPlanifieDAO.java` | CRUD planifications |
| `BilletDAO.java` | CRUD billets + `countBilletsForVolPlanifie()` |

**Point Clé** : Les DAO contiennent la logique SQL et la vérification des règles métier (capacité, etc.)

### 3. **Servlet** (Contrôleurs)
| Servlet | URL | Rôle |
|---------|-----|------|
| `HomeServlet` | `/index` | Page d'accueil |
| `AvionServlet` | `/avions` | Gestion avions (CRUD) |
| `AeroportServlet` | `/aeroports` | Gestion aéroports |
| `VolServlet` | `/vols` | Gestion vols/trajets |
| `VolPlanifieServlet` | `/volsPlanifies` | Planification des vols |
| `ReservationServlet` | `/reservations` | **Gestion réservations avec vérification capacité** |

**Point Clé** : `ReservationServlet.createReservation()` implémente la règle métier cruciale

### 4. **JSP** (Interface Utilisateur)
```
jsp/
├── index.jsp                    # Accueil
├── avions/  (list, form, view)  # Pages avions
├── aeroports/                   # Pages aéroports
├── vols/                        # Pages vols
├── volsPlanifies/               # Pages planifications
└── reservations/                # Pages réservations
```

---

## 🧠 Règle Métier Clé - Vérification de Capacité

### ❌ Problème
Un avion a une capacité limitée (ex: 189 passagers).  
On ne peut pas vendre plus de billets que la capacité !

### ✅ Solution Implémentée

**Étape 1** : Compter les billets existants (`BilletDAO`)
```java
public int countBilletsForVolPlanifie(int idVolPlanifie) {
    SELECT COUNT(*) FROM billet 
    WHERE id_vol_fille = ? AND status IN ('EMIS', 'UTILISE')
}
```

**Étape 2** : Calculer les places libres (`AvionDAO`)
```java
public int getPlacesDisponibles(int idVolPlanifie) {
    capacite = SELECT a.capacite FROM avion
    billets = countBilletsForVolPlanifie(idVolPlanifie)
    return capacite - billets
}
```

**Étape 3** : Vérifier avant de créer un billet (`ReservationServlet`)
```java
int placesDisponibles = avionDAO.getPlacesDisponibles(idVolPlanifie);
if (placesDisponibles <= 0) {
    response.sendRedirect("...?error=Capacité maximale atteinte");
    return;
}
// Créer le billet
```

---

## 🎯 Flux Utilisateur Typique

### 1️⃣ Ajouter un Avion
```
/avions?action=new 
→ form.jsp (formulaire vide)
→ POST /avions (action=save)
→ AvionServlet.saveAvion()
→ AvionDAO.create()
→ INSERT INTO avion
→ Redirection /avions?message=créé
```

### 2️⃣ Créer un Trajet
```
/vols?action=new
→ form.jsp (sélectionner aéroports)
→ POST /vols (action=save)
→ VolServlet.saveVol()
→ VolDAO.create()
→ INSERT INTO vol_mere
→ Redirection /vols?message=créé
```

### 3️⃣ Planifier un Vol
```
/volsPlanifies?action=new
→ form.jsp (sélectionner vol + avion + date)
→ POST /volsPlanifies (action=save)
→ VolPlanifieServlet.saveVolPlanifie()
→ VolPlanifieDAO.create()
→ INSERT INTO vol_fille
→ Redirection /volsPlanifies
```

### 4️⃣ Réserver un Vol ⭐ (RÈGLE MÉTIER)
```
/reservations?action=new
→ form.jsp (sélectionner vol planifié)
→ POST /reservations (action=reserve)
→ ReservationServlet.createReservation()
  ├─ Récupérer idVolPlanifie
  ├─ AvionDAO.getPlacesDisponibles() [VÉRIFICATION]
  │  ├─ Récupérer capacité
  │  └─ Compter billets existants
  ├─ SI places > 0 :
  │  └─ BilletDAO.create()
  │     └─ INSERT INTO billet
  │     → Message succès
  ├─ SINON :
  │  → Message erreur "Capacité atteinte"
  └─ Redirection /reservations
```

---

## 🔗 Relations Base de Données

```
avion (1) ──── (n) vol_fille
                   │
                   ├── volume ← vol_mere ← aeroport
                   │
                   ├── (1) ──── (n) tarif
                   │                 │
                   │                 └── (1) ──── (n) billet
                   │
                   └── (1) ──── (n) vol_gestion
```

### Tables Principales
- **avion** : Flotte (ID, immatriculation, modèle, capacité)
- **aeroport** : Réseau (ID, code, nom, pays, ville)
- **vol_mere** : Trajets (ID, code, origine, destination)
- **vol_fille** : Planifications (ID, vol, avion, dates, statut)
- **tarif** : Prix (ID, vol_fille, classe, devise, prix)
- **billet** : Réservations (ID, tarif, passager, statut)

---

## 💻 Exemple de Code - Réserver

### 1. Servlet (Contrôleur)
```java
@WebServlet("/reservations")
public class ReservationServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        try {
            int idVolPlanifie = Integer.parseInt(request.getParameter("id_vol_planifie"));
            
            // 🔍 VÉRIFIER LA CAPACITÉ
            int placesDisponibles = avionDAO.getPlacesDisponibles(idVolPlanifie);
            if (placesDisponibles <= 0) {
                response.sendRedirect("...?error=Complet");
                return;
            }
            
            // ✅ CRÉER LE BILLET
            Billet billet = new Billet(...données du formulaire...);
            billetDAO.create(billet);
            
            response.sendRedirect("...?message=Réservation réussie");
        } catch (Exception e) {
            response.sendRedirect("...?error=" + e.getMessage());
        }
    }
}
```

### 2. DAO (Logique métier)
```java
public class AvionDAO {
    public int getPlacesDisponibles(int idVolPlanifie) {
        // Récupérer capacité de l'avion
        String sqlCapacite = "SELECT a.capacite FROM avion a " +
                            "INNER JOIN vol_fille vf ON a.id = vf.id_avion " +
                            "WHERE vf.id = ?";
        
        // Compter billets existants
        String sqlBillets = "SELECT COUNT(*) FROM billet b " +
                           "INNER JOIN tarif t ON b.id_tarif = t.id " +
                           "WHERE t.id_vol_fille = ? AND b.status IN ('EMIS', 'UTILISE')";
        
        // Retourner capacité - billets
        return capacite - nombreBillets;
    }
}
```

### 3. JSP (Vue)
```jsp
<form method="POST" action="/reservations">
    <input type="hidden" name="action" value="reserve">
    
    <select name="id_vol_planifie" required>
        <c:forEach items="${volsPlanifies}" var="vol">
            <option value="${vol.id}">
                ${vol.code_vol} - ${vol.immatriculation_avion} (${vol.date_reelle_depart})
            </option>
        </c:forEach>
    </select>
    
    <input type="text" name="nom" placeholder="Nom" required>
    <input type="text" name="prenom" placeholder="Prénom" required>
    <input type="date" name="date_naissance" required>
    <input type="email" name="email" required>
    
    <button type="submit">Réserver</button>
</form>
```

---

## 📊 Statuts et Énumérations

### Statut de Vol
- **PROGRAMME** : Programmé, pas encore en vol
- **EN_COURS** : Actuellement en vol
- **EN_VOL** : Vol en cours (synonyme)
- **TERMINE** : Vol arrivé à destination

### Statut de Billet
- **EMIS** : Réservation créée
- **UTILISE** : Passager embarqué
- **ANNULE** : Annulation
- **REMBOURSER** : Remboursement traité

### Type de Vol
- **1** : Vol National
- **2** : Vol International
- **3** : Vol Régional

---

## 🚀 Déploiement Rapide

### 1. Prérequis
```bash
java -version          # Java 17+
mvn -version           # Maven 3.8+
psql --version         # PostgreSQL 14+
```

### 2. Base de données
```bash
psql -U postgres
CREATE DATABASE compagnie_aerienne;
CREATE USER aero_user WITH PASSWORD 'aero_password';
GRANT ALL PRIVILEGES ON DATABASE compagnie_aerienne TO aero_user;
```

```bash
psql -U aero_user -d compagnie_aerienne < sql/script.sql
```

### 3. Configurer JDBC
Modifier `src/main/java/com/aero/util/DatabaseConnection.java` :
```java
private static final String URL = "jdbc:postgresql://localhost:5432/compagnie_aerienne";
private static final String USER = "aero_user";
private static final String PASSWORD = "aero_password";
```

### 4. Compiler et déployer
```bash
mvn clean package
cp target/compagnie-aerienne.war $TOMCAT_HOME/webapps/
$TOMCAT_HOME/bin/startup.sh
```

### 5. Accéder
```
http://localhost:8080/compagnie-aerienne
```

---

## 🎓 Concepts Clés Appris

### Programmation Java
- ✅ POO (encapsulation, héritage, polymorphisme)
- ✅ Collections (List, ArrayList)
- ✅ Gestion d'exceptions
- ✅ String manipulation
- ✅ LocalDate/LocalDateTime
- ✅ Getters/Setters

### Web
- ✅ Servlet (doGet, doPost)
- ✅ JSP (JSTL, expression language)
- ✅ Formulaires HTML
- ✅ Redirection/Forwarding
- ✅ Paramètres requête/réponse

### Base de Données
- ✅ JDBC (Connection, PreparedStatement, ResultSet)
- ✅ SQL (SELECT, INSERT, UPDATE, DELETE)
- ✅ Transactions
- ✅ Requêtes paramétrées (injection SQL prevention)

### Architecture
- ✅ Pattern MVC
- ✅ Pattern DAO
- ✅ Séparation responsabilités
- ✅ Validations métier
- ✅ Gestion erreurs

---

## 📈 Amélioration Future

| Fonctionnalité | Priorité | Complexité |
|---|---|---|
| Authentification utilisateur | Haute | Moyenne |
| Pagination listes | Moyenne | Basse |
| Export PDF billets | Moyenne | Moyenne |
| Dashboard administrateur | Basse | Haute |
| API REST | Basse | Moyenne |
| Tests unitaires JUnit | Haute | Basse |
| Cache (Redis) | Basse | Haute |
| Logging (Log4J) | Moyenne | Basse |

---

## 📞 Structure Support

```
Problème                    → Solution
────────────────────────────────────────────
DB n'existe pas            → Exécuter script.sql
Pas de connexion DB        → Vérifier credentials
Page 404                   → Vérifier contexte Tomcat
Erreur SQL                 → Voir logs Tomcat
Performance lente          → Ajouter indices BD
```

---

## 📚 Fichiers Documentation

| Fichier | Contenu |
|---------|---------|
| `README.md` | Vue d'ensemble complète |
| `ARCHITECTURE.md` | Diagrammes UML + schémas |
| `INSTALLATION.md` | Guide pas-à-pas installation |
| `GUIDE_RAPIDE.md` | **CE FICHIER** - Résumé exécutif |

---

**Version** : 1.0  
**Date** : Janvier 2026  
**Statut** : ✅ Production-ready (base)

---
