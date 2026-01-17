-- =============================================
-- SCRIPT DE DONNÉES DE TEST COMPLET
-- Application: Gestion Compagnie Aérienne
-- Pays: Madagascar
-- Important: Vol Tana - Nosy Be avec tarifs spécifiques
-- =============================================

-- =============================================
-- 1. DONNÉES DE RÉFÉRENCE - TYPE_VOL
-- =============================================
INSERT INTO type_vol (id, libelle) VALUES
(1, 'Vol National'),
(2, 'Vol International'),
(3, 'Vol Régional');
SELECT setval('type_vol_id_seq', 3, true);

-- =============================================
-- 2. DONNÉES DE RÉFÉRENCE - TYPE_PERSONNEL
-- =============================================
INSERT INTO type_personnel (id, libelle) VALUES
(1, 'Personnel Navigant Technique'),
(2, 'Personnel Navigant Commercial'),
(3, 'Personnel au Sol');
SELECT setval('type_personnel_id_seq', 3, true);

-- =============================================
-- 3. DONNÉES DE RÉFÉRENCE - TYPE_PASSAGER
-- =============================================
INSERT INTO type_passager (id, libelle) VALUES
(1, 'Adulte'),
(2, 'Enfant'),
(3, 'Bébé'),
(4, 'Senior');
SELECT setval('type_passager_id_seq', 4, true);

-- =============================================
-- 4. DONNÉES DE RÉFÉRENCE - TYPE_BAGAGE
-- =============================================
INSERT INTO type_bagage (id, libelle) VALUES
(1, 'Bagage de soute'),
(2, 'Bagage cabine'),
(3, 'Équipement sportif');
SELECT setval('type_bagage_id_seq', 3, true);

-- =============================================
-- 5. DONNÉES DE RÉFÉRENCE - CLASSE
-- =============================================
INSERT INTO classe (id, libelle) VALUES
(1, 'Économique'),
(2, 'Affaires');
SELECT setval('classe_id_seq', 2, true);

-- =============================================
-- 6. DONNÉES DE RÉFÉRENCE - DEVISE
-- =============================================
INSERT INTO devise (id, code, libelle, symbole) VALUES
(1, 'MGA', 'Ariary Malgache', 'Ar'),
(2, 'USD', 'Dollar Américain', '$'),
(3, 'EUR', 'Euro', '€');
SELECT setval('devise_id_seq', 3, true);

-- =============================================
-- 7. DONNÉES PRINCIPALES - AÉROPORTS MADAGASCAR
-- =============================================
INSERT INTO aeroport (id_aeroport, code, nom, pays, ville) VALUES
(1, 'TAN', 'Aéroport International Ivato', 'Madagascar', 'Antananarivo'),
(2, 'NOZ', 'Aéroport Fascène', 'Madagascar', 'Nosy Be'),
(3, 'MJN', 'Aéroport de Majunga', 'Madagascar', 'Majunga'),
(4, 'DIE', 'Aéroport d''Antalaha', 'Madagascar', 'Antalaha'),
(5, 'TNR', 'Aéroport d''Antsiranana', 'Madagascar', 'Antsiranana'),
(6, 'TMM', 'Aéroport de Toliara', 'Madagascar', 'Toliara'),
(7, 'FEN', 'Aéroport de Fianarantsoa', 'Madagascar', 'Fianarantsoa');
SELECT setval('aeroport_id_aeroport_seq', 7, true);

-- =============================================
-- 8. DONNÉES PRINCIPALES - AVIONS
-- =============================================
INSERT INTO avion (id, immatriculation, modele, constructeur, capacite, annee_fabrication, date_mise_service) VALUES
(1, '5R-MBA', 'Boeing 737-800', 'Boeing', 189, 2015, '2015-06-15'),
(2, '5R-MBB', 'Airbus A320', 'Airbus', 180, 2018, '2018-09-20'),
(3, '5R-MBC', 'ATR 72-600', 'ATR', 72, 2019, '2019-03-10'),
(4, '5R-MBD', 'Embraer E190', 'Embraer', 124, 2020, '2020-07-25'),
(5, '5R-MBE', 'Boeing 777-200ER', 'Boeing', 314, 2012, '2012-08-30');
SELECT setval('avion_id_seq', 5, true);

