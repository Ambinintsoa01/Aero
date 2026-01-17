package com.aero.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.aero.model.DetailReservation;
import com.aero.util.DatabaseConnection;

/**
 * DAO pour accéder aux détails des réservations via la vue v_detail_reservation
 */
public class DetailReservationDAO {

    /**
     * Récupère tous les détails de réservation
     */
    public List<DetailReservation> findAll() {
        List<DetailReservation> reservations = new ArrayList<>();
        String sql = "SELECT * FROM v_detail_reservation";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                DetailReservation detail = mapResultSetToDetailReservation(rs);
                reservations.add(detail);
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des réservations : " + e.getMessage());
        }
        return reservations;
    }

    /**
     * Récupère les détails d'une réservation par l'ID du billet
     */
    public DetailReservation findByIdBillet(long idBillet) {
        String sql = "SELECT * FROM v_detail_reservation WHERE id_billet = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, idBillet);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToDetailReservation(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération du détail de réservation : " + e.getMessage());
        }
        return null;
    }

    /**
     * Récupère les détails de réservation par numéro de billet
     */
    public DetailReservation findByNumeroBillet(String numeroBillet) {
        String sql = "SELECT * FROM v_detail_reservation WHERE numero_billet = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, numeroBillet);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToDetailReservation(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la recherche du billet : " + e.getMessage());
        }
        return null;
    }

    /**
     * Récupère toutes les réservations d'un passager par passeport
     */
    public List<DetailReservation> findByNumeroPassport(String numeroPassport) {
        List<DetailReservation> reservations = new ArrayList<>();
        String sql = "SELECT * FROM v_detail_reservation WHERE numero_passport = ? ORDER BY date_emission DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, numeroPassport);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    DetailReservation detail = mapResultSetToDetailReservation(rs);
                    reservations.add(detail);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la recherche des réservations : " + e.getMessage());
        }
        return reservations;
    }

    /**
     * Récupère toutes les réservations avec un certain statut
     */
    public List<DetailReservation> findByStatus(String status) {
        List<DetailReservation> reservations = new ArrayList<>();
        String sql = "SELECT * FROM v_detail_reservation WHERE billet_status = ? ORDER BY date_emission DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, status);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    DetailReservation detail = mapResultSetToDetailReservation(rs);
                    reservations.add(detail);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la recherche par statut : " + e.getMessage());
        }
        return reservations;
    }

    /**
     * Compte le nombre total de réservations
     */
    public long countTotal() {
        String sql = "SELECT COUNT(*) as total FROM v_detail_reservation";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getLong("total");
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors du comptage des réservations : " + e.getMessage());
        }
        return 0;
    }

    /**
     * Met à jour le statut d'un billet
     */
    public void updateBilletStatus(long idBillet, String newStatus) throws SQLException {
        String sql = "UPDATE billet SET status = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, newStatus);
            pstmt.setLong(2, idBillet);
            
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Aucun billet trouvé avec l'ID: " + idBillet);
            }
        }
    }

    /**
     * Mappe un ResultSet à un objet DetailReservation
     */
    private DetailReservation mapResultSetToDetailReservation(ResultSet rs) throws SQLException {
        return new DetailReservation(
            rs.getLong("id_billet"),
            rs.getString("numero_billet"),
            rs.getString("nom"),
            rs.getString("prenom"),
            rs.getDate("date_naissance").toLocalDate(),
            rs.getString("nationalite"),
            rs.getString("numero_passport"),
            rs.getString("email"),
            rs.getString("telephone"),
            rs.getTimestamp("date_emission").toLocalDateTime(),
            rs.getString("billet_status"),
            rs.getString("code_vol"),
            rs.getInt("id_vol_fille"),
            rs.getTimestamp("date_reelle_depart").toLocalDateTime(),
            rs.getTimestamp("date_reelle_arrivee").toLocalDateTime(),
            rs.getString("vol_status"),
            rs.getString("immatriculation"),
            rs.getString("modele"),
            rs.getString("numero_siege"),
            rs.getString("classe"),
            rs.getDouble("prix_total"),
            rs.getString("devise_code"),
            rs.getString("devise_symbole")
        );
    }
}
