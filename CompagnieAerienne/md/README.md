# Compagnie Aérienne - Application de Gestion

## 📋 Vue d'ensemble

Application complète de gestion d'une compagnie aérienne développée en **Java 17 pur** avec :
- **JDBC** pour l'accès à la base de données PostgreSQL
- **Servlets** pour la logique métier
- **JSP** pour l'interface utilisateur
- Architecture **MVC** rigoureuse

Aucun framework n'est utilisé (pas de Spring, Hibernate, etc.), ce qui permet une compréhension complète des concepts fondamentaux.

---

## 🎯 Objectifs Métier

### Fonctionnalités principales

1. **Gestion des Avions**
   - Ajouter, modifier, supprimer des avions
   - Gérer la capacité maximale

2. **Gestion des Aéroports**
   - Définir les aéroports de départ et d'arrivée
   - Gérer les informations aéroport

3. **Gestion des Vols (Trajets)**
   - Créer des vols entre deux aéroports
   - Classer les vols (national, international, régional)

4. **Planification des Vols**
   - Assigner un avion à un vol
   - Définir la date/heure de départ et d'arrivée
   - Plusieurs planifications possibles pour un même vol

5. **Réservations**
   - Effectuer des réservations de sièges
   - **Vérifier la capacité disponible** (règle métier clé)
   - Gérer les statuts de billets

---

## 📁 Structure du Projet

```
CompagnieAerienne/
├── pom.xml                              # Configuration Maven
├── src/
│   ├── main/
│   │   ├── java/com/aero/
│   │   │   ├── model/                  # Classes métier
│   │   │   │   ├── Avion.java
│   │   │   │   ├── Aeroport.java
│   │   │   │   ├── Vol.java            # Vol Mère
│   │   │   │   ├── VolPlanifie.java    # Vol Fille
│   │   │   │   ├── Billet.java
│   │   │   │   └── Passager.java
│   │   │   ├── dao/                    # Data Access Objects
│   │   │   │   ├── AvionDAO.java
│   │   │   │   ├── AeroportDAO.java
│   │   │   │   ├── VolDAO.java
│   │   │   │   ├── VolPlanifieDAO.java
│   │   │   │   └── BilletDAO.java
│   │   │   ├── servlet/                # Contrôleurs
│   │   │   │   ├── HomeServlet.java
│   │   │   │   ├── AvionServlet.java
│   │   │   │   ├── AeroportServlet.java
│   │   │   │   ├── VolServlet.java
│   │   │   │   ├── VolPlanifieServlet.java
│   │   │   │   └── ReservationServlet.java
│   │   │   └── util/
│   │   │       └── DatabaseConnection.java
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   └── web.xml
│   │       ├── css/
│   │       │   └── style.css
│   │       └── jsp/
│   │           ├── index.jsp
│   │           ├── avions/
│   │           │   ├── list.jsp
│   │           │   ├── form.jsp
│   │           │   └── view.jsp
│   │           ├── aeroports/
│   │           ├── vols/
│   │           ├── volsPlanifies/
│   │           └── reservations/
│   └── test/                           # Tests unitaires
└── README.md
```

---

## 🏗️ Architecture MVC

### Model (com.aero.model)
Classes POJO représentant les entités métier :
- **Avion** : Immatriculation, modèle, capacité
- **Aeroport** : Code, nom, pays, ville
- **Vol** : Code vol, aéroports origine/destination, type
- **VolPlanifie** : Exécution spécifique d'un vol
- **Billet** : Réservation avec détails passager
- **Passager** : Informations du voyageur

### View (JSP)
Pages dynamiques générées par les Servlets :
- Listes de données avec tableaux
- Formulaires de création/modification
- Pages de détails
- Gestion des messages d'erreur/succès

### Controller (Servlets)
Logique de contrôle HTTP :
- `HomeServlet` : Page d'accueil
- `AvionServlet` : CRUD avions
- `AeroportServlet` : CRUD aéroports
- `VolServlet` : CRUD vols
- `VolPlanifieServlet` : Planification des vols
- `ReservationServlet` : Gestion réservations

---

## 🔌 Couche DAO (Data Access Object)

### Pattern DAO
Séparation entre la logique métier et l'accès aux données :

