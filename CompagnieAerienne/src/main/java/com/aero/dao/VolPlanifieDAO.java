package com.aero.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.aero.model.VolPlanifie;
import com.aero.util.DatabaseConnection;

/**
 * DAO pour la gestion des vols planifiés (Vol Fille)
 */
public class VolPlanifieDAO {

    /**
     * Récupère tous les vols planifiés
     */
    public List<VolPlanifie> findAll() {
        List<VolPlanifie> vols = new ArrayList<>();
        String sql = "SELECT vf.id, vf.id_vol_mere, vf.id_avion, vf.date_prev_depart, "
                + "vf.date_prev_arrivee, vf.date_reelle_depart, vf.date_reelle_arrivee, "
                + "vf.status, vf.date_creation, vf.date_modification, vm.code_vol, "
                + "a.immatriculation, a.capacite, "
                + "ao.code as aeroport_origine, ad.code as aeroport_destination "
                + "FROM vol_fille vf "
                + "LEFT JOIN vol_mere vm ON vf.id_vol_mere = vm.id "
                + "LEFT JOIN avion a ON vf.id_avion = a.id "
                + "LEFT JOIN aeroport ao ON vm.id_aeroport_origine = ao.id_aeroport "
                + "LEFT JOIN aeroport ad ON vm.id_aeroport_destination = ad.id_aeroport "
                + "WHERE status = 'PROGRAMME' "
                + "ORDER BY vf.date_reelle_depart DESC";

        try (Connection conn = DatabaseConnection.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                vols.add(mapResultSetToVolPlanifie(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des vols planifiés : " + e.getMessage());
        }
        return vols;
    }

    /**
     * Récupère un vol planifié par son ID
     */
    public VolPlanifie findById(int id) {
        String sql = "SELECT vf.id, vf.id_vol_mere, vf.id_avion, vf.date_prev_depart, "
                + "vf.date_prev_arrivee, vf.date_reelle_depart, vf.date_reelle_arrivee, "
                + "vf.status, vf.date_creation, vf.date_modification, vm.code_vol, "
                + "a.immatriculation, a.capacite, "
                + "ao.code as aeroport_origine, ad.code as aeroport_destination "
                + "FROM vol_fille vf "
                + "LEFT JOIN vol_mere vm ON vf.id_vol_mere = vm.id "
                + "LEFT JOIN avion a ON vf.id_avion = a.id "
                + "LEFT JOIN aeroport ao ON vm.id_aeroport_origine = ao.id_aeroport "
                + "LEFT JOIN aeroport ad ON vm.id_aeroport_destination = ad.id_aeroport "
                + "WHERE vf.id = ?";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToVolPlanifie(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération du vol planifié : " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Crée une planification de vol
     */
    public VolPlanifie create(VolPlanifie vol) {
        String sql = "INSERT INTO vol_fille (id_vol_mere, id_avion, date_prev_depart, "
                + "date_prev_arrivee, date_reelle_depart, date_reelle_arrivee, status, "
                + "date_creation, date_modification) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING id";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, vol.getId_vol_mere());
            pstmt.setInt(2, vol.getId_avion());
            pstmt.setTimestamp(3, vol.getDate_prev_depart() != null
                    ? Timestamp.valueOf(vol.getDate_prev_depart()) : null);
            pstmt.setTimestamp(4, vol.getDate_prev_arrivee() != null
                    ? Timestamp.valueOf(vol.getDate_prev_arrivee()) : null);
            pstmt.setTimestamp(5, Timestamp.valueOf(vol.getDate_reelle_depart()));
            pstmt.setTimestamp(6, Timestamp.valueOf(vol.getDate_reelle_arrivee()));
            pstmt.setString(7, vol.getStatus());
            pstmt.setTimestamp(8, Timestamp.valueOf(vol.getDate_creation()));
            pstmt.setTimestamp(9, Timestamp.valueOf(vol.getDate_modification()));

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    vol.setId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la création de la planification : " + e.getMessage());
        }
        return vol;
    }

    /**
     * Met à jour une planification de vol
     */
    public boolean update(VolPlanifie vol) {
        String sql = "UPDATE vol_fille SET id_vol_mere = ?, id_avion = ?, "
                + "date_prev_depart = ?, date_prev_arrivee = ?, date_reelle_depart = ?, "
                + "date_reelle_arrivee = ?, status = ?, date_modification = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, vol.getId_vol_mere());
            pstmt.setInt(2, vol.getId_avion());
            pstmt.setTimestamp(3, vol.getDate_prev_depart() != null
                    ? Timestamp.valueOf(vol.getDate_prev_depart()) : null);
            pstmt.setTimestamp(4, vol.getDate_prev_arrivee() != null
                    ? Timestamp.valueOf(vol.getDate_prev_arrivee()) : null);
            pstmt.setTimestamp(5, Timestamp.valueOf(vol.getDate_reelle_depart()));
            pstmt.setTimestamp(6, Timestamp.valueOf(vol.getDate_reelle_arrivee()));
            pstmt.setString(7, vol.getStatus());
            pstmt.setTimestamp(8, Timestamp.valueOf(LocalDateTime.now()));
            pstmt.setInt(9, vol.getId());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour : " + e.getMessage());
        }
        return false;
    }

    /**
     * Récupère les vols planifiés pour un vol mère spécifique
     */
    public List<VolPlanifie> findByVolMere(int idVolMere) {
        List<VolPlanifie> vols = new ArrayList<>();
        String sql = "SELECT vf.id, vf.id_vol_mere, vf.id_avion, vf.date_prev_depart, "
                + "vf.date_prev_arrivee, vf.date_reelle_depart, vf.date_reelle_arrivee, "
                + "vf.status, vf.date_creation, vf.date_modification, vm.code_vol, "
                + "a.immatriculation, a.capacite "
                + "FROM vol_fille vf "
                + "LEFT JOIN vol_mere vm ON vf.id_vol_mere = vm.id "
                + "LEFT JOIN avion a ON vf.id_avion = a.id "
                + "WHERE vf.id_vol_mere = ? ORDER BY vf.date_reelle_depart DESC";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idVolMere);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    vols.add(mapResultSetToVolPlanifie(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des vols planifiés : " + e.getMessage());
        }
        return vols;
    }

    private VolPlanifie mapResultSetToVolPlanifie(ResultSet rs) throws SQLException {
        VolPlanifie vol = new VolPlanifie(
                rs.getInt("id"),
                rs.getInt("id_vol_mere"),
                rs.getInt("id_avion"),
                rs.getTimestamp("date_prev_depart") != null
                ? rs.getTimestamp("date_prev_depart").toLocalDateTime() : null,
                rs.getTimestamp("date_prev_arrivee") != null
                ? rs.getTimestamp("date_prev_arrivee").toLocalDateTime() : null,
                rs.getTimestamp("date_reelle_depart").toLocalDateTime(),
                rs.getTimestamp("date_reelle_arrivee").toLocalDateTime(),
                rs.getString("status"),
                rs.getTimestamp("date_creation").toLocalDateTime(),
                rs.getTimestamp("date_modification").toLocalDateTime()
        );
        vol.setCode_vol(rs.getString("code_vol"));
        vol.setImmatriculation_avion(rs.getString("immatriculation"));
        vol.setCapacite_avion(rs.getInt("capacite"));

        // Construire le trajet (départ - arrivée)
        String aeroOrigine = rs.getString("aeroport_origine");
        String aeroDestination = rs.getString("aeroport_destination");
        if (aeroOrigine != null && aeroDestination != null) {
            vol.setAeroport_origine_code(aeroOrigine);
            vol.setAeroport_destination_code(aeroDestination);
        }

        return vol;
    }


    public void saveTarif(int id_avion, int id_classe, double prix) {
        // Vérifier si le tarif existe déjà
        String checkSql = "SELECT id FROM tarif WHERE id_avion = ? AND id_classe = ?";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement checkPstmt = conn.prepareStatement(checkSql)) {

            checkPstmt.setInt(1, id_avion);
            checkPstmt.setInt(2, id_classe);

            try (ResultSet rs = checkPstmt.executeQuery()) {
                if (rs.next()) {
                    // Mettre à jour le tarif existant
                    String updateSql = "UPDATE tarif SET prix_total = ? WHERE id_avion = ? AND id_classe = ?";
                    try (PreparedStatement updatePstmt = conn.prepareStatement(updateSql)) {
                        updatePstmt.setDouble(1, prix);
                        updatePstmt.setInt(2, id_avion);
                        updatePstmt.setInt(3, id_classe);
                        updatePstmt.executeUpdate();
                    }
                } else {
                    // Créer un nouveau tarif
                    String insertSql = "INSERT INTO tarif (id_avion, id_classe, prix_total) VALUES (?, ?, ?)";
                    try (PreparedStatement insertPstmt = conn.prepareStatement(insertSql)) {
                        insertPstmt.setInt(1, id_avion);
                        insertPstmt.setInt(2, id_classe);
                        insertPstmt.setDouble(3, prix);
                        insertPstmt.executeUpdate();
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la sauvegarde du tarif : " + e.getMessage());
        }
    }

    /**
     * Récupère le tarif d'un avion pour une classe (utilisé par l'API)
     */
    public double getTarifAvion(int id_avion, int id_classe) {
        String sql = "SELECT prix_total as tarif FROM tarif WHERE id_avion = ? AND id_classe = ?";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id_avion);
            pstmt.setInt(2, id_classe);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("tarif");
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération du tarif avion : " + e.getMessage());
        }
        return 0;
    }

    /**
     * Récupère les informations de toutes les classes pour un vol planifié
     * Retourne une liste de Map contenant: id_classe, libelle, nb_sieges, tarif
     */
    public List<Map<String, Object>> getClassesInfos(int id_vol_fille) {
        List<Map<String, Object>> classesInfos = new ArrayList<>();
        String sql = "SELECT c.id as id_classe, c.libelle, "
                + "COUNT(s.id) as nb_sieges, "
                + "COALESCE(t.prix_total, 0) as tarif "
                + "FROM vol_fille vf "
                + "JOIN avion a ON a.id = vf.id_avion "
                + "JOIN siege s ON s.id_avion = a.id "
                + "JOIN classe c ON s.classe = c.libelle "
                + "LEFT JOIN tarif t ON t.id_vol_fille = vf.id AND t.id_classe = c.id "
                + "WHERE vf.id = ? "
                + "GROUP BY c.id, c.libelle, t.prix_total "
                + "ORDER BY c.id";

        try (Connection conn = DatabaseConnection.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id_vol_fille);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> classeInfo = new HashMap<>();
                    classeInfo.put("id_classe", rs.getInt("id_classe"));
                    classeInfo.put("libelle", rs.getString("libelle"));
                    classeInfo.put("nb_sieges", rs.getInt("nb_sieges"));
                    classeInfo.put("tarif", rs.getDouble("tarif"));
                    classesInfos.add(classeInfo);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des infos classes : " + e.getMessage());
            e.printStackTrace();
        }
        return classesInfos;
    }

