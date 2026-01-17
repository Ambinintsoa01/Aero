-- =============================================
-- SCRIPT: NOUVEL AVION TANA -> NOSY BE
-- Avion de 120 places avec 3 classes
-- =============================================

-- =============================================
-- 1. AJOUTER LA CLASSE "PREMIUM" (si elle n'existe pas)
-- =============================================
INSERT INTO classe (id, libelle) VALUES
(3, 'Premium')
ON CONFLICT (id) DO NOTHING;

SELECT setval('classe_id_seq', 3, true);

-- =============================================
-- 2. AJOUTER LE NOUVEL AVION (120 places)
-- =============================================
INSERT INTO avion (id, immatriculation, modele, constructeur, capacite, annee_fabrication, date_mise_service) VALUES
(6, '5R-MBF', 'Airbus A319', 'Airbus', 120, 2021, '2021-10-05');

SELECT setval('avion_id_seq', 6, true);

-- =============================================
-- 3. AJOUTER UN NOUVEAU VOL_MERE (si nécessaire)
-- =============================================
-- Utiliser le vol_mere existant (id=1: Tana -> Nosy Be AF101)

-- =============================================
-- 4. AJOUTER UN VOL_FILLE AVEC LE NOUVEL AVION
-- =============================================
INSERT INTO vol_fille (id, id_vol_mere, id_avion, date_prev_depart, date_prev_arrivee, date_reelle_depart, date_reelle_arrivee, status, date_creation, date_modification) VALUES
(19, 1, 6, '2026-01-24 06:00:00', '2026-01-24 07:30:00', NULL, NULL, 'PROGRAMME', NOW(), NOW());

SELECT setval('vol_fille_id_seq', 19, true);

-- =============================================
-- 5. AJOUTER LES 3 TARIFS POUR LE VOL 19
-- =============================================
INSERT INTO tarif (id, id_vol_fille, id_classe, id_devise, prix_total, date_emission) VALUES
-- Économique: 50 places @ 700000 Ar
(37, 19, 1, 1, 700000.00, NOW()),
-- Premium: 40 places @ 1000000 Ar
(38, 19, 3, 1, 1000000.00, NOW()),
-- Première Classe: 30 places @ 1200000 Ar
(39, 19, 2, 1, 1200000.00, NOW());

SELECT setval('tarif_id_seq', 40, true);

-- =============================================
-- 6. AJOUTER LES SIÈGES (120 places)
-- =============================================

-- Première Classe: 30 sièges (rangées 1-5, colonnes A-F)
INSERT INTO siege (id_avion, numero_siege, classe) VALUES
(6, '1A', 'Affaires'), (6, '1B', 'Affaires'), (6, '1C', 'Affaires'), (6, '1D', 'Affaires'), (6, '1E', 'Affaires'), (6, '1F', 'Affaires'),
(6, '2A', 'Affaires'), (6, '2B', 'Affaires'), (6, '2C', 'Affaires'), (6, '2D', 'Affaires'), (6, '2E', 'Affaires'), (6, '2F', 'Affaires'),
(6, '3A', 'Affaires'), (6, '3B', 'Affaires'), (6, '3C', 'Affaires'), (6, '3D', 'Affaires'), (6, '3E', 'Affaires'), (6, '3F', 'Affaires'),
(6, '4A', 'Affaires'), (6, '4B', 'Affaires'), (6, '4C', 'Affaires'), (6, '4D', 'Affaires'), (6, '4E', 'Affaires'), (6, '4F', 'Affaires'),
(6, '5A', 'Affaires'), (6, '5B', 'Affaires'), (6, '5C', 'Affaires'), (6, '5D', 'Affaires'), (6, '5E', 'Affaires'), (6, '5F', 'Affaires');

-- Premium: 40 sièges (rangées 6-10, colonnes A-F) + rangée 11 (A-D)
INSERT INTO siege (id_avion, numero_siege, classe) VALUES
(6, '6A', 'Premium'), (6, '6B', 'Premium'), (6, '6C', 'Premium'), (6, '6D', 'Premium'), (6, '6E', 'Premium'), (6, '6F', 'Premium'),
(6, '7A', 'Premium'), (6, '7B', 'Premium'), (6, '7C', 'Premium'), (6, '7D', 'Premium'), (6, '7E', 'Premium'), (6, '7F', 'Premium'),
(6, '8A', 'Premium'), (6, '8B', 'Premium'), (6, '8C', 'Premium'), (6, '8D', 'Premium'), (6, '8E', 'Premium'), (6, '8F', 'Premium'),
(6, '9A', 'Premium'), (6, '9B', 'Premium'), (6, '9C', 'Premium'), (6, '9D', 'Premium'), (6, '9E', 'Premium'), (6, '9F', 'Premium'),
(6, '10A', 'Premium'), (6, '10B', 'Premium'), (6, '10C', 'Premium'), (6, '10D', 'Premium'), (6, '10E', 'Premium'), (6, '10F', 'Premium'),
(6, '11A', 'Premium'), (6, '11B', 'Premium'), (6, '11C', 'Premium'), (6, '11D', 'Premium'), (6, '11E', 'Premium'), (6, '11F', 'Premium'),
(6, '12A', 'Premium'), (6, '12B', 'Premium'), (6, '12C', 'Premium'), (6, '12D', 'Premium');

-- Économique: 50 sièges (rangées 12-19, colonnes E-F) + (rangées 13-17 complètes)
INSERT INTO siege (id_avion, numero_siege, classe) VALUES
(6, '12E', 'Économique'), (6, '12F', 'Économique'),
(6, '13A', 'Économique'), (6, '13B', 'Économique'), (6, '13C', 'Économique'), (6, '13D', 'Économique'), (6, '13E', 'Économique'), (6, '13F', 'Économique'),
(6, '14A', 'Économique'), (6, '14B', 'Économique'), (6, '14C', 'Économique'), (6, '14D', 'Économique'), (6, '14E', 'Économique'), (6, '14F', 'Économique'),
(6, '15A', 'Économique'), (6, '15B', 'Économique'), (6, '15C', 'Économique'), (6, '15D', 'Économique'), (6, '15E', 'Économique'), (6, '15F', 'Économique'),
(6, '16A', 'Économique'), (6, '16B', 'Économique'), (6, '16C', 'Économique'), (6, '16D', 'Économique'), (6, '16E', 'Économique'), (6, '16F', 'Économique'),
(6, '17A', 'Économique'), (6, '17B', 'Économique'), (6, '17C', 'Économique'), (6, '17D', 'Économique'), (6, '17E', 'Économique'), (6, '17F', 'Économique'),
(6, '18A', 'Économique'), (6, '18B', 'Économique'), (6, '18C', 'Économique'), (6, '18D', 'Économique'), (6, '18E', 'Économique'), (6, '18F', 'Économique'),
(6, '19A', 'Économique'), (6, '19B', 'Économique'), (6, '19C', 'Économique'), (6, '19D', 'Économique'), (6, '19E', 'Économique'), (6, '19F', 'Économique'),
(6, '20A', 'Économique'), (6, '20B', 'Économique');

INSERT INTO siege (id_avion, numero_siege, classe) VALUES
(6, '20C', 'Économique'), (6, '20D', 'Économique'), (6, '20E', 'Économique'), (6, '20F', 'Économique');