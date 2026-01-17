package com.aero.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.aero.model.Siege;
import com.aero.util.DatabaseConnection;

/**
 * DAO pour la gestion des sièges
 */
public class SiegeDAO {

    /**
     * Récupère les sièges disponibles pour un vol et une classe
     */
    public List<Siege> getSiegesDisponibles(int idVolFille, String classe) {
        List<Siege> sieges = new ArrayList<>();
        String sql = "SELECT s.id, s.id_avion, s.numero_siege, s.classe " +
                    "FROM siege s " +
                    "WHERE s.classe = ? " +
                    "AND s.id_avion = (SELECT id_avion FROM vol_fille WHERE id = ?) " +
                    "AND s.id NOT IN (SELECT id_siege FROM reservation_siege WHERE id_vol_fille = ?) " +
                    "ORDER BY s.numero_siege";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, classe);
            pstmt.setInt(2, idVolFille);
            pstmt.setInt(3, idVolFille);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Siege siege = new Siege(
                        rs.getLong("id"),
                        rs.getInt("id_avion"),
                        rs.getString("numero_siege"),
                        rs.getString("classe")
                    );
                    sieges.add(siege);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des sièges disponibles : " + e.getMessage());
        }
        return sieges;
    }

    /**
     * Récupère tous les sièges d'une classe pour un avion
     */
    public List<Siege> getSiegesByAvionAndClasse(int idAvion, String classe) {
        List<Siege> sieges = new ArrayList<>();
        String sql = "SELECT id, id_avion, numero_siege, classe " +
                    "FROM siege " +
                    "WHERE id_avion = ? AND classe = ? " +
                    "ORDER BY numero_siege";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idAvion);
            pstmt.setString(2, classe);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Siege siege = new Siege(
                        rs.getLong("id"),
                        rs.getInt("id_avion"),
                        rs.getString("numero_siege"),
                        rs.getString("classe")
                    );
                    sieges.add(siege);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des sièges : " + e.getMessage());
        }
        return sieges;
    }

    /**
     * Compte les sièges disponibles pour une classe et un vol
     */
    public int countSiegesDisponibles(int idVolFille, String classe) {
        String sql = "SELECT COUNT(*) as count " +
                    "FROM siege s " +
                    "WHERE s.classe = ? " +
                    "AND s.id_avion = (SELECT id_avion FROM vol_fille WHERE id = ?) " +
                    "AND s.id NOT IN (SELECT id_siege FROM reservation_siege WHERE id_vol_fille = ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, classe);
            pstmt.setInt(2, idVolFille);
            pstmt.setInt(3, idVolFille);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count");
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors du comptage des sièges : " + e.getMessage());
        }
        return 0;
    }

    /**
     * Récupère un siège par son ID
     */
    public Siege findById(long id) {
        String sql = "SELECT id, id_avion, numero_siege, classe FROM siege WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Siege(
                        rs.getLong("id"),
                        rs.getInt("id_avion"),
                        rs.getString("numero_siege"),
                        rs.getString("classe")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération du siège : " + e.getMessage());
        }
        return null;
    }

    /**
     * Ajoute une réservation de siège pour un billet et un vol
     */
    public boolean addReservationSiege(long idBillet, long idSiege, int idVolFille) {
        String sql = "INSERT INTO reservation_siege (id_billet, id_siege, id_vol_fille, date_reservation) " +
                    "VALUES (?, ?, ?, CURRENT_TIMESTAMP)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, idBillet);
            pstmt.setLong(2, idSiege);
            pstmt.setInt(3, idVolFille);

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("DEBUG: Réservation siège créée - Billet:" + idBillet + ", Siège:" + idSiege + ", Vol:" + idVolFille);
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'ajout de la réservation siège : " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Récupère TOUS les sièges d'un vol (peu importe le statut de réservation)
     * Utilisé pour extraire toutes les classes disponibles
     */
    public List<Siege> findByIdVolPlanifie(int idVolPlanifie) {
        List<Siege> sieges = new ArrayList<>();
        String sql = "SELECT DISTINCT s.id, s.id_avion, s.numero_siege, s.classe " +
                    "FROM siege s " +
                    "WHERE s.id_avion = (SELECT id_avion FROM vol_fille WHERE id = ?) " +
                    "ORDER BY s.classe, s.numero_siege";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idVolPlanifie);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Siege siege = new Siege(
                        rs.getLong("id"),
                        rs.getInt("id_avion"),
                        rs.getString("numero_siege"),
                        rs.getString("classe")
                    );
                    sieges.add(siege);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des sièges du vol : " + e.getMessage());
        }
        return sieges;
    }

    /**
     * Récupère TOUS les sièges d'un vol avec le statut de disponibilité
     * Utilisé pour l'affichage de la grille de sièges
     */
    public List<Siege> findByIdVolPlanifieWithStatus(int idVolPlanifie) {
        List<Siege> sieges = new ArrayList<>();
        String sql = "SELECT s.id, s.id_avion, s.numero_siege, s.classe, " +
                    "CASE WHEN rs.id_siege IS NOT NULL THEN 0 ELSE 1 END as disponible " +
                    "FROM siege s " +
                    "LEFT JOIN reservation_siege rs ON s.id = rs.id_siege AND rs.id_vol_fille = ? " +
                    "WHERE s.id_avion = (SELECT id_avion FROM vol_fille WHERE id = ?) " +
                    "ORDER BY s.numero_siege";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idVolPlanifie);
            pstmt.setInt(2, idVolPlanifie);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Siege siege = new Siege(
                        rs.getLong("id"),
                        rs.getInt("id_avion"),
                        rs.getString("numero_siege"),
                        rs.getString("classe")
                    );
                    siege.setDisponible(rs.getInt("disponible") == 1);
                    sieges.add(siege);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des sièges avec statut : " + e.getMessage());
        }
        return sieges;
    }
}