```java
// Exemple : AvionDAO
public class AvionDAO {
    public List<Avion> findAll() { ... }
    public Avion findById(int id) { ... }
    public Avion create(Avion avion) { ... }
    public boolean update(Avion avion) { ... }
    public boolean delete(int id) { ... }
    public int getPlacesDisponibles(int idVolPlanifie) { ... }
}
```

### Utilisation de JDBC
- Connexions gérées via `DatabaseConnection`
- `PreparedStatement` pour les requêtes paramétrées
- Mapping ResultSet → Objets métier
- Gestion des exceptions SQL

---

## 💾 Base de Données PostgreSQL

### Diagramme Entité-Relation

```
┌─────────────────┐
│     avion       │
├─────────────────┤
│ id (PK)         │
│ immatriculation │
│ modele          │
│ capacite ◄──┐   │
└─────────────│───┘
              │
         ┌────┴────┐
         │          │
    ┌────▼──────┐   │
    │ vol_fille │   │
    └────┬──────┘   │
         │          │
    ┌────▼──────┐   │
    │ vol_mere  │   │
    └────┬──────┘   │
         │ └────────┘
    ┌────┴──────┐
    │ aeroport  │
    └───────────┘
         ▲
    ┌────┴──────┐
    │   tarif   │
    │           │
    └────┬──────┘
         │
    ┌────▼──────┐
    │   billet  │ ◄─── Réservation
    └───────────┘
```

### Tables Principales
- **avion** : Aéronefs disponibles
- **aeroport** : Aéroports du réseau
- **vol_mere** : Trajets (routes)
- **vol_fille** : Planifications
- **tarif** : Tarification par classe/devise
- **billet** : Réservations clients
- **droit_bagage** : Allocation bagages
- **bagage** : Bagages enregistrés

---

## 🎮 Utilisation de l'Application

### 1. Installation

#### Prérequis
- Java 17+
- Maven 3.8+
- PostgreSQL 14+
- Tomcat 9+

#### Étapes
```bash
# 1. Cloner le projet
cd CompagnieAerienne

# 2. Configurer la base de données
# Modifier DatabaseConnection.java avec vos credentials
# Exécuter script.sql sur PostgreSQL

# 3. Compiler et builder
mvn clean package

# 4. Déployer sur Tomcat
# Copier compagnie-aerienne.war dans TOMCAT_HOME/webapps

# 5. Accéder l'application
# http://localhost:8080/compagnie-aerienne
```

### 2. Configuration JDBC

Fichier : `src/main/java/com/aero/util/DatabaseConnection.java`

```java
private static final String URL = "jdbc:postgresql://localhost:5432/compagnie_aerienne";
private static final String USER = "postgres";
private static final String PASSWORD = "password";
```

### 3. Flux Utilisateur

**Accueil** → Choix du module
```
Avions → CRUD avions
Aéroports → CRUD aéroports
Vols → Créer trajets
Vols Planifiés → Assigner avion + date/heure
Réservations → Booker sièges (vérification capacité)
```

---

## 🧠 Règles Métier Implémentées

### 1. Vérification de la Capacité
**Règle** : Le nombre de réservations ne doit jamais dépasser la capacité de l'avion

**Implémentation** dans `BilletDAO.java` :
```java
public int countBilletsForVolPlanifie(int idVolPlanifie) {
    // Compte les billets EMIS et UTILISE
}
```

**Utilisation** dans `ReservationServlet.java` :
```java
int placesDisponibles = avionDAO.getPlacesDisponibles(idVolPlanifie);
if (placesDisponibles <= 0) {
    // Rejeter la réservation
}
```

### 2. Association Vol-Avion-Planification
**Règle** : Un vol peut être effectué par plusieurs avions à différentes dates

**Modèle** :
- `vol_mere` : Le trajet (Paris → Lyon)
- `vol_fille` : L'exécution (avec Avion A320, 15/01/2026 08:00)

### 3. Statuts de Billets
- **EMIS** : Réservation effectuée
- **UTILISE** : Passager embarqué
- **ANNULE** : Annulation
- **REMBOURSER** : Remboursement effectué

---

## 📊 Diagramme de Classes UML

