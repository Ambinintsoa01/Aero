-- ============================================
-- Script ALTER pour ajouter la gestion des places
-- À exécuter sur une base de données existante
-- ============================================

-- 1. Créer la table Places_Avion si elle n'existe pas
CREATE TABLE IF NOT EXISTS Places_Avion (
    place_id SERIAL PRIMARY KEY,
    avion_id INT REFERENCES Avions(avion_id) ON DELETE CASCADE,
    numero_siege VARCHAR(5) NOT NULL,
    rangee INT NOT NULL,
    colonne CHAR(1) NOT NULL,
    classe INT REFERENCES Class_Reservation(class_id),
    position VARCHAR(10),
    UNIQUE(avion_id, numero_siege)
);

-- 2. Ajouter la colonne place_id dans Detail_Reservation si elle n'existe pas
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'detail_reservation' 
        AND column_name = 'place_id'
    ) THEN
        ALTER TABLE Detail_Reservation 
        ADD COLUMN place_id INT REFERENCES Places_Avion(place_id);
    END IF;
END $$;

-- 3. Créer les index si ils n'existent pas
CREATE INDEX IF NOT EXISTS idx_places_avion_id ON Places_Avion(avion_id, classe);
CREATE INDEX IF NOT EXISTS idx_detail_reservation_place ON Detail_Reservation(place_id, instance_id);

-- 4. Créer la fonction pour déterminer la position du siège
CREATE OR REPLACE FUNCTION get_seat_position(col CHAR(1), total_cols INT)
RETURNS VARCHAR(10) AS $$
BEGIN
    IF col = 'A' OR col = (CHR(64 + total_cols)) THEN
        RETURN 'Fenêtre';
    ELSIF total_cols = 6 AND (col = 'C' OR col = 'D') THEN
        RETURN 'Couloir';
    ELSIF total_cols = 9 AND (col = 'C' OR col = 'G') THEN
        RETURN 'Couloir';
    ELSE
        RETURN 'Milieu';
    END IF;
END;
$$ LANGUAGE plpgsql;

-- 5. Vider la table Places_Avion avant de regénérer (au cas où)
TRUNCATE TABLE Places_Avion CASCADE;

-- 6. Générer les places pour tous les avions existants
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
    -- Récupérer ou créer les IDs des classes
    SELECT class_id INTO business_class_id FROM Class_Reservation WHERE class_name = 'Business';
    SELECT class_id INTO eco_class_id FROM Class_Reservation WHERE class_name = 'Eco';
    
    IF business_class_id IS NULL THEN
        INSERT INTO Class_Reservation (class_name) VALUES ('Business') RETURNING class_id INTO business_class_id;
    END IF;
    IF eco_class_id IS NULL THEN
        INSERT INTO Class_Reservation (class_name) VALUES ('Eco') RETURNING class_id INTO eco_class_id;
    END IF;

    -- Pour chaque avion
    FOR avion_rec IN SELECT avion_id, capacite_business, capacite_eco, immatriculation FROM Avions
    LOOP
        RAISE NOTICE 'Génération des places pour avion % (ID: %)', avion_rec.immatriculation, avion_rec.avion_id;
        
        -- Calculer le nombre de rangées pour Business (6 sièges par rangée)
        business_rows := CEIL(avion_rec.capacite_business::NUMERIC / 6);
        
        -- Générer les places Business
        FOR rangee IN 1..business_rows
        LOOP
            FOREACH col IN ARRAY cols_business
            LOOP
                position_type := get_seat_position(col, 6);
                
                INSERT INTO Places_Avion (avion_id, numero_siege, rangee, colonne, classe, position)
                VALUES (
                    avion_rec.avion_id,
                    rangee || col,
                    rangee,
                    col,
                    business_class_id,
                    position_type
                );
            END LOOP;
        END LOOP;
        
        -- Calculer le nombre de rangées pour Économique (9 sièges par rangée)
        eco_rows := CEIL(avion_rec.capacite_eco::NUMERIC / 9);
        
        -- Générer les places Économique
        FOR rangee IN (business_rows + 1)..(business_rows + eco_rows)
        LOOP
            FOREACH col IN ARRAY cols_eco
            LOOP
                position_type := get_seat_position(col, 9);
                
                INSERT INTO Places_Avion (avion_id, numero_siege, rangee, colonne, classe, position)
                VALUES (
                    avion_rec.avion_id,
                    rangee || col,
                    rangee,
                    col,
                    eco_class_id,
                    position_type
                );
            END LOOP;
        END LOOP;
        
        RAISE NOTICE 'Places générées: % Business + % Économique', 
                     avion_rec.capacite_business, avion_rec.capacite_eco;
    END LOOP;
END $$;

-- 7. Mettre à jour les réservations existantes pour lier aux places
-- (Assigner automatiquement les places dans l'ordre pour les réservations existantes)
DO $$
DECLARE
    reservation_rec RECORD;
    place_disponible INT;
BEGIN
    FOR reservation_rec IN 
        SELECT dr.reservation_id, dr.instance_id, dr.classe, iv.avion_id
        FROM Detail_Reservation dr
        JOIN Instances_Vols iv ON dr.instance_id = iv.instance_id
        WHERE dr.place_id IS NULL
        ORDER BY dr.reservation_id
    LOOP
        -- Trouver une place disponible pour cette instance et cette classe
        SELECT pa.place_id INTO place_disponible
        FROM Places_Avion pa
        WHERE pa.avion_id = reservation_rec.avion_id
        AND pa.classe = reservation_rec.classe
        AND NOT EXISTS (
            SELECT 1 FROM Detail_Reservation dr2
            WHERE dr2.place_id = pa.place_id
            AND dr2.instance_id = reservation_rec.instance_id
        )
        ORDER BY pa.rangee, pa.colonne
        LIMIT 1;
        
        -- Mettre à jour la réservation avec la place trouvée
        IF place_disponible IS NOT NULL THEN
            UPDATE Detail_Reservation
            SET place_id = place_disponible,
                siege_assigne = (SELECT numero_siege FROM Places_Avion WHERE place_id = place_disponible)
            WHERE reservation_id = reservation_rec.reservation_id
            AND instance_id = reservation_rec.instance_id;
        END IF;
    END LOOP;
END $$;

-- 8. Vérification finale
SELECT 
    'Places générées par avion' as info,
    a.immatriculation,
    cr.class_name,
    COUNT(pa.place_id) as nombre_places
FROM Avions a
LEFT JOIN Places_Avion pa ON a.avion_id = pa.avion_id
LEFT JOIN Class_Reservation cr ON pa.classe = cr.class_id
GROUP BY a.immatriculation, cr.class_name
ORDER BY a.immatriculation, cr.class_name;