-- =============================================
-- 9. DONNÉES PRINCIPALES - PERSONNEL
-- =============================================
INSERT INTO personnel (id, matricule, nom, prenom, date_naissance, nationalite, email, telephone, adresse) VALUES
-- Pilotes
(1, 'PNT001', 'Rakoto', 'Jean', '1975-05-15', 'Malgache', 'jean.rakoto@airline.mg', '+261320000001', 'Antananarivo'),
(2, 'PNT002', 'Andrianampoinimerina', 'Paul', '1978-08-20', 'Malgache', 'paul.andria@airline.mg', '+261320000002', 'Antananarivo'),
(3, 'PNT003', 'Razafindra', 'Michel', '1980-03-10', 'Malgache', 'michel.razafindra@airline.mg', '+261320000003', 'Antananarivo'),
-- Copilotes
(4, 'PNT004', 'Rasoamampianina', 'David', '1985-12-05', 'Malgache', 'david.rasoa@airline.mg', '+261320000004', 'Antananarivo'),
(5, 'PNT005', 'Rabearivony', 'Thomas', '1982-07-18', 'Malgache', 'thomas.rabea@airline.mg', '+261320000005', 'Antananarivo'),
-- Hôtesses de l'air
(6, 'PNC001', 'Randriamanantena', 'Marie', '1990-11-25', 'Malgache', 'marie.randria@airline.mg', '+261320000006', 'Antananarivo'),
(7, 'PNC002', 'Ravaloson', 'Sophie', '1992-09-30', 'Malgache', 'sophie.ravalo@airline.mg', '+261320000007', 'Antananarivo'),
(8, 'PNC003', 'Randriamampoinimerina', 'Valérie', '1988-04-22', 'Malgache', 'valerie.randri@airline.mg', '+261320000008', 'Antananarivo'),
(9, 'PNC004', 'Rasoamampianina', 'Julie', '1991-06-15', 'Malgache', 'julie.rasoa@airline.mg', '+261320000009', 'Antananarivo'),
-- Personnel au sol
(10, 'PS001', 'Rakotomalala', 'Hery', '1987-04-22', 'Malgache', 'hery.rakoto@airline.mg', '+261320000010', 'Antananarivo'),
(11, 'PS002', 'Ramiandrisoa', 'Bé', '1989-02-14', 'Malgache', 'be.ramia@airline.mg', '+261320000011', 'Antananarivo'),
(12, 'PS003', 'Ranaivoson', 'Fara', '1986-08-10', 'Malgache', 'fara.ranai@airline.mg', '+261320000012', 'Antananarivo');
SELECT setval('personnel_id_seq', 12, true);

-- =============================================
-- 10. FONCTION_PERSONNEL
-- =============================================
INSERT INTO fonction_personnel (id, libelle, id_type_personnel) VALUES
(1, 'Commandant de bord', 1),
(2, 'Copilote', 1),
(3, 'Mécanicien navigant', 1),
(4, 'Chef de cabine', 2),
(5, 'Hôtesse de l''air', 2),
(6, 'Steward', 2),
(7, 'Agent d''enregistrement', 3),
(8, 'Agent de piste', 3),
(9, 'Responsable Opérations', 3);
SELECT setval('fonction_personnel_id_seq', 9, true);

