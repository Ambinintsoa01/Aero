-- ============================================
-- Données supplémentaires pour Places_Avion et Réservations
-- À ajouter après le script data.sql principal
-- ============================================

-- ============================================
-- 1. GÉNÉRATION AUTOMATIQUE DES PLACES POUR TOUS LES AVIONS
-- ============================================

-- Insérer les classes de réservation (si pas déjà fait)
INSERT INTO Class_Reservation (class_name) VALUES
('Eco'),
('Business')
ON CONFLICT DO NOTHING;

-- Générer toutes les places pour les avions
DO $$
DECLARE
    avion_rec RECORD;
    business_class_id INT;
    eco_class_id INT;
    rangee INT;
    col CHAR(1);
    cols_business CHAR(1)[] := ARRAY['A','B','C','D','E','F'];
    cols_eco CHAR(1)[] := ARRAY['A','B','C','D','E','F','G','H','I'];
    business_rows INT;
    eco_rows INT;
    position_type VARCHAR(10);
BEGIN
    -- Récupérer les IDs des classes
    SELECT class_id INTO business_class_id FROM Class_Reservation WHERE class_name = 'Business';
    SELECT class_id INTO eco_class_id FROM Class_Reservation WHERE class_name = 'Eco';

    -- Pour chaque avion
    FOR avion_rec IN SELECT avion_id, capacite_business, capacite_eco FROM Avions
    LOOP
        -- Calculer le nombre de rangées pour Business (6 sièges par rangée)
        business_rows := CEIL(avion_rec.capacite_business::NUMERIC / 6);
        
        -- Générer les places Business
        FOR rangee IN 1..business_rows
        LOOP
            FOREACH col IN ARRAY cols_business
            LOOP
                IF col = 'A' OR col = 'F' THEN
                    position_type := 'Fenêtre';
                ELSIF col = 'C' OR col = 'D' THEN
                    position_type := 'Couloir';
                ELSE
                    position_type := 'Milieu';
                END IF;
                
                INSERT INTO Places_Avion (avion_id, numero_siege, rangee, colonne, classe, position)
                VALUES (avion_rec.avion_id, rangee || col, rangee, col, business_class_id, position_type)
                ON CONFLICT DO NOTHING;
            END LOOP;
        END LOOP;
        
        -- Calculer le nombre de rangées pour Économique (9 sièges par rangée)
        eco_rows := CEIL(avion_rec.capacite_eco::NUMERIC / 9);
        
        -- Générer les places Économique
        FOR rangee IN (business_rows + 1)..(business_rows + eco_rows)
        LOOP
            FOREACH col IN ARRAY cols_eco
            LOOP
                IF col = 'A' OR col = 'I' THEN
                    position_type := 'Fenêtre';
                ELSIF col = 'C' OR col = 'G' THEN
                    position_type := 'Couloir';
                ELSE
                    position_type := 'Milieu';
                END IF;
                
                INSERT INTO Places_Avion (avion_id, numero_siege, rangee, colonne, classe, position)
                VALUES (avion_rec.avion_id, rangee || col, rangee, col, eco_class_id, position_type)
                ON CONFLICT DO NOTHING;
            END LOOP;
        END LOOP;
    END LOOP;
END $$;

-- ============================================
-- 2. AJOUTER PLUS DE PASSAGERS DE TEST
-- ============================================

INSERT INTO Passagers (nom, prenom, num_passeport, email) VALUES
('Müller', 'Hans', 'DE1234567', 'hans.muller@email.com'),
('Rossi', 'Marco', 'IT1234567', 'marco.rossi@email.com'),
('Kowalski', 'Jan', 'PL1234567', 'jan.kowalski@email.com'),
('Andersen', 'Erik', 'DK1234567', 'erik.andersen@email.com'),
('Bergström', 'Anna', 'SE1234567', 'anna.bergstrom@email.com'),
('Petrov', 'Ivan', 'RU1234567', 'ivan.petrov@email.com'),
('Costa', 'João', 'PT1234567', 'joao.costa@email.com'),
('Novak', 'Petra', 'HR1234567', 'petra.novak@email.com'),
('Simonov', 'Dmitri', 'RU2345678', 'dmitri.simonov@email.com'),
('Bianchi', 'Luca', 'IT2345678', 'luca.bianchi@email.com'),
('Dubois', 'Luc', 'FR6789012', 'luc.dubois@email.com'),
('Martin', 'Élise', 'FR7890123', 'elise.martin@email.com'),
('Lefevre', 'Nicolas', 'FR8901234', 'nicolas.lefevre@email.com'),
('Fournier', 'Camille', 'FR9012345', 'camille.fournier@email.com'),
('Moreno', 'Diego', 'ES3456789', 'diego.moreno@email.com'),
('Kumar', 'Raj', 'IN1234567', 'raj.kumar@email.com'),
('Patel', 'Priya', 'IN2345678', 'priya.patel@email.com'),
('Kim', 'Min-jun', 'KR1234567', 'min.jun@email.com'),
('Park', 'Ji-won', 'KR2345678', 'ji.won@email.com'),
('Yamamoto', 'Takeshi', 'JP1234567', 'takeshi.yamamoto@email.com'),
('Tanaka', 'Yuki', 'JP2345678', 'yuki.tanaka@email.com'),
('Miller', 'Jessica', 'US4567890', 'jessica.miller@email.com'),
('Thompson', 'David', 'US5678901', 'david.thompson@email.com'),
('Anderson', 'Jennifer', 'US6789012', 'jennifer.anderson@email.com'),
('Taylor', 'Michael', 'US7890123', 'michael.taylor@email.com'),
('O''Brien', 'Patrick', 'IE1234567', 'patrick.obrien@email.com'),
('Green', 'Alice', 'GB2345678', 'alice.green@email.com'),
('Moore', 'Charles', 'GB3456789', 'charles.moore@email.com'),
('Fischer', 'Klaus', 'AT1234567', 'klaus.fischer@email.com'),
('Weber', 'Ruth', 'CH1234567', 'ruth.weber@email.com');

