package com.aero.model;

/**
 * Classe représentant un passager
 */
public class Passager {
    private long id;
    private String nom;
    private String prenom;
    private String date_naissance;
    private String nationalite;
    private String numero_passport;
    private String email;
    private String telephone;
    private long id_type_passager;

    // Constructeurs
    public Passager() {}

    public Passager(String nom, String prenom, String date_naissance,
                    String nationalite, String numero_passport, String email,
                    String telephone, long id_type_passager) {
        this.nom = nom;
        this.prenom = prenom;
        this.date_naissance = date_naissance;
        this.nationalite = nationalite;
        this.numero_passport = numero_passport;
        this.email = email;
        this.telephone = telephone;
        this.id_type_passager = id_type_passager;
    }

    // Getters et Setters
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
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

    public String getDate_naissance() {
        return date_naissance;
    }

    public void setDate_naissance(String date_naissance) {
        this.date_naissance = date_naissance;
    }

    public String getNationalite() {
        return nationalite;
    }

    public void setNationalite(String nationalite) {
        this.nationalite = nationalite;
    }

    public String getNumero_passport() {
        return numero_passport;
    }

    public void setNumero_passport(String numero_passport) {
        this.numero_passport = numero_passport;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public long getId_type_passager() {
        return id_type_passager;
    }

    public void setId_type_passager(long id_type_passager) {
        this.id_type_passager = id_type_passager;
    }

    @Override
    public String toString() {
        return "Passager{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}