-- =============================================
-- 11. PERSONNEL_FONCTION
-- =============================================
INSERT INTO personnel_fonction (id, id_personnel, id_fonction, date_obtention_poste) VALUES
(1, 1, 1, '2010-01-15'),
(2, 2, 1, '2012-03-20'),
(3, 3, 1, '2011-06-10'),
(4, 4, 2, '2015-09-01'),
(5, 5, 2, '2014-02-15'),
(6, 6, 4, '2020-01-20'),
(7, 7, 5, '2020-02-15'),
(8, 8, 5, '2019-11-20'),
(9, 9, 5, '2021-05-10'),
(10, 10, 7, '2016-08-25'),
(11, 11, 8, '2017-05-30'),
(12, 12, 9, '2018-11-15');
SELECT setval('personnel_fonction_id_seq', 12, true);

-- =============================================
-- 12. PASSAGER
-- =============================================
INSERT INTO passager (id, nom, prenom, date_naissance, nationalite, numero_passport, email, telephone, id_type_passager) VALUES
(1, 'Rakoto', 'Jean-Pierre', '1970-06-15', 'Malgache', 'MG001001', 'jean-pierre.rakoto@email.mg', '+261320001001', 1),
(2, 'Rasoamampianina', 'Marie-Claire', '1985-03-22', 'Malgache', 'MG001002', 'marie-claire.rasoa@email.mg', '+261320001002', 1),
(3, 'Rabearivony', 'André', '1965-11-08', 'Malgache', 'MG001003', 'andre.rabea@email.mg', '+261320001003', 1),
(4, 'Randriamanantena', 'Faly', '2005-04-12', 'Malgache', 'MG001004', 'faly.randria@email.mg', '+261320001004', 2),
(5, 'Ravaloson', 'David', '1998-09-30', 'Malgache', 'MG001005', 'david.ravalo@email.mg', '+261320001005', 1),
(6, 'Ramiandrisoa', 'Sophie', '1980-12-05', 'Malgache', 'MG001006', 'sophie.ramia@email.mg', '+261320001006', 1),
(7, 'Ranaivoson', 'Thomas', '1992-07-18', 'Malgache', 'MG001007', 'thomas.ranai@email.mg', '+261320001007', 1),
(8, 'Rakotomalala', 'Bérengère', '2008-01-25', 'Malgache', 'MG001008', 'berengere.rakoto@email.mg', '+261320001008', 2),
(9, 'Randriamampoinimerina', 'Valérie', '1975-05-10', 'Malgache', 'MG001009', 'valerie.randri@email.mg', '+261320001009', 1),
(10, 'Rasoamampianina', 'Hery', '1960-08-20', 'Malgache', 'MG001010', 'hery.rasoa@email.mg', '+261320001010', 4);
SELECT setval('passager_id_seq', 10, true);

-- =============================================
-- 13. VOL_MÈRE - ROUTES MADAGASCAR
-- =============================================
INSERT INTO vol_mere (id, code_vol, id_aeroport_origine, id_aeroport_destination, id_type_vol) VALUES
-- Vol Principal: Tana - Nosy Be
(1, 'AF101', 1, 2, 1),
(2, 'AF102', 2, 1, 1),
-- Autres vols internes
(3, 'AF201', 1, 3, 1),
(4, 'AF202', 3, 1, 1),
(5, 'AF301', 1, 4, 1),
(6, 'AF302', 4, 1, 1),
(7, 'AF401', 1, 5, 1),
(8, 'AF402', 5, 1, 1),
(9, 'AF501', 1, 6, 1),
(10, 'AF502', 6, 1, 1),
(11, 'AF601', 1, 7, 1),
(12, 'AF602', 7, 1, 1),
(13, 'AF701', 2, 3, 1),
(14, 'AF702', 3, 2, 1);
SELECT setval('vol_mere_id_seq', 14, true);