    /**
     * Retourne le tarif (id + prix) pour un vol planifié et une classe donnés.
     * Utilise le tarif le plus récent (ORDER BY date_emission DESC LIMIT 1).
     */
    public TarifInfo findTarifByVolAndClasse(int idVolFille, int idClasse) {
        String sql = "SELECT id, prix_total FROM tarif WHERE id_vol_fille = ? AND id_classe = ? "
                + "ORDER BY date_emission DESC LIMIT 1";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idVolFille);
            pstmt.setInt(2, idClasse);

            System.out.println("DEBUG findTarifByVolAndClasse: vol=" + idVolFille + ", classe=" + idClasse);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    long id = rs.getLong("id");
                    double prix = rs.getDouble("prix_total");
                    System.out.println("DEBUG findTarifByVolAndClasse: Found tarif id=" + id + ", prix=" + prix);
                    return new TarifInfo(id, prix);
                }
                System.out.println("DEBUG findTarifByVolAndClasse: No tarif found");
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération du tarif : " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Vérifie s'il existe une remise pour un couple (tarif, type_passager).
     * Retourne le montant de la remise (nouveau prix) si trouvé, sinon null.
     */
    public Double findRemiseValue(long idTarif, long idTypePassager) {
        String sql = "SELECT newValue FROM remise WHERE id_tarif = ? AND id_type_passager = ? ORDER BY id DESC LIMIT 1";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, idTarif);
            pstmt.setLong(2, idTypePassager);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("newValue");
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération de la remise : " + e.getMessage());
        }
        return null;
    }

    /**
     * Retourne l'ID numérique d'une classe par son libellé.
     * Utilise LOWER() pour ignorer la casse et gérer les accents correctement.
     */
    public int findClasseIdByLibelle(String libelle) {
        String sql = "SELECT id FROM classe WHERE LOWER(libelle) = LOWER(?)";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, libelle);
            System.out.println("DEBUG findClasseIdByLibelle: SQL=" + sql + ", param='" + libelle + "'");
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int id = rs.getInt("id");
                    System.out.println("DEBUG findClasseIdByLibelle: Found id=" + id);
                    return id;
                }
                System.out.println("DEBUG findClasseIdByLibelle: No result found");
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération de l'ID classe : " + e.getMessage());
            e.printStackTrace();
        }
        return -1;
    }

    /**
     * Calcule le CA (Chiffre d'Affaires) réel généré par un vol planifié.
     * Prend en compte les remises appliquées sur les billets vendus.
     */
    public double calculateCAReel(int idVolFille) {
        String sql = "SELECT " +
            "  COALESCE(SUM(COALESCE(r.newValue, (CASE WHEN rp.pourcentage IS NOT NULL THEN t.prix_total * (rp.pourcentage / 100.0) ELSE t.prix_total END))), 0) as ca_total " +
            "FROM billet b " +
            "JOIN tarif t ON b.id_tarif = t.id " +
            "JOIN reservation_siege rs ON rs.id_billet = b.id " +
            "LEFT JOIN remise r ON r.id_tarif = t.id AND r.id_type_passager = b.id_type_passager " +
            "LEFT JOIN LATERAL (SELECT pourcentage FROM remisePourcentage rp WHERE rp.id_tarif = t.id AND rp.id_type_passager = b.id_type_passager ORDER BY rp.id DESC LIMIT 1) rp ON true " +
            "WHERE rs.id_vol_fille = ? " +
            "AND b.status IN ('EMIS', 'UTILISE')";

        try (Connection conn = DatabaseConnection.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idVolFille);
            
            System.out.println("DEBUG calculateCAReel: vol=" + idVolFille);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    double ca = rs.getDouble("ca_total");
                    System.out.println("DEBUG calculateCAReel: CA=" + ca);
                    return ca;
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors du calcul du CA : " + e.getMessage());
            e.printStackTrace();
        }
        return 0.0;
    }

    /**
     * Récupère le détail des billets vendus pour un vol (pour affichage CA détaillé)
     */
    public List<Map<String, Object>> getBilletsDetail(int idVolFille) {
        List<Map<String, Object>> billets = new ArrayList<>();
        String sql = "SELECT " +
            "  b.id, b.numero_billet, b.nom, b.prenom, " +
            "  tp.libelle as type_passager, " +
            "  c.libelle as classe, " +
            "  t.prix_total as tarif_base, " +
            "  COALESCE(r.newValue, (CASE WHEN rp.pourcentage IS NOT NULL THEN t.prix_total * (rp.pourcentage / 100.0) ELSE t.prix_total END)) as prix_applique, " +
            "  CASE WHEN r.newValue IS NOT NULL OR rp.pourcentage IS NOT NULL THEN true ELSE false END as remise_appliquee " +
            "FROM billet b " +
            "JOIN tarif t ON b.id_tarif = t.id " +
            "JOIN reservation_siege rs ON rs.id_billet = b.id " +
            "JOIN type_passager tp ON b.id_type_passager = tp.id " +
            "JOIN classe c ON t.id_classe = c.id " +
            "LEFT JOIN remise r ON r.id_tarif = t.id AND r.id_type_passager = b.id_type_passager " +
            "LEFT JOIN LATERAL (SELECT pourcentage FROM remisePourcentage rp WHERE rp.id_tarif = t.id AND rp.id_type_passager = b.id_type_passager ORDER BY rp.id DESC LIMIT 1) rp ON true " +
            "WHERE rs.id_vol_fille = ? " +
            "AND b.status IN ('EMIS', 'UTILISE') " +
            "ORDER BY b.id";

        try (Connection conn = DatabaseConnection.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idVolFille);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> billet = new HashMap<>();
                    billet.put("numero_billet", rs.getString("numero_billet"));
                    billet.put("passager", rs.getString("nom") + " " + rs.getString("prenom"));
                    billet.put("type_passager", rs.getString("type_passager"));
                    billet.put("classe", rs.getString("classe"));
                    billet.put("tarif_base", rs.getDouble("tarif_base"));
                    billet.put("prix_applique", rs.getDouble("prix_applique"));
                    billet.put("remise_appliquee", rs.getBoolean("remise_appliquee"));
                    billets.add(billet);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des billets : " + e.getMessage());
            e.printStackTrace();
        }
        return billets;
    }

    /**
     * DTO simple pour manipuler un tarif.
     */
    public static class TarifInfo {
        private final long id;
        private final double prix;

        public TarifInfo(long id, double prix) {
            this.id = id;
            this.prix = prix;
        }

        public long getId() {
            return id;
        }

        public double getPrix() {
            return prix;
        }
    }

    /**
     * DTO pour les remises en pourcentage
     */
    public static class RemisePourcentageInfo {
        private final long id;
        private final long idTarif;
        private final long idTypePassager;
        private final long idTypePassagerOrigine;
        private final int pourcentage;

        public RemisePourcentageInfo(long id, long idTarif, long idTypePassager, long idTypePassagerOrigine, int pourcentage) {
            this.id = id;
            this.idTarif = idTarif;
            this.idTypePassager = idTypePassager;
            this.idTypePassagerOrigine = idTypePassagerOrigine;
            this.pourcentage = pourcentage;
        }

        public long getId() { return id; }
        public long getIdTarif() { return idTarif; }
        public long getIdTypePassager() { return idTypePassager; }
        public long getIdTypePassagerOrigine() { return idTypePassagerOrigine; }
        public int getPourcentage() { return pourcentage; }
    }

    /**
     * Récupère toutes les remises en pourcentage associées à un tarif
     */
    public List<RemisePourcentageInfo> getRemisesPourTarif(long idTarif) {
        List<RemisePourcentageInfo> res = new ArrayList<>();
        String sql = "SELECT id, id_tarif, id_type_passager, id_type_passager_origine, pourcentage FROM remisePourcentage WHERE id_tarif = ? ORDER BY id";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, idTarif);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    res.add(new RemisePourcentageInfo(
                        rs.getLong("id"), rs.getLong("id_tarif"), rs.getLong("id_type_passager"), rs.getLong("id_type_passager_origine"), rs.getInt("pourcentage")
                    ));
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur getRemisesPourTarif: " + e.getMessage());
            e.printStackTrace();
        }
        return res;
    }

    /**
     * Récupère une remise en pourcentage (si existante) pour un couple (tarif, type_passager)
     */
    public RemisePourcentageInfo getRemisePourcentage(long idTarif, long idTypePassager) {
        String sql = "SELECT id, id_tarif, id_type_passager, id_type_passager_origine, pourcentage FROM remisePourcentage WHERE id_tarif = ? AND id_type_passager = ? ORDER BY id DESC LIMIT 1";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, idTarif);
            pstmt.setLong(2, idTypePassager);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new RemisePourcentageInfo(rs.getLong("id"), rs.getLong("id_tarif"), rs.getLong("id_type_passager"), rs.getLong("id_type_passager_origine"), rs.getInt("pourcentage"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur getRemisePourcentage: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Calcule le tarif basé sur une remise en pourcentage si elle existe.
     * Ici la logique appliquée: nouveau_prix = tarif_base * (pourcentage / 100.0)
     */
    public Double calculTarifPourcentage(long idTarif, long idTypePassager) {
        try {
            RemisePourcentageInfo rp = getRemisePourcentage(idTarif, idTypePassager);
            if (rp == null) return null;
            TarifInfo base = findTarifById(idTarif);
            if (base == null) return null;
            double nouveau = base.getPrix() * (rp.getPourcentage() / 100.0);
            System.out.println("DEBUG calculTarifPourcentage: idTarif=" + idTarif + ", type=" + idTypePassager + ", pourcentage=" + rp.getPourcentage() + ", nouveau=" + nouveau);
            return nouveau;
        } catch (Exception e) {
            System.err.println("Erreur calculTarifPourcentage: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Insère une remise en pourcentage
     */
    public boolean insertRemisePourcentage(long idTarif, long idTypePassager, long idTypePassagerOrigine, int pourcentage) {
        String sql = "INSERT INTO remisePourcentage (id_tarif, id_type_passager, id_type_passager_origine, pourcentage) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, idTarif);
            pstmt.setLong(2, idTypePassager);
            pstmt.setLong(3, idTypePassagerOrigine);
            pstmt.setInt(4, pourcentage);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Erreur insertRemisePourcentage: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Trouve un tarif par son id
     */
    public TarifInfo findTarifById(long idTarif) {
        String sql = "SELECT id, prix_total FROM tarif WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, idTarif);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new TarifInfo(rs.getLong("id"), rs.getDouble("prix_total"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur findTarifById: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
