-- ============================================
-- SCRIPT DE MISE À JOUR DE LA TABLE BILLET
-- ============================================

-- Étape 1: Créer la séquence pour numero_passport
CREATE SEQUENCE IF NOT EXISTS billet_passport_seq START WITH 1000000;

-- Étape 2: Supprimer la contrainte UNIQUE sur email
ALTER TABLE billet DROP CONSTRAINT IF EXISTS billet_email_key;

-- Étape 3: Modifier la colonne numero_passport pour avoir une valeur par défaut
-- D'abord, supprimer la contrainte NOT NULL temporairement
ALTER TABLE billet ALTER COLUMN numero_passport DROP NOT NULL;

-- Ajouter la valeur par défaut avec la séquence
ALTER TABLE billet ALTER COLUMN numero_passport SET DEFAULT ('PASS' || nextval('billet_passport_seq'));

-- Étape 4: Mettre à jour les enregistrements existants qui ont des numéros de passeport génériques
-- (Optionnel - seulement si vous voulez regénérer les passeports existants)
-- UPDATE billet SET numero_passport = DEFAULT WHERE numero_passport LIKE 'MG%' OR numero_passport LIKE 'FR%' OR numero_passport LIKE 'US%';

-- ============================================
-- VÉRIFICATIONS
-- ============================================

-- Vérifier la structure de la table
SELECT 
    column_name, 
    data_type, 
    is_nullable, 
    column_default,
    character_maximum_length
FROM information_schema.columns 
WHERE table_name = 'billet' 
ORDER BY ordinal_position;

-- Vérifier les contraintes
SELECT 
    conname AS constraint_name,
    contype AS constraint_type
FROM pg_constraint 
WHERE conrelid = 'billet'::regclass;
