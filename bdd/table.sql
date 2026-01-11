-- Liste des aéroports mondiaux
CREATE TABLE Aeroports (
    code_iata VARCHAR(3) PRIMARY KEY, -- ex: 'CDG', 'JFK'
    nom VARCHAR(100) NOT NULL,
    ville VARCHAR(100) NOT NULL,
    pays VARCHAR(100) NOT NULL,
    fuseau_horaire VARCHAR(50) NOT NULL -- ex: 'Europe/Paris'
);

-- Flotte de la compagnie
CREATE TABLE Statut_Avion (
    statut_id SERIAL PRIMARY KEY,
    statut_nom VARCHAR(20) UNIQUE NOT NULL -- ex: 'Actif', 'Maintenance', 'AOG'
);

CREATE TABLE Avions (
    avion_id SERIAL PRIMARY KEY,
    immatriculation VARCHAR(10) UNIQUE NOT NULL, -- ex: 'F-GSPX'
    modele VARCHAR(50) NOT NULL, -- ex: 'Airbus A350-900'
    capacite_eco INT NOT NULL,
    capacite_business INT NOT NULL,
    date_dernier_entretien DATE,
    statut INT REFERENCES Statut_Avion(statut_id) -- CHECK (statut IN ('Actif', 'Maintenance', 'AOG'))
);

-- Le numéro de vol "parent" (ex: AF006)
CREATE TABLE Vols (
    vol_id SERIAL PRIMARY KEY,
    numero_vol VARCHAR(10) UNIQUE NOT NULL,
    description TEXT
);

-- Découpage du vol en étapes (direct ou avec escales)
CREATE TABLE Segments_Vol (
    segment_id SERIAL PRIMARY KEY,
    vol_id INT REFERENCES Vols(vol_id) ON DELETE CASCADE,
    aeroport_depart VARCHAR(3) REFERENCES Aeroports(code_iata),
    aeroport_arrivee VARCHAR(3) REFERENCES Aeroports(code_iata),
    ordre_segment INT NOT NULL, -- 1 pour le premier tronçon, 2 pour le suivant
    heure_depart_UTC TIME NOT NULL,
    heure_arrivee_UTC TIME NOT NULL,
    jour_de_semaine INT -- 1=Lundi, 7=Dimanche
);

CREATE TABLE Instances_Vols (
    instance_id SERIAL PRIMARY KEY,
    segment_id INT REFERENCES Segments_Vol(segment_id),
    avion_id INT REFERENCES Avions(avion_id),
    date_depart_reelle DATE NOT NULL,
    etat_vol INT DEFAULT 1, -- 1:'Planifié', 2:'En retard', 3:'Embarquement', 4:'Annulé', 'Atterri'
    prix_base DECIMAL(10,2) -- Prix fluctuant selon le Yield Management
);

CREATE TABLE Role_employe (
    role_id SERIAL PRIMARY KEY,
    role_nom VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE Employes (
    employe_id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    role INT REFERENCES Role_employe(role_id),
    specialisation VARCHAR(50), -- ex: 'Commandant de bord', 'Copilote', 'Chef de cabine'
    heures_vol_mois INT DEFAULT 0
);

-- Affectation spécifique à un segment d'un vol précis
CREATE TABLE Affectation_Equipage (
    instance_id INT REFERENCES Instances_Vols(instance_id),
    employe_id INT REFERENCES Employes(employe_id),
    PRIMARY KEY (instance_id, employe_id)
);

CREATE TABLE Passagers (
    passager_id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    num_passeport VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100)
);

-- Le dossier de réservation (PNR)
CREATE TABLE Reservations (
    reservation_id SERIAL PRIMARY KEY,
    pnr VARCHAR(6) UNIQUE NOT NULL, -- Code 6 caractères (ex: G7H2K9)
    passager_id INT REFERENCES Passagers(passager_id),
    date_reservation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    statut_paiement VARCHAR(20)
);

CREATE TABLE Paiements (
    paiement_id SERIAL PRIMARY KEY,
    reservation_id INT REFERENCES Reservations(reservation_id),
    montant DECIMAL(10,2) NOT NULL,
    date_paiement TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    methode_paiement VARCHAR(50) -- ex: 'Carte de crédit', 'PayPal'
);

-- Lien entre une réservation et les segments de vol choisis
CREATE TABLE Class_Reservation (
    class_id SERIAL PRIMARY KEY,
    class_name VARCHAR(20) -- 'Eco' ou 'Business'
);

CREATE TABLE Detail_Reservation (
    reservation_id INT REFERENCES Reservations(reservation_id),
    instance_id INT REFERENCES Instances_Vols(instance_id),
    classe INT REFERENCES Class_Reservation(class_id), 
    siege_assigne VARCHAR(5),
    PRIMARY KEY (reservation_id, instance_id)
);