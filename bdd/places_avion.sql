-- ============================================
-- Script de création de la table Places_Avion
-- et génération automatique des places
-- ============================================

-- 1. Créer la table Places_Avion
CREATE TABLE Places_Avion (
    place_id SERIAL PRIMARY KEY,
    avion_id INT REFERENCES Avions(avion_id) ON DELETE CASCADE,
    numero_siege VARCHAR(5) NOT NULL, -- ex: '12A', '15C', '1B'
    rangee INT NOT NULL, -- ex: 1, 2, 3...
    colonne CHAR(1) NOT NULL, -- ex: 'A', 'B', 'C', 'D', 'E', 'F'
    classe INT REFERENCES Class_Reservation(class_id),
    position VARCHAR(10), -- 'Fenêtre', 'Milieu', 'Couloir'
    UNIQUE(avion_id, numero_siege)
);

-- 2. Ajouter la colonne place_id dans Detail_Reservation
ALTER TABLE Detail_Reservation 
ADD COLUMN place_id INT REFERENCES Places_Avion(place_id);

-- 3. Créer un index pour optimiser les recherches de places disponibles
CREATE INDEX idx_places_avion_id ON Places_Avion(avion_id, classe);
CREATE INDEX idx_detail_reservation_place ON Detail_Reservation(place_id, instance_id);

-- ============================================
-- Fonction pour générer les places d'un avion
-- ============================================

-- Fonction pour déterminer la position du siège
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

-- ============================================
-- Génération des places pour chaque avion
-- ============================================

-- Pour chaque avion, on génère les places selon sa capacité
-- Configuration standard :
-- - Business : 2-2-2 (6 sièges par rangée) colonnes A,B,C,D,E,F
-- - Économique : 3-3-3 (9 sièges par rangée) colonnes A,B,C,D,E,F,G,H,I

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
    
    -- Si les classes n'existent pas, les créer
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
        
        -- Générer les places Business (rangées 1 à business_rows)
        FOR rangee IN 1..business_rows
        LOOP
            FOREACH col IN ARRAY cols_business
            LOOP
                -- Déterminer la position
                position_type := get_seat_position(col, 6);
                
                -- Insérer la place
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
        
        -- Générer les places Économique (après les rangées Business)
        FOR rangee IN (business_rows + 1)..(business_rows + eco_rows)
        LOOP
            FOREACH col IN ARRAY cols_eco
            LOOP
                -- Déterminer la position
                position_type := get_seat_position(col, 9);
                
                -- Insérer la place
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

-- ============================================
-- Vérification des places générées
-- ============================================

-- Afficher le nombre de places par avion et par classe
SELECT 
    a.immatriculation,
    a.modele,
    cr.class_name,
    COUNT(pa.place_id) as nombre_places,
    a.capacite_business,
    a.capacite_eco
FROM Avions a
LEFT JOIN Places_Avion pa ON a.avion_id = pa.avion_id
LEFT JOIN Class_Reservation cr ON pa.classe = cr.class_id
GROUP BY a.avion_id, a.immatriculation, a.modele, cr.class_name, a.capacite_business, a.capacite_eco
ORDER BY a.immatriculation, cr.class_name;

-- Afficher un échantillon de places pour chaque avion
SELECT 
    a.immatriculation,
    pa.numero_siege,
    cr.class_name,
    pa.position
FROM Places_Avion pa
JOIN Avions a ON pa.avion_id = a.avion_id
JOIN Class_Reservation cr ON pa.classe = cr.class_id
ORDER BY a.immatriculation, pa.rangee, pa.colonne
LIMIT 50;


select 
FROM
