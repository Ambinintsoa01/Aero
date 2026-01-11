package com.aerocompagnie.model;

import com.aerocompagnie.config.DatabaseConfig;
import com.aerocompagnie.dao.GenericDAO;
import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class InstanceVol {
    private int instance_id;
    private int segment_id;
    private int avion_id;
    private LocalDate date_depart_reelle;
    private int etat_vol;
    private BigDecimal prix_base;

    public boolean save(String table) {
        return GenericDAO.save(this, table);
    }

    public boolean assignerAvion(int instanceId, int avionId, String table, String idColumn) {
        this.instance_id = instanceId;
        this.avion_id = avionId;
        return GenericDAO.update(this, table, idColumn);
    }

    public static List<InstanceVol> findAll(String table) {
        return GenericDAO.findAll(InstanceVol.class, table);
    }

    public List<Passager> getPassagersABord(int instanceId) {
        List<Passager> passagers = new ArrayList<>();
        String sql = "SELECT DISTINCT p.passager_id, p.nom, p.prenom, p.num_passeport, p.email " +
                "FROM Passagers p " +
                "JOIN Reservations r ON p.passager_id = r.passager_id " +
                "JOIN Detail_Reservation dr ON r.reservation_id = dr.reservation_id " +
                "WHERE dr.instance_id = ? " +
                "ORDER BY p.nom, p.prenom";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, instanceId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Passager p = new Passager();
                    p.setPassager_id(rs.getInt("passager_id"));
                    p.setNom(rs.getString("nom"));
                    p.setPrenom(rs.getString("prenom"));
                    p.setNum_passeport(rs.getString("num_passeport"));
                    p.setEmail(rs.getString("email"));
                    passagers.add(p);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return passagers;
    }

    public SeatInfo getSeatInfo(int instanceId, int avionId) {
        String sql = "SELECT " +
                "a.capacite_eco, a.capacite_business, " +
                "COALESCE(SUM(CASE WHEN cr.class_name = 'Eco' THEN 1 ELSE 0 END), 0) as eco_reserved, " +
                "COALESCE(SUM(CASE WHEN cr.class_name = 'Business' THEN 1 ELSE 0 END), 0) as business_reserved " +
                "FROM Avions a " +
                "LEFT JOIN Instances_Vols iv ON iv.avion_id = a.avion_id " +
                "LEFT JOIN Detail_Reservation dr ON iv.instance_id = dr.instance_id " +
                "LEFT JOIN Class_Reservation cr ON dr.classe = cr.class_id " +
                "WHERE a.avion_id = ? AND iv.instance_id = ? " +
                "GROUP BY a.capacite_eco, a.capacite_business";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, avionId);
            ps.setInt(2, instanceId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int totalEco = rs.getInt("capacite_eco");
                    int totalBusiness = rs.getInt("capacite_business");
                    int ecoReserved = rs.getInt("eco_reserved");
                    int businessReserved = rs.getInt("business_reserved");
                    return new SeatInfo(totalEco, ecoReserved, totalBusiness, businessReserved);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getInstance_id() {
        return instance_id;
    }

    public void setInstance_id(int instance_id) {
        this.instance_id = instance_id;
    }

    public int getSegment_id() {
        return segment_id;
    }

    public void setSegment_id(int segment_id) {
        this.segment_id = segment_id;
    }

    public int getAvion_id() {
        return avion_id;
    }

    public void setAvion_id(int avion_id) {
        this.avion_id = avion_id;
    }

    public LocalDate getDate_depart_reelle() {
        return date_depart_reelle;
    }

    public void setDate_depart_reelle(LocalDate date_depart_reelle) {
        this.date_depart_reelle = date_depart_reelle;
    }

    public int getEtat_vol() {
        return etat_vol;
    }

    public void setEtat_vol(int etat_vol) {
        this.etat_vol = etat_vol;
    }

    public BigDecimal getPrix_base() {
        return prix_base;
    }

    public void setPrix_base(BigDecimal prix_base) {
        this.prix_base = prix_base;
    }
}
