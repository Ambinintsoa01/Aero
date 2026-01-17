package com.aero.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.aero.model.Vol;
import com.aero.util.DatabaseConnection;

/**
 * DAO pour la gestion des vols (Vol Mère)
 */
public class VolDAO {

    /**
     * Récupère tous les vols
     */
    public List<Vol> findAll() {
        List<Vol> vols = new ArrayList<>();
        String sql = "SELECT v.id, v.code_vol, v.id_aeroport_origine, v.id_aeroport_destination, " +
                    "v.id_type_vol, ao.code as origine_code, ad.code as destination_code, tv.libelle as type " +
                    "FROM vol_mere v " +
                    "LEFT JOIN aeroport ao ON v.id_aeroport_origine = ao.id_aeroport " +
                    "LEFT JOIN aeroport ad ON v.id_aeroport_destination = ad.id_aeroport " +
                    "LEFT JOIN type_vol tv ON v.id_type_vol = tv.id " +
                    "ORDER BY v.id";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Vol vol = mapResultSetToVol(rs);
                vols.add(vol);
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des vols : " + e.getMessage());
        }
        return vols;
    }

    /**
     * Récupère un vol par son ID
     */
    public Vol findById(int id) {
        String sql = "SELECT v.id, v.code_vol, v.id_aeroport_origine, v.id_aeroport_destination, " +
                    "v.id_type_vol, ao.code as origine_code, ad.code as destination_code, tv.libelle as type " +
                    "FROM vol_mere v " +
                    "LEFT JOIN aeroport ao ON v.id_aeroport_origine = ao.id_aeroport " +
                    "LEFT JOIN aeroport ad ON v.id_aeroport_destination = ad.id_aeroport " +
                    "LEFT JOIN type_vol tv ON v.id_type_vol = tv.id " +
                    "WHERE v.id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToVol(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération du vol : " + e.getMessage());
        }
        return null;
    }

    /**
     * Crée un nouveau vol
     */
    public Vol create(Vol vol) {
        String sql = "INSERT INTO vol_mere (code_vol, id_aeroport_origine, " +
                    "id_aeroport_destination, id_type_vol) VALUES (?, ?, ?, ?) RETURNING id";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, vol.getCode_vol());
            pstmt.setInt(2, vol.getId_aeroport_origine());
            pstmt.setInt(3, vol.getId_aeroport_destination());
            pstmt.setInt(4, vol.getId_type_vol());

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    vol.setId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la création du vol : " + e.getMessage());
        }
        return vol;
    }

    /**
     * Met à jour un vol
     */
    public boolean update(Vol vol) {
        String sql = "UPDATE vol_mere SET code_vol = ?, id_aeroport_origine = ?, " +
                    "id_aeroport_destination = ?, id_type_vol = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, vol.getCode_vol());
            pstmt.setInt(2, vol.getId_aeroport_origine());
            pstmt.setInt(3, vol.getId_aeroport_destination());
            pstmt.setInt(4, vol.getId_type_vol());
            pstmt.setInt(5, vol.getId());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour du vol : " + e.getMessage());
        }
        return false;
    }

    /**
     * Supprime un vol
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM vol_mere WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression du vol : " + e.getMessage());
        }
        return false;
    }

    private Vol mapResultSetToVol(ResultSet rs) throws SQLException {
        Vol vol = new Vol(
            rs.getInt("id"),
            rs.getString("code_vol"),
            rs.getInt("id_aeroport_origine"),
            rs.getInt("id_aeroport_destination"),
            rs.getInt("id_type_vol")
        );
        vol.setAeroport_origine_code(rs.getString("origine_code"));
        vol.setAeroport_destination_code(rs.getString("destination_code"));
        vol.setType_vol_libelle(rs.getString("type"));
        return vol;
    }
}
