# Spécifications Fonctionnelles - Application de Gestion de Compagnie Aérienne

Ce document détaille l'ensemble des fonctionnalités et la structure des classes pour l'application développée en **Java 17**, **PostgreSQL 15** (Docker) et **Tomcat**. L'architecture repose sur la Programmation Orientée Objet (POO) pure avec un moteur **GenericDAO** utilisant l'introspection.

---

## 1. Classes de Paramétrage (Référentiels)

Ces classes gèrent les données statiques nécessaires au fonctionnement du système.

### Classe : `Aeroport`
* `save(Aeroport a, String table)` : Enregistrer un nouvel aéroport (Code IATA, Nom, Ville, Pays, Fuseau Horaire).
* `findAll(Class c, String table)` : Lister tous les aéroports pour alimenter les listes déroulantes.
* `delete(String iata, String table)` : Supprimer un aéroport par son code IATA.

### Classe : `RoleEmploye`
* `save(RoleEmploye r, String table)` : Ajouter un nouveau rôle au référentiel (ex: Pilote, PNC, Personnel au sol).
* `findAll(Class c, String table)` : Lister les rôles existants.

### Classe : `StatutAvion`
* `save(StatutAvion s, String table)` : Ajouter un état de disponibilité (ex: 'Actif', 'Maintenance', 'AOG').

---

## 2. Gestion de la Flotte et du Personnel

Logique liée aux ressources physiques et humaines de la compagnie.

### Classe : `Avion`
* `save(Avion a, String table)` : Ajouter un appareil à la flotte.
* `update(Avion a, String table, String idColumn)` : Mettre à jour les caractéristiques ou le statut d'un avion.
* **Complex :** `getMoyenneRemplissage(int avionId)` : Calcule le ratio passagers/capacité totale sur l'historique des vols de l'année.
* **Complex :** `estDisponiblePourDate(int avionId, LocalDate date)` : Vérifie si l'appareil n'est pas déjà booké sur une instance de vol ou bloqué en maintenance.

### Classe : `Employe`
* `save(Employe e, String table)` : Enregistrer un nouveau membre du personnel.
* `getPlanning(int employeId)` : Récupère la liste chronologique des vols assignés à cet employé.
* **Complex :** `calculerHeuresVolMensuelles(int employeId, int mois)` : Calcule la somme des durées de vol (en heures) pour un mois donné afin de respecter les quotas de sécurité.
* **Complex :** `estEligiblePourVol(int employeId, int instanceId)` : Vérifie si l'employé possède le bon rôle et les certifications pour une instance de vol spécifique.

---

## 3. Réseau et Programmation des Vols

Gestion de l'offre de transport, du trajet théorique à l'exécution réelle.

### Classe : `Vol` (Trajet théorique)
* `save(Vol v, String table)` : Créer un numéro de vol permanent (ex: "AF006").
* `getItineraireComplet(int volId)` : Retourne la liste des segments ordonnés constituant le voyage (incluant les escales).

### Classe : `SegmentVol` (Tronçons d'escale)
* `save(SegmentVol s, String table)` : Définit un trajet point-à-point (ex: CDG -> JFK).
* `calculerDureeEstimee(int segmentId)` : Retourne la durée de vol par différence entre `heure_arrivee_UTC` et `heure_depart_UTC`.

### Classe : `InstanceVol` (Vols programmés)
* **Complex :** `genererCalendrier(int volId, LocalDate debut, LocalDate fin)` : Génère automatiquement des entrées en base pour chaque jour de vol défini sur une période donnée.
* `assignerAvion(int instanceId, int avionId)` : Affecte un appareil spécifique à une date de vol.
* `getPassagersABord(int instanceId)` : Retourne la liste des passagers enregistrés sur ce segment précis.

---

## 4. Réservations et Commercial

Gestion de la vente, des passagers et des revenus.

### Classe : `Passager`
* `save(Passager p, String table)` : Créer ou mettre à jour un profil passager (identité, passeport).
* `getHistoriqueVoyages(int passagerId)` : Liste tous les vols (passés et futurs) liés à ce passager.

### Classe : `Reservation`
* **Very Complex :** `creerReservation(int passagerId, List<Integer> instanceIds)` : 
    1. Génère un PNR (code 6 caractères).
    2. Vérifie la disponibilité des sièges sur chaque instance.
    3. Crée les entrées dans `Detail_Reservation`.
* `annulerReservation(int reservationId)` : Annule le dossier et libère l'inventaire des sièges.
* `genererBilletPDF(int reservationId)` : Prépare l'objet de données nécessaire à l'impression du titre de transport.

### Classe : `Paiement`
* `effectuerPaiement(int resId, double montant, String methode)` : Enregistre la transaction et bascule le statut de la réservation en "Confirmé".

---

## 5. Fonctions Généralisées (GenericDAO)

Moteur technique central utilisant la réflexion Java pour automatiser le lien avec PostgreSQL.

* `save(Object obj, String tableName)` : Analyse l'objet pour générer un `INSERT INTO` dynamique.
* `update(Object obj, String tableName, String idColumnName)` : Génère un `UPDATE` pour l'ensemble des champs basés sur l'ID fourni.
* `delete(int id, String tableName, String idColumnName)` : Supprime une ligne selon sa clé primaire.
* `findAll(Class clazz, String tableName)` : Reconstruit une liste d'objets à partir de toutes les lignes d'une table.
* `findById(int id, Class clazz, String tableName, String idColumnName)` : Retourne une instance unique mappée depuis la base.

---

## Synthèse de la Logique Métier Critique

1. **Détection de Conflit (Safety) :** Algorithme vérifiant que deux vols assignés à un même employé ou avion ne se chevauchent pas, en incluant un temps de repos/turnaround minimum.
2. **Yield Management (Revenue) :** Fonction automatisée ajustant le `prix_base` de l'instance de vol selon le principe de l'offre et de la demande (remplissage vs date de départ).