-- ============================================
-- 3. AJOUTER PLUS DE RÉSERVATIONS
-- ============================================

-- Réservations supplémentaires pour AF1234 (CDG-JFK) - Instance 1
INSERT INTO Reservations (pnr, passager_id, date_reservation, statut_paiement) VALUES
('K9L0M1', 13, '2026-01-04 10:20:00', 'Payé'),
('N2O3P4', 14, '2026-01-04 14:15:00', 'Payé'),
('Q5R6S7', 15, '2026-01-05 09:40:00', 'Payé'),
('T8U9V0', 16, '2026-01-05 11:30:00', 'Payé'),
('W1X2Y3', 17, '2026-01-06 08:25:00', 'Payé'),
('Z4A5B6', 18, '2026-01-06 15:45:00', 'Payé'),
('C7D8E9', 19, '2026-01-07 10:10:00', 'En attente'),
('F0G1H2', 20, '2026-01-07 13:50:00', 'Payé'),
-- Réservations supplémentaires pour AF5678 (JFK-CDG) - Instance 2
('I3J4K5', 21, '2026-01-02 12:30:00', 'Payé'),
('L6M7N8', 22, '2026-01-03 09:15:00', 'Payé'),
('O9P0Q1', 23, '2026-01-03 16:45:00', 'Payé'),
('R2S3T4', 24, '2026-01-04 10:20:00', 'Payé'),
('U5V6W7', 25, '2026-01-04 14:10:00', 'Payé'),
-- Réservations supplémentaires pour AF2468 (CDG-DXB) - Instance 3
('X8Y9Z0', 26, '2026-01-08 11:25:00', 'Payé'),
('A1B2C3', 27, '2026-01-08 13:40:00', 'Payé'),
('D4E5F6', 28, '2026-01-08 15:30:00', 'Payé'),
('G7H8I9', 29, '2026-01-08 17:15:00', 'En attente'),
-- Réservations supplémentaires pour AF3579 (ORY-BCN) - Instance 4
('J0K1L2', 30, '2026-01-05 08:45:00', 'Payé'),
('M3N4O5', 31, '2026-01-05 10:30:00', 'Payé'),
('P6Q7R8', 32, '2026-01-05 14:20:00', 'Payé'),
('S9T0U1', 33, '2026-01-06 09:00:00', 'Payé'),
-- Réservations supplémentaires pour AF7890 (LHR-SIN) - Instance 5
('V2W3X4', 34, '2025-12-20 13:25:00', 'Payé'),
('Y5Z6A7', 35, '2025-12-25 10:40:00', 'Payé'),
('B8C9D0', 36, '2025-12-28 15:15:00', 'Payé'),
('E1F2G3', 37, '2025-12-30 11:50:00', 'Payé'),
('H4I5J6', 38, '2026-01-01 09:30:00', 'Payé'),
-- Réservations supplémentaires pour AF1111 (CDG-LAX) - Instance 6
('K7L8M9', 39, '2026-01-08 10:15:00', 'Payé'),
('N0O1P2', 40, '2026-01-08 12:40:00', 'Payé'),
('Q3R4S5', 4, '2026-01-08 14:25:00', 'Payé'),
('T6U7V8', 5, '2026-01-08 16:50:00', 'En attente');

-- ============================================
-- 4. AJOUTER LES DÉTAILS DE RÉSERVATION AVEC PLACES
-- ============================================

