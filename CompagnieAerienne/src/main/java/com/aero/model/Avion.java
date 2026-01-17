package com.aero.model;

import java.time.LocalDate;

/**
 * Classe représentant un avion de la compagnie aérienne
 */
public class Avion {
    private int id;
    private String immatriculation;
    private String modele;
    private String constructeur;
    private int capacite;
    private int annee_fabrication;
    private LocalDate date_mise_service;

    // Constructeurs
    public Avion() {}

    public Avion(String immatriculation, String modele, String constructeur, 
                 int capacite, int annee_fabrication, LocalDate date_mise_service) {
        this.immatriculation = immatriculation;
        this.modele = modele;
        this.constructeur = constructeur;
        this.capacite = capacite;
        this.annee_fabrication = annee_fabrication;
        this.date_mise_service = date_mise_service;
    }

    public Avion(int id, String immatriculation, String modele, String constructeur, 
                 int capacite, int annee_fabrication, LocalDate date_mise_service) {
        this.id = id;
        this.immatriculation = immatriculation;
        this.modele = modele;
        this.constructeur = constructeur;
        this.capacite = capacite;
        this.annee_fabrication = annee_fabrication;
        this.date_mise_service = date_mise_service;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImmatriculation() {
        return immatriculation;
    }

    public void setImmatriculation(String immatriculation) {
        this.immatriculation = immatriculation;
    }

    public String getModele() {
        return modele;
    }

    public void setModele(String modele) {
        this.modele = modele;
    }

    public String getConstructeur() {
        return constructeur;
    }

    public void setConstructeur(String constructeur) {
        this.constructeur = constructeur;
    }

    public int getCapacite() {
        return capacite;
    }

    public void setCapacite(int capacite) {
        this.capacite = capacite;
    }

    public int getAnnee_fabrication() {
        return annee_fabrication;
    }

    public void setAnnee_fabrication(int annee_fabrication) {
        this.annee_fabrication = annee_fabrication;
    }

    public LocalDate getDate_mise_service() {
        return date_mise_service;
    }

    public void setDate_mise_service(LocalDate date_mise_service) {
        this.date_mise_service = date_mise_service;
    }

    @Override
    public String toString() {
        return "Avion{" +
                "id=" + id +
                ", immatriculation='" + immatriculation + '\'' +
                ", modele='" + modele + '\'' +
                ", constructeur='" + constructeur + '\'' +
                ", capacite=" + capacite +
                ", annee_fabrication=" + annee_fabrication +
                ", date_mise_service=" + date_mise_service +
                '}';
    }
}
