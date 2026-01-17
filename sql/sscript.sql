-- TRUNCATE TABLES FOR TESTING PURPOSES

TRUNCATE TABLE devise, type_bagage, type_passager, type_personnel, type_vol, classe,
aeroport, personnel, passager, avion, fonction_personnel,
vol_mere, vol_fille, vol_historique, vol_gestion, tarif, siege,
billet, personnel_fonction CASCADE;


-- VolPlanifieDAO.java // findAll

SELECT vf.id, vf.id_vol_mere, vf.id_avion, vf.date_prev_depart,
vf.date_prev_arrivee, vf.date_reelle_depart, vf.date_reelle_arrivee,
vf.status, vf.date_creation, vf.date_modification, vm.code_vol,
a.immatriculation, a.capacite
FROM vol_fille vf
LEFT JOIN vol_mere vm ON vf.id_vol_mere = vm.id
LEFT JOIN avion a ON vf.id_avion = a.id
WHERE status = 'PROGRAMME'
ORDER BY vf.date_reelle_depart DESC;


-- VolDAO.java // findAll

SELECT v.id, v.code_vol, v.id_aeroport_origine, v.id_aeroport_destination, 
v.id_type_vol, ao.code as origine_code, ad.code as destination_code, tv.libelle as type 
FROM vol_mere v 
LEFT JOIN aeroport ao ON v.id_aeroport_origine = ao.id_aeroport 
LEFT JOIN aeroport ad ON v.id_aeroport_destination = ad.id_aeroport 
LEFT JOIN type_vol tv ON v.id_type_vol = tv.id 
LEFT JOIN 
ORDER BY v.id;


SELECT vf.id, vf.id_vol_mere, vf.id_avion, vf.date_prev_depart, 
vf.date_prev_arrivee, vf.date_reelle_depart, vf.date_reelle_arrivee, 
vf.status, vf.date_creation, vf.date_modification, vm.code_vol, 
a.immatriculation, a.capacite 
FROM vol_fille vf 
LEFT JOIN vol_mere vm ON vf.id_vol_mere = vm.id 
LEFT JOIN avion a ON vf.id_avion = a.id 
WHERE vf.id = 5;

select count(t.*) as capacite 
from vol_fille vf  
join tarif t on t.id_vol_fille=vf.id 
join siege s on s.id_avion=vf.id_avion 
join avion a on a.id=vf.id_avion 
where vf.id = 19
and t.id_classe = 1;

SELECT COUNT(DISTINCT s.classe) as nb_classes 
FROM vol_fille vf 
JOIN avion a ON a.id = vf.id_avion 
JOIN siege s ON s.id_avion = a.id 
WHERE vf.id = 19;


SELECT c.id as id_classe, c.libelle, 
COUNT(s.id) as nb_sieges, 
COALESCE(t.prix_total, 0) as tarif 
FROM vol_fille vf 
JOIN avion a ON a.id = vf.id_avion 
JOIN siege s ON s.id_avion = a.id 
JOIN classe c ON s.classe = c.libelle 
LEFT JOIN tarif t ON t.id_vol_fille = vf.id AND t.id_classe = c.id 
WHERE vf.id = 19 
GROUP BY c.id, c.libelle, t.prix_total 
ORDER BY c.id;