-- =============================================
-- 14. VOL_FILLE - VOLS PLANIFIÉS
-- =============================================
INSERT INTO vol_fille (id, id_vol_mere, id_avion, date_prev_depart, date_prev_arrivee, date_reelle_depart, date_reelle_arrivee, status, date_creation, date_modification) VALUES
-- VOL PRINCIPAL: Tana -> Nosy Be (AF101)
(1, 1, 1, '2026-01-20 06:00:00', '2026-01-20 07:30:00', '2026-01-20 06:15:00', '2026-01-20 07:45:00', 'PROGRAMME', NOW(), NOW()),
(2, 1, 1, '2026-01-21 06:00:00', '2026-01-21 07:30:00', '2026-01-21 06:10:00', '2026-01-21 07:40:00', 'PROGRAMME', NOW(), NOW()),
(3, 1, 1, '2026-01-22 06:00:00', '2026-01-22 07:30:00', '2026-01-22 06:05:00', '2026-01-22 07:35:00', 'PROGRAMME', NOW(), NOW()),
(4, 1, 1, '2026-01-23 06:00:00', '2026-01-23 07:30:00', '2026-01-23 06:20:00', '2026-01-23 07:50:00', 'PROGRAMME', NOW(), NOW()),

-- Nosy Be -> Tana (AF102)
(5, 2, 2, '2026-01-20 09:00:00', '2026-01-20 10:30:00', '2026-01-20 09:10:00', '2026-01-20 10:40:00', 'PROGRAMME', NOW(), NOW()),
(6, 2, 2, '2026-01-21 09:00:00', '2026-01-21 10:30:00', '2026-01-21 09:05:00', '2026-01-21 10:35:00', 'PROGRAMME', NOW(), NOW()),
(7, 2, 2, '2026-01-22 09:00:00', '2026-01-22 10:30:00', '2026-01-22 09:15:00', '2026-01-22 10:45:00', 'PROGRAMME', NOW(), NOW()),

-- Tana -> Majunga (AF201)
(8, 3, 3, '2026-01-20 08:00:00', '2026-01-20 09:45:00', '2026-01-20 08:05:00', '2026-01-20 09:50:00', 'PROGRAMME', NOW(), NOW()),
(9, 3, 3, '2026-01-22 08:00:00', '2026-01-22 09:45:00', '2026-01-22 08:10:00', '2026-01-22 09:55:00', 'PROGRAMME', NOW(), NOW()),

-- Majunga -> Tana (AF202)
(10, 4, 4, '2026-01-20 14:00:00', '2026-01-20 15:45:00', '2026-01-20 14:10:00', '2026-01-20 15:55:00', 'PROGRAMME', NOW(), NOW()),
(11, 4, 4, '2026-01-22 14:00:00', '2026-01-22 15:45:00', '2026-01-22 14:05:00', '2026-01-22 15:50:00', 'PROGRAMME', NOW(), NOW()),

-- Tana -> Antalaha (AF301)
(12, 5, 2, '2026-01-21 10:00:00', '2026-01-21 12:00:00', '2026-01-21 10:10:00', '2026-01-21 12:10:00', 'PROGRAMME', NOW(), NOW()),
(13, 5, 2, '2026-01-23 10:00:00', '2026-01-23 12:00:00', '2026-01-23 10:05:00', '2026-01-23 12:05:00', 'PROGRAMME', NOW(), NOW()),

-- Antalaha -> Tana (AF302)
(14, 6, 5, '2026-01-21 15:00:00', '2026-01-21 17:00:00', '2026-01-21 15:15:00', '2026-01-21 17:15:00', 'PROGRAMME', NOW(), NOW()),

-- Tana -> Antsiranana (AF401)
(15, 7, 1, '2026-01-20 11:00:00', '2026-01-20 13:30:00', '2026-01-20 11:10:00', '2026-01-20 13:40:00', 'PROGRAMME', NOW(), NOW()),

-- Antsiranana -> Tana (AF402)
(16, 8, 1, '2026-01-20 18:00:00', '2026-01-20 20:30:00', '2026-01-20 18:15:00', '2026-01-20 20:45:00', 'PROGRAMME', NOW(), NOW()),

