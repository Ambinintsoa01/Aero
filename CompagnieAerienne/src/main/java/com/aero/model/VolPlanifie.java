package com.aero.model;

import java.time.LocalDateTime;

/**
 * Classe représentant une planification de vol - Vol Fille
 * Un même vol (Vol) peut avoir plusieurs planifications avec différents avions et dates
 */
public class VolPlanifie {
    private int id;
    private int id_vol_mere;
    private int id_avion;
    private LocalDateTime date_prev_depart;
    private LocalDateTime date_prev_arrivee;
    private LocalDateTime date_reelle_depart;
    private LocalDateTime date_reelle_arrivee;
    private String status;
    private LocalDateTime date_creation;
    private LocalDateTime date_modification;
    
    // Attributs supplémentaires pour affichage
    private String code_vol;
    private String immatriculation_avion;
    private int capacite_avion;
    private String aeroport_origine_code;
    private String aeroport_destination_code;

    // Constructeurs
    public VolPlanifie() {}

    public VolPlanifie(int id_vol_mere, int id_avion, 
                       LocalDateTime date_prev_depart, LocalDateTime date_prev_arrivee,
                       LocalDateTime date_reelle_depart, LocalDateTime date_reelle_arrivee,
                       String status, LocalDateTime date_creation, LocalDateTime date_modification) {
        this.id_vol_mere = id_vol_mere;
        this.id_avion = id_avion;
        this.date_prev_depart = date_prev_depart;
        this.date_prev_arrivee = date_prev_arrivee;
        this.date_reelle_depart = date_reelle_depart;
        this.date_reelle_arrivee = date_reelle_arrivee;
        this.status = status;
        this.date_creation = date_creation;
        this.date_modification = date_modification;
    }

    public VolPlanifie(int id, int id_vol_mere, int id_avion,
                       LocalDateTime date_prev_depart, LocalDateTime date_prev_arrivee,
                       LocalDateTime date_reelle_depart, LocalDateTime date_reelle_arrivee,
                       String status, LocalDateTime date_creation, LocalDateTime date_modification) {
        this.id = id;
        this.id_vol_mere = id_vol_mere;
        this.id_avion = id_avion;
        this.date_prev_depart = date_prev_depart;
        this.date_prev_arrivee = date_prev_arrivee;
        this.date_reelle_depart = date_reelle_depart;
        this.date_reelle_arrivee = date_reelle_arrivee;
        this.status = status;
        this.date_creation = date_creation;
        this.date_modification = date_modification;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_vol_mere() {
        return id_vol_mere;
    }

    public void setId_vol_mere(int id_vol_mere) {
        this.id_vol_mere = id_vol_mere;
    }

    public int getId_avion() {
        return id_avion;
    }

    public void setId_avion(int id_avion) {
        this.id_avion = id_avion;
    }

    public LocalDateTime getDate_prev_depart() {
        return date_prev_depart;
    }

    public void setDate_prev_depart(LocalDateTime date_prev_depart) {
        this.date_prev_depart = date_prev_depart;
    }

    public LocalDateTime getDate_prev_arrivee() {
        return date_prev_arrivee;
    }

    public void setDate_prev_arrivee(LocalDateTime date_prev_arrivee) {
        this.date_prev_arrivee = date_prev_arrivee;
    }

    public LocalDateTime getDate_reelle_depart() {
        return date_reelle_depart;
    }

    public void setDate_reelle_depart(LocalDateTime date_reelle_depart) {
        this.date_reelle_depart = date_reelle_depart;
    }

    public LocalDateTime getDate_reelle_arrivee() {
        return date_reelle_arrivee;
    }

    public void setDate_reelle_arrivee(LocalDateTime date_reelle_arrivee) {
        this.date_reelle_arrivee = date_reelle_arrivee;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getDate_creation() {
        return date_creation;
    }

    public void setDate_creation(LocalDateTime date_creation) {
        this.date_creation = date_creation;
    }

    public LocalDateTime getDate_modification() {
        return date_modification;
    }

    public void setDate_modification(LocalDateTime date_modification) {
        this.date_modification = date_modification;
    }

    public String getCode_vol() {
        return code_vol;
    }

    public void setCode_vol(String code_vol) {
        this.code_vol = code_vol;
    }

    public String getImmatriculation_avion() {
        return immatriculation_avion;
    }

    public void setImmatriculation_avion(String immatriculation_avion) {
        this.immatriculation_avion = immatriculation_avion;
    }

    public int getCapacite_avion() {
        return capacite_avion;
    }

    public void setCapacite_avion(int capacite_avion) {
        this.capacite_avion = capacite_avion;
    }

    public String getAeroport_origine_code() {
        return aeroport_origine_code;
    }

    public void setAeroport_origine_code(String aeroport_origine_code) {
        this.aeroport_origine_code = aeroport_origine_code;
    }

    public String getAeroport_destination_code() {
        return aeroport_destination_code;
    }

    public void setAeroport_destination_code(String aeroport_destination_code) {
        this.aeroport_destination_code = aeroport_destination_code;
    }

    @Override
    public String toString() {
        return "VolPlanifie{" +
                "id=" + id +
                ", id_vol_mere=" + id_vol_mere +
                ", id_avion=" + id_avion +
                ", date_prev_depart=" + date_prev_depart +
                ", status='" + status + '\'' +
                '}';
    }
}
