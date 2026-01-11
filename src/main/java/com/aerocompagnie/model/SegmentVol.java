package com.aerocompagnie.model;

import com.aerocompagnie.dao.GenericDAO;
import java.time.Duration;
import java.time.LocalTime;

public class SegmentVol {
    private int segment_id;
    private int vol_id;
    private String aeroport_depart;
    private String aeroport_arrivee;
    private int ordre_segment;
    private LocalTime heure_depart_UTC;
    private LocalTime heure_arrivee_UTC;
    private Integer jour_de_semaine;

    public boolean save(String table) {
        return GenericDAO.save(this, table);
    }

    public Duration calculerDureeEstimee() {
        if (heure_depart_UTC == null || heure_arrivee_UTC == null) {
            return Duration.ZERO;
        }
        Duration d = Duration.between(heure_depart_UTC, heure_arrivee_UTC);
        if (d.isNegative()) {
            d = d.plusHours(24); // gestion simple d'un passage de minuit
        }
        return d;
    }

    public int getSegment_id() {
        return segment_id;
    }

    public void setSegment_id(int segment_id) {
        this.segment_id = segment_id;
    }

    public int getVol_id() {
        return vol_id;
    }

    public void setVol_id(int vol_id) {
        this.vol_id = vol_id;
    }

    public String getAeroport_depart() {
        return aeroport_depart;
    }

    public void setAeroport_depart(String aeroport_depart) {
        this.aeroport_depart = aeroport_depart;
    }

    public String getAeroport_arrivee() {
        return aeroport_arrivee;
    }

    public void setAeroport_arrivee(String aeroport_arrivee) {
        this.aeroport_arrivee = aeroport_arrivee;
    }

    public int getOrdre_segment() {
        return ordre_segment;
    }

    public void setOrdre_segment(int ordre_segment) {
        this.ordre_segment = ordre_segment;
    }

    public LocalTime getHeure_depart_UTC() {
        return heure_depart_UTC;
    }

    public void setHeure_depart_UTC(LocalTime heure_depart_UTC) {
        this.heure_depart_UTC = heure_depart_UTC;
    }

    public LocalTime getHeure_arrivee_UTC() {
        return heure_arrivee_UTC;
    }

    public void setHeure_arrivee_UTC(LocalTime heure_arrivee_UTC) {
        this.heure_arrivee_UTC = heure_arrivee_UTC;
    }

    public Integer getJour_de_semaine() {
        return jour_de_semaine;
    }

    public void setJour_de_semaine(Integer jour_de_semaine) {
        this.jour_de_semaine = jour_de_semaine;
    }
}
