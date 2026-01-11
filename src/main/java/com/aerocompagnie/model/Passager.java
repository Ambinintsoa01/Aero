package com.aerocompagnie.model;

import com.aerocompagnie.config.DatabaseConfig;
import com.aerocompagnie.dao.GenericDAO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Passager {
    private int passager_id;
    private String nom;
    private String prenom;
    private String num_passeport;
    private String email;

    public boolean save(String table) {
        return GenericDAO.save(this, table);
    }

    public static List<Passager> findAll(String table) {
        return GenericDAO.findAll(Passager.class, table);
    }

    public List<InstanceVol> getHistoriqueVoyages(int passagerId) {
        List<InstanceVol> voyages = new ArrayList<>();
        String sql = "SELECT DISTINCT iv.instance_id, iv.segment_id, iv.avion_id, " +
                "iv.date_depart_reelle, iv.etat_vol, iv.prix_base " +
                "FROM Reservations r " +
                "JOIN Detail_Reservation dr ON r.reservation_id = dr.reservation_id " +
                "JOIN Instances_Vols iv ON dr.instance_id = iv.instance_id " +
                "WHERE r.passager_id = ? " +
                "ORDER BY iv.date_depart_reelle DESC";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, passagerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    InstanceVol iv = new InstanceVol();
                    iv.setInstance_id(rs.getInt("instance_id"));
                    iv.setSegment_id(rs.getInt("segment_id"));
                    iv.setAvion_id(rs.getInt("avion_id"));
                    iv.setDate_depart_reelle(rs.getDate("date_depart_reelle").toLocalDate());
                    iv.setEtat_vol(rs.getInt("etat_vol"));
                    iv.setPrix_base(rs.getBigDecimal("prix_base"));
                    voyages.add(iv);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return voyages;
    }

    public int getPassager_id() {
        return passager_id;
    }

    public void setPassager_id(int passager_id) {
        this.passager_id = passager_id;
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

    public String getNum_passeport() {
        return num_passeport;
    }

    public void setNum_passeport(String num_passeport) {
        this.num_passeport = num_passeport;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
