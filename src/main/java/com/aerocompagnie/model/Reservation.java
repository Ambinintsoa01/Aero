package com.aerocompagnie.model;

import com.aerocompagnie.config.DatabaseConfig;
import com.aerocompagnie.dao.GenericDAO;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

public class Reservation {
    private int reservation_id;
    private String pnr;
    private int passager_id;
    private LocalDateTime date_reservation;
    private String statut_paiement;

    public boolean save(String table) {
        return GenericDAO.save(this, table);
    }

    public static List<Reservation> findAll(String table) {
        return GenericDAO.findAll(Reservation.class, table);
    }

    public String creerReservation(int passagerId, List<Integer> instanceIds) {

        // Générer un PNR unique (6 caractères alphanumériques)
        String pnr = genererPNR();
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            conn.setAutoCommit(false);

            // Vérifier la disponibilité des sièges pour chaque instance
            for (int instanceId : instanceIds) {
                String sqlCapacite = "SELECT (a.capacite_eco + a.capacite_business) as total_capacite, " +
                        "COALESCE(COUNT(dr.instance_id), 0) as sieges_occupes " +
                        "FROM Instances_Vols iv " +
                        "JOIN Avions a ON iv.avion_id = a.avion_id " +
                        "LEFT JOIN Detail_Reservation dr ON iv.instance_id = dr.instance_id " +
                        "WHERE iv.instance_id = ? " +
                        "GROUP BY a.capacite_eco, a.capacite_business";

                try (PreparedStatement psCapacite = conn.prepareStatement(sqlCapacite)) {
                    psCapacite.setInt(1, instanceId);
                    try (ResultSet rs = psCapacite.executeQuery()) {
                        if (rs.next()) {
                            int totalCapacite = rs.getInt("total_capacite");
                            int siegesOccupes = rs.getInt("sieges_occupes");
                            if (siegesOccupes >= totalCapacite) {
                                conn.rollback();
                                return null; // Pas de sièges disponibles
                            }
                        }
                    }
                }
            }

            // Insérer la réservation
            String sqlReservation = "INSERT INTO Reservations (pnr, passager_id, date_reservation, statut_paiement) " +
                     "VALUES (?, ?, CURRENT_TIMESTAMP, 'En attente') RETURNING reservation_id";
            
            int reservationId = 0;
            try (PreparedStatement psReservation = conn.prepareStatement(sqlReservation)) {
                psReservation.setString(1, pnr);
                psReservation.setInt(2, passagerId);
                try (ResultSet rs = psReservation.executeQuery()) {
                    if (rs.next()) {
                        reservationId = rs.getInt("reservation_id");
                    }
                }
            }

            if (reservationId == 0) {
                conn.rollback();
                return null;
            }

            // Insérer les détails de réservation (affectation aux instances) - siège non assigné pour l'instant
            String sqlDetail = "INSERT INTO Detail_Reservation (reservation_id, instance_id, classe) VALUES (?, ?, 1)";

            for (int instanceId : instanceIds) {
                try (PreparedStatement psDetail = conn.prepareStatement(sqlDetail)) {
                    psDetail.setInt(1, reservationId);
                    psDetail.setInt(2, instanceId);
                    psDetail.executeUpdate();
                }
            }

            conn.commit();
            return pnr;

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

     public String creerReservationComplet(int passagerId, List<Integer> instanceIds, LocalDateTime date_reservation, int classe, String siege_assigne) {

        // Générer un PNR unique (6 caractères alphanumériques)
        String pnr = genererPNR();
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            conn.setAutoCommit(false);

            // Vérifier la disponibilité des sièges pour chaque instance
            for (int instanceId : instanceIds) {
                String sqlCapacite = "SELECT (a.capacite_eco + a.capacite_business) as total_capacite, " +
                        "COALESCE(COUNT(dr.instance_id), 0) as sieges_occupes " +
                        "FROM Instances_Vols iv " +
                        "JOIN Avions a ON iv.avion_id = a.avion_id " +
                        "LEFT JOIN Detail_Reservation dr ON iv.instance_id = dr.instance_id " +
                        "WHERE iv.instance_id = ? " +
                        "GROUP BY a.capacite_eco, a.capacite_business";

                try (PreparedStatement psCapacite = conn.prepareStatement(sqlCapacite)) {
                    psCapacite.setInt(1, instanceId);
                    try (ResultSet rs = psCapacite.executeQuery()) {
                        if (rs.next()) {
                            int totalCapacite = rs.getInt("total_capacite");
                            int siegesOccupes = rs.getInt("sieges_occupes");
                            if (siegesOccupes >= totalCapacite) {
                                conn.rollback();
                                return null; // Pas de sièges disponibles
                            }
                        }
                    }
                }
            }

            // Insérer la réservation
            String sqlReservation = "INSERT INTO Reservations (pnr, passager_id, date_reservation, statut_paiement) " +
                //     "VALUES (?, ?, CURRENT_TIMESTAMP, 'En attente') RETURNING reservation_id";
                        "VALUES (?, ?, ?, 'Payé') RETURNING reservation_id";
            
            int reservationId = 0;
            try (PreparedStatement psReservation = conn.prepareStatement(sqlReservation)) {
                psReservation.setString(1, pnr);
                psReservation.setInt(2, passagerId);
                psReservation.setTimestamp(3, Timestamp.valueOf(date_reservation));
                try (ResultSet rs = psReservation.executeQuery()) {
                    if (rs.next()) {
                        reservationId = rs.getInt("reservation_id");
                    }
                }
            }

            if (reservationId == 0) {
                conn.rollback();
                return null;
            }

            // Insérer les détails de réservation (affectation aux instances) - siège non assigné pour l'instant
            //String sqlDetail = "INSERT INTO Detail_Reservation (reservation_id, instance_id, classe) VALUES (?, ?, 1)";
            String sqlDetail = "INSERT INTO Detail_Reservation (reservation_id, instance_id, classe, siege_assigne) VALUES (?, ?, ?, ?)";

            for (int instanceId : instanceIds) {
                try (PreparedStatement psDetail = conn.prepareStatement(sqlDetail)) {
                    psDetail.setInt(1, reservationId);
                    psDetail.setInt(2, instanceId);
                    psDetail.setInt(3, classe);
                    psDetail.setString(4, siege_assigne);
                    psDetail.executeUpdate();
                }
            }

            conn.commit();
            return pnr;

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean genererBilletPDF(int reservationId) {
        Map<String, Object> donneesPDF = new HashMap<>();
        
        String sql = "SELECT p.nom, p.prenom, p.num_passeport, p.email, " +
                "r.pnr, r.date_reservation, r.statut_paiement, " +
                "v.numero_vol, sv.aeroport_depart, sv.aeroport_arrivee, " +
                "sv.heure_depart_UTC, sv.heure_arrivee_UTC, " +
                "iv.date_depart_reelle, iv.prix_base, " +
                "dr.siege_assigne, cr.class_name " +
                "FROM Reservations r " +
                "JOIN Passagers p ON r.passager_id = p.passager_id " +
                "JOIN Detail_Reservation dr ON r.reservation_id = dr.reservation_id " +
                "JOIN Instances_Vols iv ON dr.instance_id = iv.instance_id " +
                "JOIN Segments_Vol sv ON iv.segment_id = sv.segment_id " +
                "JOIN Vols v ON sv.vol_id = v.vol_id " +
                "JOIN Class_Reservation cr ON dr.classe = cr.class_id " +
                "WHERE r.reservation_id = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, reservationId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Construire les données pour le PDF
                    donneesPDF.put("passager_nom", rs.getString("nom"));
                    donneesPDF.put("passager_prenom", rs.getString("prenom"));
                    donneesPDF.put("passager_passeport", rs.getString("num_passeport"));
                    donneesPDF.put("pnr", rs.getString("pnr"));
                    donneesPDF.put("numero_vol", rs.getString("numero_vol"));
                    donneesPDF.put("depart", rs.getString("aeroport_depart"));
                    donneesPDF.put("arrivee", rs.getString("aeroport_arrivee"));
                    donneesPDF.put("heure_depart", rs.getTime("heure_depart_UTC"));
                    donneesPDF.put("heure_arrivee", rs.getTime("heure_arrivee_UTC"));
                    donneesPDF.put("date_vol", rs.getDate("date_depart_reelle"));
                    donneesPDF.put("siege", rs.getString("siege_assigne"));
                    donneesPDF.put("classe", rs.getString("class_name"));
                    donneesPDF.put("prix", rs.getBigDecimal("prix_base"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        // Vérifier que les données sont complètes
        return !donneesPDF.isEmpty() && 
               donneesPDF.containsKey("passager_nom") &&
               donneesPDF.containsKey("pnr");
    }



    public boolean annulerReservation(String tableName, String idColumnName) {
        // Marque la réservation comme annulée
        this.statut_paiement = "Annulé";
        return GenericDAO.update(this, tableName, idColumnName);
    }

    private static String genererPNR() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder pnr = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < 6; i++) {
            pnr.append(chars.charAt(random.nextInt(chars.length())));
        }
        return pnr.toString();
    }

    public int getReservation_id() {
        return reservation_id;
    }

    public void setReservation_id(int reservation_id) {
        this.reservation_id = reservation_id;
    }

    public String getPnr() {
        return pnr;
    }

    public void setPnr(String pnr) {
        this.pnr = pnr;
    }

    public int getPassager_id() {
        return passager_id;
    }

    public void setPassager_id(int passager_id) {
        this.passager_id = passager_id;
    }

    public LocalDateTime getDate_reservation() {
        return date_reservation;
    }

    public void setDate_reservation(LocalDateTime date_reservation) {
        this.date_reservation = date_reservation;
    }

    public String getStatut_paiement() {
        return statut_paiement;
    }

    public void setStatut_paiement(String statut_paiement) {
        this.statut_paiement = statut_paiement;
    }
}