-- Tana -> Toliara (AF501)
(17, 9, 3, '2026-01-23 12:00:00', '2026-01-23 14:30:00', '2026-01-23 12:10:00', '2026-01-23 14:40:00', 'PROGRAMME', NOW(), NOW()),

-- Toliara -> Tana (AF502)
(18, 10, 3, '2026-01-23 17:00:00', '2026-01-23 19:30:00', '2026-01-23 17:15:00', '2026-01-23 19:45:00', 'PROGRAMME', NOW(), NOW());
SELECT setval('vol_fille_id_seq', 18, true);

-- =============================================
-- 15. VOL_GESTION
-- =============================================
INSERT INTO vol_gestion (id, id_vol_fille, id_personnel, id_fonction, nbre_personnel_pnt, nbre_personnel_pnc) VALUES
(1, 1, 1, 1, 2, 4),
(2, 1, 6, 4, 2, 4),
(3, 2, 2, 1, 2, 4),
(4, 2, 7, 4, 2, 4),
(5, 3, 3, 1, 2, 3),
(6, 3, 8, 4, 2, 3),
(7, 4, 1, 1, 2, 4),
(8, 4, 9, 4, 2, 4),
(9, 5, 4, 2, 2, 4),
(10, 6, 5, 2, 2, 4),
(11, 7, 2, 1, 2, 3),
(12, 8, 1, 1, 2, 3),
(13, 9, 3, 1, 2, 3),
(14, 10, 4, 2, 2, 3),
(15, 11, 5, 2, 2, 3),
(16, 12, 2, 1, 2, 4),
(17, 13, 3, 1, 2, 4),
(18, 14, 1, 1, 2, 3);
SELECT setval('vol_gestion_id_seq', 18, true);

-- =============================================
-- 16. TARIF - TOUS LES VOLS AVEC IDS EXPLICITES
-- =============================================
INSERT INTO tarif (id, id_vol_fille, id_classe, id_devise, prix_total, date_emission) VALUES
-- VOL 1-4: Tana -> Nosy Be (tarifs 1-8)
(1, 1, 1, 1, 700000.00, NOW()),
(2, 1, 2, 1, 1200000.00, NOW()),
(3, 2, 1, 1, 700000.00, NOW()),
(4, 2, 2, 1, 1200000.00, NOW()),
(5, 3, 1, 1, 700000.00, NOW()),
(6, 3, 2, 1, 1200000.00, NOW()),
(7, 4, 1, 1, 700000.00, NOW()),
(8, 4, 2, 1, 1200000.00, NOW()),
-- VOL 5-7: Nosy Be -> Tana (tarifs 9-14)
(9, 5, 1, 1, 700000.00, NOW()),
(10, 5, 2, 1, 1200000.00, NOW()),
(11, 6, 1, 1, 700000.00, NOW()),
(12, 6, 2, 1, 1200000.00, NOW()),
(13, 7, 1, 1, 700000.00, NOW()),
(14, 7, 2, 1, 1200000.00, NOW()),
-- VOL 8-9: Tana -> Majunga (tarifs 15-18)
(15, 8, 1, 1, 550000.00, NOW()),
(16, 8, 2, 1, 950000.00, NOW()),
(17, 9, 1, 1, 550000.00, NOW()),
(18, 9, 2, 1, 950000.00, NOW()),
-- VOL 10-11: Majunga -> Tana (tarifs 19-22)
(19, 10, 1, 1, 550000.00, NOW()),
(20, 10, 2, 1, 950000.00, NOW()),
(21, 11, 1, 1, 550000.00, NOW()),
(22, 11, 2, 1, 950000.00, NOW()),
-- VOL 12-13: Tana -> Antalaha (tarifs 23-26)
(23, 12, 1, 1, 850000.00, NOW()),
(24, 12, 2, 1, 1350000.00, NOW()),
(25, 13, 1, 1, 850000.00, NOW()),
(26, 13, 2, 1, 1350000.00, NOW()),
-- VOL 14: Antalaha -> Tana (tarifs 27-28)
(27, 14, 1, 1, 850000.00, NOW()),
(28, 14, 2, 1, 1350000.00, NOW()),
-- VOL 15: Tana -> Antsiranana (tarifs 29-30)
(29, 15, 1, 1, 800000.00, NOW()),
(30, 15, 2, 1, 1300000.00, NOW()),
-- VOL 16: Antsiranana -> Tana (tarifs 31-32)
(31, 16, 1, 1, 800000.00, NOW()),
(32, 16, 2, 1, 1300000.00, NOW()),
-- VOL 17: Tana -> Toliara (tarifs 33-34)
(33, 17, 1, 1, 650000.00, NOW()),
(34, 17, 2, 1, 1100000.00, NOW()),
-- VOL 18: Toliara -> Tana (tarifs 35-36)
(35, 18, 1, 1, 650000.00, NOW()),
(36, 18, 2, 1, 1100000.00, NOW());

