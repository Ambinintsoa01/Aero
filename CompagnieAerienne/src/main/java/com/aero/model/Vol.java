package com.aero.model;

/**
 * Classe représentant un vol (trajet) - Vol Mère
 * Définit simplement le trajet entre deux aéroports
 */
public class Vol {
    private int id;
    private String code_vol;
    private int id_aeroport_origine;
    private int id_aeroport_destination;
    private int id_type_vol;
    
    // Pour affichage
    private String aeroport_origine_code;
    private String aeroport_destination_code;
    private String type_vol_libelle;

    // Constructeurs
    public Vol() {}

    public Vol(String code_vol, int id_aeroport_origine, int id_aeroport_destination, int id_type_vol) {
        this.code_vol = code_vol;
        this.id_aeroport_origine = id_aeroport_origine;
        this.id_aeroport_destination = id_aeroport_destination;
        this.id_type_vol = id_type_vol;
    }

    public Vol(int id, String code_vol, int id_aeroport_origine, 
               int id_aeroport_destination, int id_type_vol) {
        this.id = id;
        this.code_vol = code_vol;
        this.id_aeroport_origine = id_aeroport_origine;
        this.id_aeroport_destination = id_aeroport_destination;
        this.id_type_vol = id_type_vol;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode_vol() {
        return code_vol;
    }

    public void setCode_vol(String code_vol) {
        this.code_vol = code_vol;
    }

    public int getId_aeroport_origine() {
        return id_aeroport_origine;
    }

    public void setId_aeroport_origine(int id_aeroport_origine) {
        this.id_aeroport_origine = id_aeroport_origine;
    }

    public int getId_aeroport_destination() {
        return id_aeroport_destination;
    }

    public void setId_aeroport_destination(int id_aeroport_destination) {
        this.id_aeroport_destination = id_aeroport_destination;
    }

    public int getId_type_vol() {
        return id_type_vol;
    }

    public void setId_type_vol(int id_type_vol) {
        this.id_type_vol = id_type_vol;
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

    public String getType_vol_libelle() {
        return type_vol_libelle;
    }

    public void setType_vol_libelle(String type_vol_libelle) {
        this.type_vol_libelle = type_vol_libelle;
    }

    @Override
    public String toString() {
        return "Vol{" +
                "id=" + id +
                ", code_vol='" + code_vol + '\'' +
                ", id_aeroport_origine=" + id_aeroport_origine +
                ", id_aeroport_destination=" + id_aeroport_destination +
                ", id_type_vol=" + id_type_vol +
                '}';
    }
}