```
┌──────────────────────────────────────────┐
│              «entity»                    │
│              Avion                       │
├──────────────────────────────────────────┤
│ - id: int                                │
│ - immatriculation: String                │
│ - modele: String                         │
│ - constructeur: String                   │
│ - capacite: int                          │
│ - annee_fabrication: int                 │
│ - date_mise_service: LocalDate           │
├──────────────────────────────────────────┤
│ + getId(): int                           │
│ + getCapacite(): int                     │
│ + setCapacite(int): void                 │
└──────────────────────────────────────────┘
           ▲
           │ uses
           │
        ┌──┴────────────────────────┐
        │                           │
┌───────┴──────────────────┐   ┌────┴────────────────────┐
│   «dao»                  │   │  «servlet»              │
│   AvionDAO               │   │  AvionServlet           │
├──────────────────────────┤   ├────────────────────────┤
│ + findAll(): List        │   │ + doGet(): void        │
│ + findById(int): Avion   │   │ + doPost(): void       │
│ + create(Avion): Avion   │   │ - listAvions(): void   │
│ + update(Avion): boolean │   │ - saveAvion(): void    │
│ + delete(int): boolean   │   │ - deleteAvion(): void  │
│ + getPlacesDisponibles() │   └────────────────────────┘
└──────────────────────────┘
```

Similarité pour : Aeroport, Vol, VolPlanifie, Billet

---

## 🔐 Sécurité

### Validations Implémentées
- **Côté serveur** : Toutes les entrées validées dans les Servlets
- **Requêtes SQL** : `PreparedStatement` pour prévenir les injections SQL
- **Transactions** : Cohérence des données garantie
- **Capacité** : Vérification stricte avant création de billet

### À améliorer (Production)
- Authentification/Autorisation
- Chiffrement des mots de passe
- HTTPS
- CSRF tokens dans les formulaires
- Logging sécurisé

---

## 🧪 Exemples de Code

### 1. DAO - Créer un avion
```java
public Avion create(Avion avion) {
    String sql = "INSERT INTO avion (...) VALUES (...) RETURNING id";
    try (Connection conn = DatabaseConnection.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        pstmt.setString(1, avion.getImmatriculation());
        // ... autres paramètres
        
        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                avion.setId(rs.getInt(1));
            }
        }
    } catch (SQLException e) {
        System.err.println("Erreur: " + e.getMessage());
    }
    return avion;
}
```

### 2. Servlet - Créer une réservation
```java
private void createReservation(HttpServletRequest request, 
                              HttpServletResponse response) throws IOException {
    int idVolPlanifie = Integer.parseInt(request.getParameter("id_vol_planifie"));
    
    // Vérifier la capacité
    int placesDisponibles = avionDAO.getPlacesDisponibles(idVolPlanifie);
    if (placesDisponibles <= 0) {
        response.sendRedirect("...?error=Capacité atteinte");
        return;
    }
    
    // Créer le billet
    Billet billet = new Billet(...);
    billetDAO.create(billet);
    
    response.sendRedirect("...?message=Réservation réussie");
}
```

### 3. JSP - Lister les avions
```jsp
<table class="table">
    <thead>
        <tr>
            <th>Immatriculation</th>
            <th>Modèle</th>
            <th>Capacité</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${avions}" var="avion">
            <tr>
                <td>${avion.immatriculation}</td>
                <td>${avion.modele}</td>
                <td>${avion.capacite}</td>
                <td>
                    <a href="/avions?action=view&id=${avion.id}">Voir</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
```

---

## 📈 Améliorations Futures

1. **Authentification** : Ajouter système de login
2. **Rapports** : Génération PDF des billets
3. **Notifications** : Email confirmation réservation
4. **Paiement** : Intégration passerelle paiement
5. **API REST** : Ajouter endpoints REST
6. **Caching** : Implémenter cache pour performances
7. **Logs** : Meilleure gestion des logs
8. **Tests** : Tests unitaires et d'intégration
9. **Documentation** : JavaDoc complète
10. **Monitoring** : Dashboard administrateur

---

## 📞 Support

- Documentation : Voir les commentaires dans le code
- Base de données : Voir [script.sql](../sql/script.sql)
- Configuration : Voir [pom.xml](pom.xml)

---

## 📝 Licence

Projet éducatif - Compagnie Aérienne 2026

---

## 👨‍💻 Auteur

Développé comme démonstration d'une architecture MVC pure en Java sans frameworks.

---
