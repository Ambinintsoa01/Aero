package com.aerocompagnie.model;

import com.aerocompagnie.config.DatabaseConfig;
import com.aerocompagnie.dao.GenericDAO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Vol {
    private int vol_id;
    private String numero_vol;
    private String description;

    public boolean save(String table) {
        return GenericDAO.save(this, table);
    }

    public static List<Vol> findAll(String table) {
        return GenericDAO.findAll(Vol.class, table);
    }

    public List<SegmentVol> getItineraireComplet(int volId) {
        List<SegmentVol> segments = new ArrayList<>();
        String sql = "SELECT segment_id, vol_id, aeroport_depart, aeroport_arrivee, " +
                "ordre_segment, heure_depart_UTC, heure_arrivee_UTC, jour_de_semaine " +
                "FROM Segments_Vol " +
                "WHERE vol_id = ? " +
                "ORDER BY ordre_segment ASC";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, volId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SegmentVol seg = new SegmentVol();
                    seg.setSegment_id(rs.getInt("segment_id"));
                    seg.setVol_id(rs.getInt("vol_id"));
                    seg.setAeroport_depart(rs.getString("aeroport_depart"));
                    seg.setAeroport_arrivee(rs.getString("aeroport_arrivee"));
                    seg.setOrdre_segment(rs.getInt("ordre_segment"));
                    seg.setHeure_depart_UTC(rs.getTime("heure_depart_UTC").toLocalTime());
                    seg.setHeure_arrivee_UTC(rs.getTime("heure_arrivee_UTC").toLocalTime());
                    seg.setJour_de_semaine(rs.getInt("jour_de_semaine"));
                    segments.add(seg);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return segments;
    }

    public int getVol_id() {
        return vol_id;
    }

    public void setVol_id(int vol_id) {
        this.vol_id = vol_id;
    }

    public String getNumero_vol() {
        return numero_vol;
    }

    public void setNumero_vol(String numero_vol) {
        this.numero_vol = numero_vol;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