-- Fonction pour assigner automatiquement une place disponible
DO $$
DECLARE
    reservation_rec RECORD;
    place_id_found INT;
    business_class_id INT;
    eco_class_id INT;
BEGIN
    SELECT class_id INTO business_class_id FROM Class_Reservation WHERE class_name = 'Business';
    SELECT class_id INTO eco_class_id FROM Class_Reservation WHERE class_name = 'Eco';

    -- Pour chaque nouvelle réservation sans détail
    FOR reservation_rec IN 
        SELECT r.reservation_id, r.passager_id, 
               ROW_NUMBER() OVER (ORDER BY r.reservation_id) as rn
        FROM Reservations r
        WHERE NOT EXISTS (
            SELECT 1 FROM Detail_Reservation dr 
            WHERE dr.reservation_id = r.reservation_id
        )
        ORDER BY r.reservation_id
    LOOP
        -- Assigner à l'instance correspondante basée sur la réservation
        -- Cycle entre les instances disponibles
        DECLARE
            instance_id_val INT;
            classe_id INT;
            place_numero VARCHAR(5);
        BEGIN
            -- Assigner alternativement entre instances 1-6
            instance_id_val := ((reservation_rec.rn - 1) % 6) + 1;
            
            -- Assigner alternativement entre Business et Eco
            IF (reservation_rec.rn % 2) = 0 THEN
                classe_id := business_class_id;
            ELSE
                classe_id := eco_class_id;
            END IF;
            
            -- Trouver une place disponible pour cette instance et classe
            SELECT pa.place_id, pa.numero_siege INTO place_id_found, place_numero
            FROM Places_Avion pa
            WHERE pa.classe = classe_id
            AND pa.avion_id = (
                SELECT iv.avion_id FROM Instances_Vols iv WHERE iv.instance_id = instance_id_val
            )
            AND NOT EXISTS (
                SELECT 1 FROM Detail_Reservation dr2
                WHERE dr2.place_id = pa.place_id
                AND dr2.instance_id = instance_id_val
            )
            ORDER BY pa.rangee, pa.colonne
            LIMIT 1;
            
            -- Insérer le détail de réservation
            IF place_id_found IS NOT NULL THEN
                INSERT INTO Detail_Reservation (reservation_id, instance_id, classe, siege_assigne, place_id)
                VALUES (reservation_rec.reservation_id, instance_id_val, classe_id, place_numero, place_id_found);
            END IF;
        END;
    END LOOP;
END $$;

-- ============================================
-- 5. AFFICHAGE DES STATISTIQUES
-- ============================================

-- Vérifier le nombre de places par avion
SELECT 
    a.immatriculation,
    a.modele,
    cr.class_name,
    COUNT(pa.place_id) as nombre_places
FROM Avions a
LEFT JOIN Places_Avion pa ON a.avion_id = pa.avion_id
LEFT JOIN Class_Reservation cr ON pa.classe = cr.class_id
GROUP BY a.avion_id, a.immatriculation, a.modele, cr.class_name
ORDER BY a.immatriculation, cr.class_name;

-- Vérifier le nombre de réservations par instance
SELECT 
    v.numero_vol,
    iv.instance_id,
    iv.date_depart_reelle,
    a.immatriculation,
    COUNT(DISTINCT dr.reservation_id) as nombre_reservations,
    SUM(CASE WHEN cr.class_name = 'Business' THEN 1 ELSE 0 END) as business_count,
    SUM(CASE WHEN cr.class_name = 'Eco' THEN 1 ELSE 0 END) as eco_count
FROM Instances_Vols iv
JOIN Segments_Vol sv ON iv.segment_id = sv.segment_id
JOIN Vols v ON sv.vol_id = v.vol_id
JOIN Avions a ON iv.avion_id = a.avion_id
LEFT JOIN Detail_Reservation dr ON iv.instance_id = dr.instance_id
LEFT JOIN Class_Reservation cr ON dr.classe = cr.class_id
GROUP BY v.numero_vol, iv.instance_id, iv.date_depart_reelle, a.immatriculation
ORDER BY iv.date_depart_reelle, v.numero_vol;

-- Afficher un échantillon de places pour chaque avion (premières 10 places)
SELECT 
    a.immatriculation,
    pa.numero_siege,
    cr.class_name,
    pa.position,
    CASE 
        WHEN EXISTS (
            SELECT 1 FROM Detail_Reservation dr 
            WHERE dr.place_id = pa.place_id
        ) THEN 'Réservée'
        ELSE 'Disponible'
    END as statut
FROM Places_Avion pa
JOIN Avions a ON pa.avion_id = a.avion_id
JOIN Class_Reservation cr ON pa.classe = cr.class_id
ORDER BY a.immatriculation, pa.rangee, pa.colonne
LIMIT 100;
