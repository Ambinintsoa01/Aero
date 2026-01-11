package com.aerocompagnie.model;

import com.aerocompagnie.config.DatabaseConfig;
import com.aerocompagnie.dao.GenericDAO;
import java.sql.*;
import java.time.LocalDate;
import java.util.List;

public class Avion {
    private int avion_id;
    private String immatriculation;
    private String modele;
    private int capacite_eco;
    private int capacite_business;
    private LocalDate date_dernier_entretien;
    private int statut;

    public boolean save(String table) {
        return GenericDAO.save(this, table);
    }

    public boolean update(String table, String idColumn) {
        return GenericDAO.update(this, table, idColumn);
    }

    public static List<Avion> findAll(String table) {
        return GenericDAO.findAll(Avion.class, table);
    }

    public double getMoyenneRemplissage(int avionId) {
        String sql = "SELECT " +
                "AVG(CASE WHEN total_capacite > 0 " +
                "    THEN CAST(COALESCE(passagers_count, 0) AS FLOAT) / total_capacite " +
                "    ELSE 0 END) as moyenne " +
                "FROM ( " +
                "  SELECT iv.instance_id, " +
                "         a.capacite_eco + a.capacite_business as total_capacite, " +
                "         COALESCE(COUNT(dr.instance_id), 0) as passagers_count " +
                "  FROM Instances_Vols iv " +
                "  JOIN Avions a ON iv.avion_id = a.avion_id " +
                "  LEFT JOIN Detail_Reservation dr ON iv.instance_id = dr.instance_id " +
                "  WHERE a.avion_id = ? " +
                "    AND EXTRACT(YEAR FROM iv.date_depart_reelle) = EXTRACT(YEAR FROM CURRENT_DATE) " +
                "  GROUP BY iv.instance_id, a.capacite_eco, a.capacite_business " +
                ") subquery";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, avionId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    double moyenne = rs.getDouble("moyenne");
                    return Double.isNaN(moyenne) ? 0.0 : moyenne;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public boolean estDisponiblePourDate(int avionId, LocalDate date) {
        // Vérifier 1: L'avion est-il en maintenance ou AOG ?
        String sqlStatut = "SELECT COUNT(*) FROM Avions a " +
                "JOIN Statut_Avion sa ON a.statut = sa.statut_id " +
                "WHERE a.avion_id = ? AND sa.statut_nom IN ('Maintenance', 'AOG')";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement psStatut = conn.prepareStatement(sqlStatut)) {
            psStatut.setInt(1, avionId);
            try (ResultSet rs = psStatut.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    return false; // L'avion est en maintenance
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        // Vérifier 2: L'avion est-il déjà réservé pour cette date ?
        String sqlVol = "SELECT COUNT(*) FROM Instances_Vols iv " +
                "WHERE iv.avion_id = ? AND DATE(iv.date_depart_reelle) = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement psVol = conn.prepareStatement(sqlVol)) {
            psVol.setInt(1, avionId);
            psVol.setDate(2, java.sql.Date.valueOf(date));
            try (ResultSet rs = psVol.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0; // Disponible si aucun vol
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    public int getAvion_id() {
        return avion_id;
    }

    public void setAvion_id(int avion_id) {
        this.avion_id = avion_id;
    }

    public String getImmatriculation() {
        return immatriculation;
    }

    public void setImmatriculation(String immatriculation) {
        this.immatriculation = immatriculation;
    }

    public String getModele() {
        return modele;
    }

    public void setModele(String modele) {
        this.modele = modele;
    }

    public int getCapacite_eco() {
        return capacite_eco;
    }

    public void setCapacite_eco(int capacite_eco) {
        this.capacite_eco = capacite_eco;
    }

    public int getCapacite_business() {
        return capacite_business;
    }

    public void setCapacite_business(int capacite_business) {
        this.capacite_business = capacite_business;
    }

    public LocalDate getDate_dernier_entretien() {
        return date_dernier_entretien;
    }

    public void setDate_dernier_entretien(LocalDate date_dernier_entretien) {
        this.date_dernier_entretien = date_dernier_entretien;
    }

    public int getStatut() {
        return statut;
    }

    public void setStatut(int statut) {
        this.statut = statut;
    }
}
