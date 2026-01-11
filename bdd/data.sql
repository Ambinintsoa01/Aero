-- Données de test pour la compagnie aérienne

-- Insertion des aéroports
INSERT INTO Aeroports (code_iata, nom, ville, pays, fuseau_horaire) VALUES
('CDG', 'Aéroport Charles de Gaulle', 'Paris', 'France', 'Europe/Paris'),
('ORY', 'Aéroport d''Orly', 'Paris', 'France', 'Europe/Paris'),
('LHR', 'Aéroport de Heathrow', 'Londres', 'Royaume-Uni', 'Europe/London'),
('JFK', 'Aéroport international John F. Kennedy', 'New York', 'États-Unis', 'America/New_York'),
('LAX', 'Aéroport international de Los Angeles', 'Los Angeles', 'États-Unis', 'America/Los_Angeles'),
('DXB', 'Aéroport international de Dubaï', 'Dubaï', 'Émirats arabes unis', 'Asia/Dubai'),
('SIN', 'Aéroport de Changi', 'Singapour', 'Singapour', 'Asia/Singapore'),
('HND', 'Aéroport international de Haneda', 'Tokyo', 'Japon', 'Asia/Tokyo'),
('FRA', 'Aéroport de Francfort', 'Francfort', 'Allemagne', 'Europe/Berlin'),
('BCN', 'Aéroport de Barcelone-El Prat', 'Barcelone', 'Espagne', 'Europe/Madrid');

-- Insertion des statuts d'avion
INSERT INTO Statut_Avion (statut_nom) VALUES
('Actif'),
('Maintenance'),
('AOG');

-- Insertion des avions
INSERT INTO Avions (immatriculation, modele, capacite_eco, capacite_business, date_dernier_entretien, statut) VALUES
('F-HPJA', 'Airbus A320', 150, 30, '2025-12-15', 1),
('F-HPJB', 'Airbus A320', 150, 30, '2025-11-20', 1),
('F-GTAH', 'Airbus A380', 399, 117, '2025-10-10', 1),
('F-GZNC', 'Boeing 777-300ER', 316, 80, '2025-12-01', 1),
('F-GZNF', 'Boeing 777-300ER', 316, 80, '2025-09-25', 1),
('F-HREV', 'Boeing 787-9', 216, 60, '2026-01-05', 1),
('F-HRBA', 'Airbus A350-900', 253, 71, '2025-11-30', 1),
('F-GSPZ', 'Airbus A330-200', 214, 63, '2025-08-15', 1),
('F-GKXY', 'Boeing 737-800', 162, 27, '2025-07-20', 2),
('F-GLZN', 'Embraer E195', 100, 20, '2025-12-28', 1);

-- Insertion des rôles d'employés
INSERT INTO Role_employe (role_nom) VALUES
('Pilote'),
('Copilote'),
('Chef de cabine'),
('Hôtesse de l''air'),
('Steward'),
('Technicien'),
('Ingénieur');

-- Insertion des employés
INSERT INTO Employes (nom, prenom, role, specialisation, heures_vol_mois) VALUES
('Dubois', 'Marie', 1, 'Commandant de bord A350', 85),
('Martin', 'Pierre', 1, 'Commandant de bord B777', 82),
('Bernard', 'Sophie', 2, 'Copilote A320', 75),
('Petit', 'Jean', 2, 'Copilote B787', 70),
('Lefebvre', 'Claire', 3, 'Chef de cabine Principal', 90),
('Moreau', 'Thomas', 4, 'Hôtesse de l''air', 80),
('Laurent', 'Julie', 5, 'Steward', 78),
('Simon', 'Lucas', 6, 'Technicien moteur', 0),
('Michel', 'Emma', 4, 'Hôtesse de l''air', 85),
('Leroy', 'Alexandre', 7, 'Ingénieur aéronautique', 0);

