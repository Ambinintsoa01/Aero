-- ============================================
-- VUE: DÉTAILS COMPLETS DE RÉSERVATION
-- ============================================

-- Vue pour afficher les détails d'une réservation avec tous les informations
CREATE OR REPLACE VIEW v_detail_reservation AS
SELECT 
    b.id AS id_billet,
    b.numero_billet,
    b.nom,
    b.prenom,
    b.date_naissance,
    b.nationalite,
    b.numero_passport,
    b.email,
    b.telephone,
    b.date_emission,
    b.status AS billet_status,
    
    -- Informations du vol
    vm.code_vol,
    vf.id AS id_vol_fille,
    vf.date_reelle_depart,
    vf.date_reelle_arrivee,
    vf.status AS vol_status,
    
    -- Informations de l'avion
    a.immatriculation,
    a.modele,
    
    -- Informations du siège
    s.numero_siege,
    s.classe,
    
    -- Informations du tarif
    t.prix_total,
    d.code AS devise_code,
    d.symbole AS devise_symbole,
    
    -- ID pour les jointures
    rs.id AS id_reservation_siege
    
FROM billet b
INNER JOIN reservation_siege rs ON b.id = rs.id_billet
INNER JOIN siege s ON rs.id_siege = s.id
INNER JOIN vol_fille vf ON rs.id_vol_fille = vf.id
INNER JOIN vol_mere vm ON vf.id_vol_mere = vm.id
INNER JOIN avion a ON vf.id_avion = a.id
INNER JOIN tarif t ON vf.id = t.id_vol_fille
INNER JOIN classe c ON t.id_classe = c.id
INNER JOIN devise d ON t.id_devise = d.id
ORDER BY b.date_emission DESC;

-- Vérification
SELECT 'Vue v_detail_reservation créée avec succès' AS status;