SELECT setval('tarif_id_seq', 37, true);

-- =============================================
-- 17. BILLET
-- =============================================
INSERT INTO billet (id, numero_billet, id_tarif, id_type_passager, nom, prenom, date_naissance, nationalite, numero_passport, email, telephone, date_emission, status) VALUES
-- Billets Vol 1 (Tana -> Nosy Be - AF101)
(1, 'BIL2026001', 1, 1, 'Rakoto', 'Jean-Pierre', '1970-06-15', 'Malgache', 'MG001001', 'jean-pierre.rakoto@email.mg', '+261320001001', NOW(), 'EMIS'),
(2, 'BIL2026002', 2, 1, 'Rasoamampianina', 'Marie-Claire', '1985-03-22', 'Malgache', 'MG001002', 'marie-claire.rasoa@email.mg', '+261320001002', NOW(), 'EMIS'),
(3, 'BIL2026003', 1, 1, 'Rabearivony', 'André', '1965-11-08', 'Malgache', 'MG001003', 'andre.rabea@email.mg', '+261320001003', NOW(), 'EMIS'),
(4, 'BIL2026004', 2, 2, 'Randriamanantena', 'Faly', '2005-04-12', 'Malgache', 'MG001004', 'faly.randria@email.mg', '+261320001004', NOW(), 'EMIS'),

-- Billets Vol 5 (Nosy Be -> Tana - AF102)
(5, 'BIL2026005', 9, 1, 'Ravaloson', 'David', '1998-09-30', 'Malgache', 'MG001005', 'david.ravalo@email.mg', '+261320001005', NOW(), 'EMIS'),
(6, 'BIL2026006', 10, 1, 'Ramiandrisoa', 'Sophie', '1980-12-05', 'Malgache', 'MG001006', 'sophie.ramia@email.mg', '+261320001006', NOW(), 'EMIS'),

-- Billets Vol 8 (Tana -> Majunga - AF201)
(7, 'BIL2026007', 15, 1, 'Ranaivoson', 'Thomas', '1992-07-18', 'Malgache', 'MG001007', 'thomas.ranai@email.mg', '+261320001007', NOW(), 'EMIS'),
(8, 'BIL2026008', 16, 1, 'Rakotomalala', 'Bérengère', '2008-01-25', 'Malgache', 'MG001008', 'berengere.rakoto@email.mg', '+261320001008', NOW(), 'EMIS'),

-- Billets Vol 12 (Tana -> Antalaha - AF301)
(9, 'BIL2026009', 23, 1, 'Randriamampoinimerina', 'Valérie', '1975-05-10', 'Malgache', 'MG001009', 'valerie.randri@email.mg', '+261320001009', NOW(), 'EMIS'),
(10, 'BIL2026010', 24, 4, 'Rasoamampianina', 'Hery', '1960-08-20', 'Malgache', 'MG001010', 'hery.rasoa@email.mg', '+261320001010', NOW(), 'EMIS');
SELECT setval('billet_id_seq', 10, true);