-- Insertion des vols (numéros de vol)
INSERT INTO Vols (numero_vol, description) VALUES
('AF1234', 'Paris CDG - New York JFK'),
('AF5678', 'New York JFK - Paris CDG'),
('AF2468', 'Paris CDG - Dubaï DXB'),
('AF3579', 'Paris ORY - Barcelone BCN'),
('AF7890', 'Londres LHR - Singapour SIN'),
('AF1111', 'Paris CDG - Los Angeles LAX'),
('AF2222', 'Francfort FRA - Tokyo HND'),
('AF3333', 'Barcelone BCN - Paris ORY'),
('AF4444', 'Dubaï DXB - Singapour SIN'),
('AF5555', 'Los Angeles LAX - Paris CDG'),
('AF9876', 'Paris CDG - Londres LHR'),
('AF8765', 'Londres LHR - Paris CDG'),
('AF7654', 'Paris ORY - Francfort FRA'),
('AF6543', 'New York JFK - Los Angeles LAX'),
('AF5432', 'Singapour SIN - Dubaï DXB');

-- Insertion des segments de vol (vols directs)
INSERT INTO Segments_Vol (vol_id, aeroport_depart, aeroport_arrivee, ordre_segment, heure_depart_UTC, heure_arrivee_UTC, jour_de_semaine) VALUES
-- AF1234 CDG-JFK (mercredi)
(1, 'CDG', 'JFK', 1, '09:30:00', '12:45:00', 3),
-- AF5678 JFK-CDG (mercredi)
(2, 'JFK', 'CDG', 1, '23:00:00', '12:15:00', 3),
-- AF2468 CDG-DXB (mercredi)
(3, 'CDG', 'DXB', 1, '21:30:00', '06:20:00', 3),
-- AF3579 ORY-BCN (mercredi)
(4, 'ORY', 'BCN', 1, '07:15:00', '09:30:00', 3),
-- AF7890 LHR-SIN (mercredi)
(5, 'LHR', 'SIN', 1, '11:45:00', '05:30:00', 3),
-- AF1111 CDG-LAX (vendredi)
(6, 'CDG', 'LAX', 1, '13:00:00', '16:30:00', 5),
-- AF2222 FRA-HND (dimanche)
(7, 'FRA', 'HND', 1, '08:30:00', '04:45:00', 7),
-- AF3333 BCN-ORY (mercredi)
(8, 'BCN', 'ORY', 1, '15:20:00', '17:15:00', 3),
-- AF4444 DXB-SIN (samedi)
(9, 'DXB', 'SIN', 1, '02:15:00', '14:40:00', 6),
-- AF5555 LAX-CDG (lundi)
(10, 'LAX', 'CDG', 1, '13:00:00', '08:15:00', 1),
-- AF9876 CDG-LHR (dimanche)
(11, 'CDG', 'LHR', 1, '06:00:00', '06:30:00', 7),
-- AF8765 LHR-CDG (dimanche)
(12, 'LHR', 'CDG', 1, '19:45:00', '22:15:00', 7),
-- AF7654 ORY-FRA (lundi)
(13, 'ORY', 'FRA', 1, '11:30:00', '13:00:00', 1),
-- AF6543 JFK-LAX (mardi)
(14, 'JFK', 'LAX', 1, '13:00:00', '16:30:00', 2),
-- AF5432 SIN-DXB (jeudi)
(15, 'SIN', 'DXB', 1, '19:50:00', '00:25:00', 4);

-- Insertion des instances de vols
INSERT INTO Instances_Vols (segment_id, avion_id, date_depart_reelle, etat_vol, prix_base) VALUES
-- Vols du 8 janvier 2026
(1, 4, '2026-01-08', 1, 850.00),  -- AF1234 CDG-JFK (Planifié)
(2, 4, '2026-01-08', 1, 920.00),  -- AF5678 JFK-CDG (Planifié)
(3, 3, '2026-01-08', 1, 1250.00), -- AF2468 CDG-DXB (Planifié)
(4, 9, '2026-01-08', 3, 180.00),  -- AF3579 ORY-BCN (Embarquement)
(5, 7, '2026-01-08', 1, 1580.00), -- AF7890 LHR-SIN (Planifié)

