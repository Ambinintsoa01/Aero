package com.aero.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.aero.model.Billet;
import com.aero.util.DatabaseConnection;

/**
 * DAO pour la gestion des billets et réservations
 */
public class BilletDAO {

    /**
     * Récupère tous les billets
     */
    public List<Billet> findAll() {
        List<Billet> billets = new ArrayList<>();
        String sql = "SELECT id, numero_billet, id_tarif, id_type_passager, nom, prenom, " +
                    "date_naissance, nationalite, numero_passport, email, telephone, " +
                    "date_emission, status FROM billet ORDER BY id DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                billets.add(mapResultSetToBillet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des billets : " + e.getMessage());
        }
        return billets;
    }

    /**
     * Récupère un billet par son ID
     */
    public Billet findById(long id) {
        String sql = "SELECT id, numero_billet, id_tarif, id_type_passager, nom, prenom, " +
                    "date_naissance, nationalite, numero_passport, email, telephone, " +
                    "date_emission, status FROM billet WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBillet(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération du billet : " + e.getMessage());
        }
        return null;
    }

    /**
     * Crée un nouveau billet - Réservation
     * RÈGLE MÉTIER : Vérification que la capacité n'est pas dépassée
     */
    public Billet create(Billet billet) throws SQLException {
        // Si numero_passport est null, on ne l'insère pas (sera auto-généré par la DB)
        String sql;
        if (billet.getNumero_passport() == null || billet.getNumero_passport().isEmpty()) {
            sql = "INSERT INTO billet (numero_billet, id_tarif, id_type_passager, " +
                  "nom, prenom, date_naissance, nationalite, email, " +
                  "telephone, date_emission, status) " +
                  "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING id, numero_passport";
        } else {
            sql = "INSERT INTO billet (numero_billet, id_tarif, id_type_passager, " +
                  "nom, prenom, date_naissance, nationalite, numero_passport, email, " +
                  "telephone, date_emission, status) " +
                  "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING id, numero_passport";
        }

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            int paramIndex = 1;
            pstmt.setString(paramIndex++, billet.getNumero_billet());
            pstmt.setLong(paramIndex++, billet.getId_tarif());
            pstmt.setLong(paramIndex++, billet.getId_type_passager());
            pstmt.setString(paramIndex++, billet.getNom());
            pstmt.setString(paramIndex++, billet.getPrenom());
            pstmt.setDate(paramIndex++, java.sql.Date.valueOf(billet.getDate_naissance()));
            pstmt.setString(paramIndex++, billet.getNationalite());
            
            // N'insérer numero_passport que s'il n'est pas null
            if (billet.getNumero_passport() != null && !billet.getNumero_passport().isEmpty()) {
                pstmt.setString(paramIndex++, billet.getNumero_passport());
            }
            
            pstmt.setString(paramIndex++, billet.getEmail());
            pstmt.setString(paramIndex++, billet.getTelephone());
            pstmt.setDate(paramIndex++, java.sql.Date.valueOf(billet.getDate_emission()));
            pstmt.setString(paramIndex++, billet.getStatus());

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    long newId = rs.getLong("id");
                    String generatedPassport = rs.getString("numero_passport");
                    billet.setId(newId);
                    billet.setNumero_passport(generatedPassport);
                    System.out.println("DEBUG: Billet créé avec succès - ID: " + newId + ", Passeport: " + generatedPassport);
                    return billet;
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la création du billet : " + e.getMessage());
            throw e; // Relancer l'exception pour que le servlet la gère
        }
        return null;
    }

    /**
     * Met à jour le statut d'un billet
     */
    public boolean updateStatus(long id, String newStatus) {
        String sql = "UPDATE billet SET status = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, newStatus);
            pstmt.setLong(2, id);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour du billet : " + e.getMessage());
        }
        return false;
    }

    /**
     * Récupère les billets pour un vol planifié spécifique
     */
    public List<Billet> findByVolPlanifie(int idVolPlanifie) {
        List<Billet> billets = new ArrayList<>();
        String sql = "SELECT b.id, b.numero_billet, b.id_tarif, b.id_type_passager, b.nom, " +
                    "b.prenom, b.date_naissance, b.nationalite, b.numero_passport, b.email, " +
                    "b.telephone, b.date_emission, b.status " +
                    "FROM billet b " +
                    "INNER JOIN tarif t ON b.id_tarif = t.id " +
                    "WHERE t.id_vol_fille = ? ORDER BY b.id DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idVolPlanifie);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    billets.add(mapResultSetToBillet(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des billets : " + e.getMessage());
        }
        return billets;
    }

    /**
     * Compte le nombre de billets actifs pour un vol planifié
     * RÈGLE MÉTIER : Utilisée pour vérifier la capacité disponible
     */
    public int countBilletsForVolPlanifie(int idVolPlanifie) {
        String sql = "SELECT COUNT(*) as nombre FROM billet b " +
                    "INNER JOIN tarif t ON b.id_tarif = t.id " +
                    "WHERE t.id_vol_fille = ? AND b.status IN ('EMIS', 'UTILISE')";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idVolPlanifie);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("nombre");
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors du comptage des billets : " + e.getMessage());
        }
        return 0;
    }

    private Billet mapResultSetToBillet(ResultSet rs) throws SQLException {
        Billet billet = new Billet(
            rs.getString("numero_billet"),
            rs.getLong("id_tarif"),
            rs.getLong("id_type_passager"),
            rs.getString("nom"),
            rs.getString("prenom"),
            rs.getDate("date_naissance").toLocalDate(),
            rs.getString("nationalite"),
            rs.getString("numero_passport"),
            rs.getString("email"),
            rs.getString("telephone"),
            rs.getDate("date_emission").toLocalDate(),
            rs.getString("status")
        );
        billet.setId(rs.getLong("id"));
        return billet;
    }
}
