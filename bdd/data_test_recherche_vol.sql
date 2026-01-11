-- Données de test pour la recherche de vol TNR -> Nosy Be pour le 12 janvier 2025

-- Ajouter les aéroports TNR et Nosy Be s'ils n'existent pas déjà
INSERT INTO Aeroports (code, nom, ville, pays, timezone) 
VALUES ('TNR', 'Aéroport International d''Ivato', 'Antananarivo', 'Madagascar', 'UTC+3')
ON CONFLICT (code) DO NOTHING;

INSERT INTO Aeroports (code, nom, ville, pays, timezone) 
VALUES ('NOS', 'Fascene Airport', 'Nosy Be', 'Madagascar', 'UTC+3')
ON CONFLICT (code) DO NOTHING;

-- Créer un vol TNR -> NOS s'il n'existe pas
INSERT INTO Vols (numero_vol, description)
VALUES ('MD101', 'Vol quotidien Antananarivo - Nosy Be')
ON CONFLICT (numero_vol) DO NOTHING;

-- Créer un segment de vol TNR -> NOS
INSERT INTO Segments_Vol (vol_id, ordre_segment, aeroport_depart, aeroport_arrivee, heure_depart_utc, heure_arrivee_utc, jour_semaine)
SELECT v.vol_id, 1, 'TNR', 'NOS', '09:00:00', '10:30:00', NULL
FROM Vols v WHERE v.numero_vol = 'MD101'
ON CONFLICT DO NOTHING;

-- Créer des instances de vol pour le 12 janvier 2025 avec plusieurs horaires
-- Instance 1: Départ à 09:00
INSERT INTO Instances_Vols (segment_id, avion_id, date_depart_reel, etat, prix)
SELECT sv.segment_id, a.avion_id, '2025-01-12', 'planifié', 150000.00
FROM Segments_Vol sv
JOIN Vols v ON sv.vol_id = v.vol_id
CROSS JOIN (SELECT avion_id FROM Avions LIMIT 1) a
WHERE v.numero_vol = 'MD101'
ON CONFLICT DO NOTHING;

-- Instance 2: Départ à 12:00 (même vol mais heure différente, autre segment)
INSERT INTO Segments_Vol (vol_id, ordre_segment, aeroport_depart, aeroport_arrivee, heure_depart_utc, heure_arrivee_utc, jour_semaine)
SELECT v.vol_id, 2, 'TNR', 'NOS', '12:00:00', '13:30:00', NULL
FROM Vols v WHERE v.numero_vol = 'MD101'
ON CONFLICT DO NOTHING;

INSERT INTO Instances_Vols (segment_id, avion_id, date_depart_reel, etat, prix)
SELECT sv.segment_id, a.avion_id, '2025-01-12', 'planifié', 180000.00
FROM Segments_Vol sv
JOIN Vols v ON sv.vol_id = v.vol_id
CROSS JOIN (SELECT avion_id FROM Avions ORDER BY avion_id LIMIT 1 OFFSET 1) a
WHERE v.numero_vol = 'MD101' AND sv.heure_depart_utc = '12:00:00'
ON CONFLICT DO NOTHING;

-- Instance 3: Départ à 16:00
INSERT INTO Segments_Vol (vol_id, ordre_segment, aeroport_depart, aeroport_arrivee, heure_depart_utc, heure_arrivee_utc, jour_semaine)
SELECT v.vol_id, 3, 'TNR', 'NOS', '16:00:00', '17:30:00', NULL
FROM Vols v WHERE v.numero_vol = 'MD101'
ON CONFLICT DO NOTHING;

INSERT INTO Instances_Vols (segment_id, avion_id, date_depart_reel, etat, prix)
SELECT sv.segment_id, a.avion_id, '2025-01-12', 'planifié', 165000.00
FROM Segments_Vol sv
JOIN Vols v ON sv.vol_id = v.vol_id
CROSS JOIN (SELECT avion_id FROM Avions ORDER BY avion_id LIMIT 1 OFFSET 2) a
WHERE v.numero_vol = 'MD101' AND sv.heure_depart_utc = '16:00:00'
ON CONFLICT DO NOTHING;

-- Ajouter quelques réservations sur le premier vol pour tester la disponibilité
-- (Cela réduira le nombre de sièges disponibles)
