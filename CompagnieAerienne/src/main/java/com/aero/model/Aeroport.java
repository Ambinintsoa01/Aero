package com.aero.model;

/**
 * Classe représentant un aéroport
 */
public class Aeroport {
    private int id_aeroport;
    private String code;
    private String nom;
    private String pays;
    private String ville;

    // Constructeurs
    public Aeroport() {}

    public Aeroport(String code, String nom, String pays, String ville) {
        this.code = code;
        this.nom = nom;
        this.pays = pays;
        this.ville = ville;
    }

    public Aeroport(int id_aeroport, String code, String nom, String pays, String ville) {
        this.id_aeroport = id_aeroport;
        this.code = code;
        this.nom = nom;
        this.pays = pays;
        this.ville = ville;
    }

    // Getters et Setters
    public int getId_aeroport() {
        return id_aeroport;
    }

    public void setId_aeroport(int id_aeroport) {
        this.id_aeroport = id_aeroport;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPays() {
        return pays;
    }

    public void setPays(String pays) {
        this.pays = pays;
    }

    public String getVille() {
        return ville;
    }

    public void setVille(String ville) {
        this.ville = ville;
    }

    @Override
    public String toString() {
        return "Aeroport{" +
                "id_aeroport=" + id_aeroport +
                ", code='" + code + '\'' +
                ", nom='" + nom + '\'' +
                ", pays='" + pays + '\'' +
                ", ville='" + ville + '\'' +
                '}';
    }
}
