package com.aero.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.aero.model.Avion;
import com.aero.util.DatabaseConnection;

/**
 * DAO pour la gestion des avions
 * Data Access Object pour les opérations CRUD sur les avions
 */
public class AvionDAO {

    /**
     * Récupère tous les avions
     * @return liste de tous les avions
     */
    public List<Avion> findAll() {
        List<Avion> avions = new ArrayList<>();
        String sql = "SELECT id, immatriculation, modele, constructeur, capacite, " +
                    "annee_fabrication, date_mise_service FROM avion ORDER BY id";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                avions.add(mapResultSetToAvion(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des avions : " + e.getMessage());
        }
        return avions;
    }

    /**
     * Récupère un avion par son ID
     * @param id l'ID de l'avion
     * @return l'avion ou null si non trouvé
     */
    public Avion findById(int id) {
        String sql = "SELECT id, immatriculation, modele, constructeur, capacite, " +
                    "annee_fabrication, date_mise_service FROM avion WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToAvion(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération de l'avion : " + e.getMessage());
        }
        return null;
    }

    /**
     * Crée un nouvel avion
     * @param avion l'avion à créer
     * @return l'avion créé avec son ID généré
     */
    public Avion create(Avion avion) {
        String sql = "INSERT INTO avion (immatriculation, modele, constructeur, capacite, " +
                    "annee_fabrication, date_mise_service) " +
                    "VALUES (?, ?, ?, ?, ?, ?) RETURNING id";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, avion.getImmatriculation());
            pstmt.setString(2, avion.getModele());
            pstmt.setString(3, avion.getConstructeur());
            pstmt.setInt(4, avion.getCapacite());
            pstmt.setInt(5, avion.getAnnee_fabrication());
            pstmt.setDate(6, java.sql.Date.valueOf(avion.getDate_mise_service()));

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    avion.setId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la création de l'avion : " + e.getMessage());
        }
        return avion;
    }

    /**
     * Met à jour un avion
     * @param avion l'avion à mettre à jour
     * @return true si succès, false sinon
     */
    public boolean update(Avion avion) {
        String sql = "UPDATE avion SET immatriculation = ?, modele = ?, constructeur = ?, " +
                    "capacite = ?, annee_fabrication = ?, date_mise_service = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, avion.getImmatriculation());
            pstmt.setString(2, avion.getModele());
            pstmt.setString(3, avion.getConstructeur());
            pstmt.setInt(4, avion.getCapacite());
            pstmt.setInt(5, avion.getAnnee_fabrication());
            pstmt.setDate(6, java.sql.Date.valueOf(avion.getDate_mise_service()));
            pstmt.setInt(7, avion.getId());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour de l'avion : " + e.getMessage());
        }
        return false;
    }

    /**
     * Supprime un avion
     * @param id l'ID de l'avion à supprimer
     * @return true si succès, false sinon
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM avion WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression de l'avion : " + e.getMessage());
        }
        return false;
    }

    /**
     * Vérifie la capacité disponible d'un avion pour un vol planifié
     * @param idVolPlanifie l'ID du vol planifié
     * @return le nombre de places disponibles
     */
    public int getPlacesDisponibles(int idVolPlanifie) {
        String sql = "SELECT COUNT(*) as nombre_billets FROM billet b " +
                    "INNER JOIN tarif t ON b.id_tarif = t.id " +
                    "WHERE t.id_vol_fille = ? AND b.status IN ('EMIS', 'UTILISE')";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // D'abord récupérer la capacité de l'avion
            String sqlCapacite = "SELECT a.capacite FROM avion a " +
                                "INNER JOIN vol_fille vf ON a.id = vf.id_avion " +
                                "WHERE vf.id = ?";
            
            int capacite = 0;
            int billets = 0;

            try (PreparedStatement pstmt2 = conn.prepareStatement(sqlCapacite)) {
                pstmt2.setInt(1, idVolPlanifie);
                try (ResultSet rs = pstmt2.executeQuery()) {
                    if (rs.next()) {
                        capacite = rs.getInt("capacite");
                    }
                }
            }

            pstmt.setInt(1, idVolPlanifie);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    billets = rs.getInt("nombre_billets");
                }
            }

            return capacite - billets;
        } catch (SQLException e) {
            System.err.println("Erreur lors de la vérification de la capacité : " + e.getMessage());
        }
        return -1;
    }

    /**
     * Compte le nombre de sièges par classe pour un avion donné
     * @param idAvion l'ID de l'avion
     * @return un tableau [0]=première classe, [1]=économique
     */
    public int[] countSiegesByClasse(int idAvion) {
        int[] counts = new int[2]; // [0]=première, [1]=économique
        String sql = "SELECT classe, COUNT(*) as nb FROM siege WHERE id_avion = ? GROUP BY classe";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, idAvion);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    String classe = rs.getString("classe");
                    int nb = rs.getInt("nb");
                    if ("PREMIERE".equalsIgnoreCase(classe) || "PREMIÈRE".equalsIgnoreCase(classe)) {
                        counts[0] = nb;
                    } else if ("ECONOMIQUE".equalsIgnoreCase(classe) || "ÉCONOMIQUE".equalsIgnoreCase(classe)) {
                        counts[1] = nb;
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors du comptage des sièges : " + e.getMessage());
        }
        return counts;
    }

    /**
     * Calcule le revenu maximal qu'un avion peut générer pour un vol
     * Tarifs de référence: Première classe = 1 200 000 Ar, Économique = 700 000 Ar
     * @param idAvion l'ID de l'avion
     * @return le revenu maximal en Ariary
     */
    public long calculateRevenuMaximal(int idAvion) {
        int[] sieges = countSiegesByClasse(idAvion);
        long tarifPremiere = 1200000; // Ar
        long tarifEconomique = 700000; // Ar
        
        return (sieges[0] * tarifPremiere) + (sieges[1] * tarifEconomique);
    }

    /**
     * Mappe un ResultSet vers un objet Avion
     * @param rs le ResultSet
     * @return l'objet Avion
     * @throws SQLException en cas d'erreur
     */
    private Avion mapResultSetToAvion(ResultSet rs) throws SQLException {
        return new Avion(
            rs.getInt("id"),
            rs.getString("immatriculation"),
            rs.getString("modele"),
            rs.getString("constructeur"),
            rs.getInt("capacite"),
            rs.getInt("annee_fabrication"),
            rs.getDate("date_mise_service").toLocalDate()
        );
    }
}