-- Vols futurs
(6, 5, '2026-01-10', 1, 1100.00), -- AF1111 CDG-LAX
(7, 6, '2026-01-12', 1, 1850.00), -- AF2222 FRA-HND
(8, 1, '2026-01-15', 1, 165.00),  -- AF3333 BCN-ORY
(9, 8, '2026-01-18', 1, 890.00),  -- AF4444 DXB-SIN
(10, 5, '2026-01-20', 1, 1050.00), -- AF5555 LAX-CDG

-- Vols passés
(11, 2, '2026-01-05', 5, 250.00), -- AF9876 CDG-LHR (Atterri)
(12, 2, '2026-01-05', 5, 280.00), -- AF8765 LHR-CDG (Atterri)
(13, 10, '2026-01-06', 5, 220.00), -- AF7654 ORY-FRA (Atterri)
(14, 5, '2026-01-07', 5, 450.00), -- AF6543 JFK-LAX (Atterri)
(15, 8, '2026-01-03', 4, 780.00); -- AF5432 SIN-DXB (Annulé)

-- Affectation d'équipage aux instances de vols
INSERT INTO Affectation_Equipage (instance_id, employe_id) VALUES
-- Vol 1 (AF1234 CDG-JFK)
(1, 2), (1, 3), (1, 5), (1, 6),
-- Vol 2 (AF5678 JFK-CDG)
(2, 1), (2, 4), (2, 5), (2, 7),
-- Vol 3 (AF2468 CDG-DXB)
(3, 1), (3, 3), (3, 6), (3, 9),
-- Vol 4 (AF3579 ORY-BCN)
(4, 2), (4, 4), (4, 7), (4, 9),
-- Vol 5 (AF7890 LHR-SIN)
(5, 1), (5, 3), (5, 5), (5, 6);

-- Insertion des passagers
INSERT INTO Passagers (nom, prenom, num_passeport, email) VALUES
('Dupont', 'François', 'FR1234567', 'francois.dupont@email.com'),
('Lambert', 'Isabelle', 'FR2345678', 'i.lambert@email.com'),
('Rousseau', 'Marc', 'FR3456789', 'marc.r@email.com'),
('Smith', 'John', 'US1234567', 'john.smith@email.com'),
('Johnson', 'Emily', 'US2345678', 'emily.j@email.com'),
('Ahmed', 'Fatima', 'AE1234567', 'f.ahmed@email.com'),
('Khalil', 'Omar', 'AE2345678', 'omar.k@email.com'),
('Hassan', 'Aisha', 'AE3456789', 'aisha.h@email.com'),
('Garcia', 'Carlos', 'ES1234567', 'carlos.garcia@email.com'),
('Lopez', 'Maria', 'ES2345678', 'maria.lopez@email.com'),
('Wong', 'Li', 'SG1234567', 'li.wong@email.com'),
('Tan', 'Wei', 'SG2345678', 'wei.tan@email.com'),
('Brown', 'Robert', 'US3456789', 'robert.brown@email.com'),
('Mercier', 'Anne', 'FR4567890', 'anne.mercier@email.com'),
('Blanc', 'Philippe', 'FR5678901', 'p.blanc@email.com'),
('Chen', 'Hua', 'CN1234567', 'hua.chen@email.com'),
('Wilson', 'Sarah', 'GB1234567', 's.wilson@email.com');

-- Insertion des classes de réservation
INSERT INTO Class_Reservation (class_name) VALUES
('Eco'),
('Business');

