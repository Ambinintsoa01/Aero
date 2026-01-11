package com.aerocompagnie.model;

import com.aerocompagnie.config.DatabaseConfig;
import com.aerocompagnie.dao.GenericDAO;
import java.sql.*;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.List;

public class Employe {
    private int employe_id;
    private String nom;
    private String prenom;
    private int role;
    private String specialisation;
    private int heures_vol_mois;

    public boolean save(String table) {
        return GenericDAO.save(this, table);
    }

    public static List<Employe> findAll(String table) {
        return GenericDAO.findAll(Employe.class, table);
    }

    public List<String> getPlanning(int employeId) {
        List<String> planning = new ArrayList<>();
        String sql = "SELECT v.numero_vol, iv.date_depart_reelle, " +
                "sv.aeroport_depart, sv.aeroport_arrivee, " +
                "sv.heure_depart_UTC, sv.heure_arrivee_UTC " +
                "FROM Affectation_Equipage ae " +
                "JOIN Instances_Vols iv ON ae.instance_id = iv.instance_id " +
                "JOIN Segments_Vol sv ON iv.segment_id = sv.segment_id " +
                "JOIN Vols v ON sv.vol_id = v.vol_id " +
                "WHERE ae.employe_id = ? " +
                "ORDER BY iv.date_depart_reelle ASC, sv.ordre_segment ASC";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, employeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String volInfo = String.format("%s | %s | %s → %s (%s - %s)",
                            rs.getString("numero_vol"),
                            rs.getDate("date_depart_reelle"),
                            rs.getString("aeroport_depart"),
                            rs.getString("aeroport_arrivee"),
                            rs.getTime("heure_depart_UTC"),
                            rs.getTime("heure_arrivee_UTC"));
                    planning.add(volInfo);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return planning;
    }

    public int calculerHeuresVolMensuelles(int employeId, int mois) {
        String sql = "SELECT COALESCE(SUM(EXTRACT(HOUR FROM " +
                "(sv.heure_arrivee_UTC - sv.heure_depart_UTC))), 0) as heures_totales " +
                "FROM Affectation_Equipage ae " +
                "JOIN Instances_Vols iv ON ae.instance_id = iv.instance_id " +
                "JOIN Segments_Vol sv ON iv.segment_id = sv.segment_id " +
                "WHERE ae.employe_id = ? " +
                "AND EXTRACT(MONTH FROM iv.date_depart_reelle) = ? " +
                "AND EXTRACT(YEAR FROM iv.date_depart_reelle) = EXTRACT(YEAR FROM CURRENT_DATE)";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, employeId);
            ps.setInt(2, mois);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("heures_totales");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean estEligiblePourVol(int employeId, int instanceId) {
        // Vérifier 1: L'employé existe et est actif
        String sqlEmploye = "SELECT heures_vol_mois, specialisation, e.role FROM Employes e WHERE e.employe_id = ?";
        int heuresMax = 0;
        String specialisation = null;
        int roleEmploye = 0;

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement psEmploye = conn.prepareStatement(sqlEmploye)) {
            psEmploye.setInt(1, employeId);
            try (ResultSet rs = psEmploye.executeQuery()) {
                if (!rs.next()) {
                    return false; // Employé inexistant
                }
                heuresMax = rs.getInt("heures_vol_mois");
                specialisation = rs.getString("specialisation");
                roleEmploye = rs.getInt("role");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        // Vérifier 2: Pas de conflit horaire (chevauchement avec d'autres vols)
        String sqlConflit = "SELECT COUNT(*) FROM Affectation_Equipage ae " +
                "JOIN Instances_Vols iv ON ae.instance_id = iv.instance_id " +
                "JOIN Segments_Vol sv ON iv.segment_id = sv.segment_id " +
                "WHERE ae.employe_id = ? " +
                "AND EXISTS ( " +
                "  SELECT 1 FROM Instances_Vols iv2 " +
                "  JOIN Segments_Vol sv2 ON iv2.segment_id = sv2.segment_id " +
                "  WHERE iv2.instance_id = ? " +
                "  AND DATE(iv.date_depart_reelle) = DATE(iv2.date_depart_reelle) " +
                "  AND (sv2.heure_depart_UTC, sv2.heure_arrivee_UTC) OVERLAPS " +
                "       (sv.heure_depart_UTC, sv.heure_arrivee_UTC) " +
                ")";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement psConflit = conn.prepareStatement(sqlConflit)) {
            psConflit.setInt(1, employeId);
            psConflit.setInt(2, instanceId);
            try (ResultSet rs = psConflit.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    return false; // Conflit horaire détecté
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        // Vérifier 3: Pas de dépassement des heures mensuelles
        YearMonth currentMonth = YearMonth.now();
        int heuresActuelles = calculerHeuresVolMensuelles(employeId, currentMonth.getMonthValue());
        if (heuresActuelles >= heuresMax) {
            return false; // Quota atteint
        }

        return true;
    }

    public int getEmploye_id() {
        return employe_id;
    }

    public void setEmploye_id(int employe_id) {
        this.employe_id = employe_id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getSpecialisation() {
        return specialisation;
    }

    public void setSpecialisation(String specialisation) {
        this.specialisation = specialisation;
    }

    public int getHeures_vol_mois() {
        return heures_vol_mois;
    }

    public void setHeures_vol_mois(int heures_vol_mois) {
        this.heures_vol_mois = heures_vol_mois;
    }
}
