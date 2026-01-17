package com.aero.model;

import java.time.LocalDate;

/**
 * Classe représentant un billet de réservation
 */
public class Billet {
    private long id;
    private String numero_billet;
    private long id_tarif;
    private long id_type_passager;
    private String nom;
    private String prenom;
    private LocalDate date_naissance;
    private String nationalite;
    private String numero_passport;
    private String email;
    private String telephone;
    private LocalDate date_emission;
    private String status;

    // Constructeurs
    public Billet() {}

    public Billet(String numero_billet, long id_tarif, long id_type_passager,
                  String nom, String prenom, LocalDate date_naissance,
                  String nationalite, String numero_passport, String email,
                  String telephone, LocalDate date_emission, String status) {
        this.numero_billet = numero_billet;
        this.id_tarif = id_tarif;
        this.id_type_passager = id_type_passager;
        this.nom = nom;
        this.prenom = prenom;
        this.date_naissance = date_naissance;
        this.nationalite = nationalite;
        this.numero_passport = numero_passport;
        this.email = email;
        this.telephone = telephone;
        this.date_emission = date_emission;
        this.status = status;
    }

    // Getters et Setters
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getNumero_billet() {
        return numero_billet;
    }

    public void setNumero_billet(String numero_billet) {
        this.numero_billet = numero_billet;
    }

    public long getId_tarif() {
        return id_tarif;
    }

    public void setId_tarif(long id_tarif) {
        this.id_tarif = id_tarif;
    }

    public long getId_type_passager() {
        return id_type_passager;
    }

    public void setId_type_passager(long id_type_passager) {
        this.id_type_passager = id_type_passager;
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

    public LocalDate getDate_naissance() {
        return date_naissance;
    }

    public void setDate_naissance(LocalDate date_naissance) {
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

    public LocalDate getDate_emission() {
        return date_emission;
    }

    public void setDate_emission(LocalDate date_emission) {
        this.date_emission = date_emission;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Billet{" +
                "id=" + id +
                ", numero_billet='" + numero_billet + '\'' +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