-- Insertion des réservations
INSERT INTO Reservations (pnr, passager_id, date_reservation, statut_paiement) VALUES
-- Réservations pour AF1234 (CDG-JFK)
('G7H2K9', 1, '2025-12-15 14:23:00', 'Payé'),
('M3N8P1', 2, '2025-12-20 09:45:00', 'Payé'),
('Q5R9T2', 3, '2026-01-02 16:30:00', 'Payé'),
-- Réservations pour AF5678 (JFK-CDG)
('A1B2C3', 4, '2025-12-18 11:20:00', 'Payé'),
('D4E5F6', 5, '2025-12-22 08:15:00', 'Payé'),
-- Réservations pour AF2468 (CDG-DXB)
('H7J8K9', 6, '2026-01-05 13:40:00', 'Payé'),
('L1M2N3', 7, '2026-01-06 10:25:00', 'Payé'),
('P4Q5R6', 8, '2026-01-07 15:50:00', 'Payé'),
-- Réservations pour AF3579 (ORY-BCN)
('S7T8U9', 9, '2026-01-03 12:10:00', 'Payé'),
('V1W2X3', 10, '2026-01-04 09:30:00', 'Payé'),
-- Réservations pour AF7890 (LHR-SIN)
('Y4Z5A6', 11, '2025-12-28 14:20:00', 'Payé'),
('B7C8D9', 12, '2026-01-01 11:45:00', 'Payé'),
-- Réservations pour AF1111 (CDG-LAX)
('E1F2G3', 13, '2026-01-08 08:30:00', 'Payé'),
-- Réservations pour vols passés
('K7L8M9', 14, '2025-12-30 10:15:00', 'Payé'),
('N1O2P3', 15, '2026-01-02 13:50:00', 'Payé'),
-- Réservations annulées
('X4Y5Z6', 16, '2025-12-25 16:40:00', 'Remboursé'),
('W7X8Y9', 17, '2026-01-05 14:00:00', 'Remboursé');

-- Insertion des paiements
INSERT INTO Paiements (reservation_id, montant, date_paiement, methode_paiement) VALUES
(1, 850.00, '2025-12-15 14:25:00', 'Carte de crédit'),
(2, 850.00, '2025-12-20 09:47:00', 'PayPal'),
(3, 850.00, '2026-01-02 16:32:00', 'Carte de crédit'),
(4, 920.00, '2025-12-18 11:22:00', 'Carte de crédit'),
(5, 920.00, '2025-12-22 08:17:00', 'Carte de crédit'),
(6, 1250.00, '2026-01-05 13:42:00', 'Carte de crédit'),
(7, 1250.00, '2026-01-06 10:27:00', 'PayPal'),
(8, 1250.00, '2026-01-07 15:52:00', 'Carte de crédit'),
(9, 180.00, '2026-01-03 12:12:00', 'Carte de crédit'),
(10, 180.00, '2026-01-04 09:32:00', 'PayPal'),
(11, 1580.00, '2025-12-28 14:22:00', 'Carte de crédit'),
(12, 1580.00, '2026-01-01 11:47:00', 'Carte de crédit'),
(13, 1100.00, '2026-01-08 08:32:00', 'PayPal'),
(14, 250.00, '2025-12-30 10:17:00', 'Carte de crédit'),
(15, 280.00, '2026-01-02 13:52:00', 'Carte de crédit'),
(16, 780.00, '2025-12-25 16:42:00', 'Carte de crédit'),
(17, 1100.00, '2026-01-05 14:02:00', 'Carte de crédit');

-- Insertion des détails de réservation (lien réservation-instance-classe-siège)
INSERT INTO Detail_Reservation (reservation_id, instance_id, classe, siege_assigne) VALUES
-- Réservations pour instance 1 (AF1234)
(1, 1, 1, '12A'),
(2, 1, 2, '3C'),
(3, 1, 1, '15F'),
-- Réservations pour instance 2 (AF5678)
(4, 2, 1, '20B'),
(5, 2, 1, '22D'),
-- Réservations pour instance 3 (AF2468)
(6, 3, 2, '5A'),
(7, 3, 1, '18C'),
(8, 3, 1, '25E'),
-- Réservations pour instance 4 (AF3579)
(9, 4, 1, '10A'),
(10, 4, 1, '11B'),
-- Réservations pour instance 5 (AF7890)
(11, 5, 2, '2A'),
(12, 5, 1, '30F'),
-- Réservations pour instance 6 (AF1111)
(13, 6, 1, '14C'),
-- Réservations pour instances passées
(14, 11, 1, '8A'),
(15, 11, 1, '9B'),
-- Réservations annulées
(16, 15, 1, '16D'),
(17, 6, 1, '17E');
