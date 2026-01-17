package com.aero.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.aero.model.Aeroport;
import com.aero.util.DatabaseConnection;

/**
 * DAO pour la gestion des aéroports
 */
public class AeroportDAO {

    /**
     * Récupère tous les aéroports
     */
    public List<Aeroport> findAll() {
        List<Aeroport> aeroports = new ArrayList<>();
        String sql = "SELECT id_aeroport, code, nom, pays, ville FROM aeroport ORDER BY id_aeroport";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                aeroports.add(mapResultSetToAeroport(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des aéroports : " + e.getMessage());
        }
        return aeroports;
    }

    /**
     * Récupère un aéroport par son ID
     */
    public Aeroport findById(int id) {
        String sql = "SELECT id_aeroport, code, nom, pays, ville FROM aeroport WHERE id_aeroport = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToAeroport(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération de l'aéroport : " + e.getMessage());
        }
        return null;
    }

    /**
     * Crée un nouvel aéroport
     */
    public Aeroport create(Aeroport aeroport) {
        String sql = "INSERT INTO aeroport (code, nom, pays, ville) " +
                    "VALUES (?, ?, ?, ?) RETURNING id_aeroport";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, aeroport.getCode());
            pstmt.setString(2, aeroport.getNom());
            pstmt.setString(3, aeroport.getPays());
            pstmt.setString(4, aeroport.getVille());

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    aeroport.setId_aeroport(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la création de l'aéroport : " + e.getMessage());
        }
        return aeroport;
    }

    /**
     * Met à jour un aéroport
     */
    public boolean update(Aeroport aeroport) {
        String sql = "UPDATE aeroport SET code = ?, nom = ?, pays = ?, ville = ? WHERE id_aeroport = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, aeroport.getCode());
            pstmt.setString(2, aeroport.getNom());
            pstmt.setString(3, aeroport.getPays());
            pstmt.setString(4, aeroport.getVille());
            pstmt.setInt(5, aeroport.getId_aeroport());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour de l'aéroport : " + e.getMessage());
        }
        return false;
    }

    /**
     * Supprime un aéroport
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM aeroport WHERE id_aeroport = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression de l'aéroport : " + e.getMessage());
        }
        return false;
    }

    private Aeroport mapResultSetToAeroport(ResultSet rs) throws SQLException {
        return new Aeroport(
            rs.getInt("id_aeroport"),
            rs.getString("code"),
            rs.getString("nom"),
            rs.getString("pays"),
            rs.getString("ville")
        );
    }
}
