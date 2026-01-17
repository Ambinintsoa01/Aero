package com.aero.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Modèle pour les détails complets d'une réservation
 * Combine les informations du billet, du vol, du siège et du tarif
 */
public class DetailReservation {
    private long idBillet;
    private String numeroBillet;
    private String nom;
    private String prenom;
    private LocalDate dateNaissance;
    private String nationalite;
    private String numeroPassport;
    private String email;
    private String telephone;
    private LocalDateTime dateEmission;
    private String billetStatus;
    
    // Informations du vol
    private String codeVol;
    private int idVolFille;
    private LocalDateTime dateReelleDepart;
    private LocalDateTime dateReelleArrivee;
    private String volStatus;
    
    // Informations de l'avion
    private String immatriculation;
    private String modele;
    
    // Informations du siège
    private String numeroSiege;
    private String classe;
    
    // Informations du tarif
    private double prixTotal;
    private String deviseCode;
    private String deviseSynnbole;
    
    // Constructeur complet
    public DetailReservation(long idBillet, String numeroBillet, String nom, String prenom,
                            LocalDate dateNaissance, String nationalite, String numeroPassport,
                            String email, String telephone, LocalDateTime dateEmission, String billetStatus,
                            String codeVol, int idVolFille, LocalDateTime dateReelleDepart, LocalDateTime dateReelleArrivee,
                            String volStatus, String immatriculation, String modele, String numeroSiege, String classe,
                            double prixTotal, String deviseCode, String deviseSynnbole) {
        this.idBillet = idBillet;
        this.numeroBillet = numeroBillet;
        this.nom = nom;
        this.prenom = prenom;
        this.dateNaissance = dateNaissance;
        this.nationalite = nationalite;
        this.numeroPassport = numeroPassport;
        this.email = email;
        this.telephone = telephone;
        this.dateEmission = dateEmission;
        this.billetStatus = billetStatus;
        this.codeVol = codeVol;
        this.idVolFille = idVolFille;
        this.dateReelleDepart = dateReelleDepart;
        this.dateReelleArrivee = dateReelleArrivee;
        this.volStatus = volStatus;
        this.immatriculation = immatriculation;
        this.modele = modele;
        this.numeroSiege = numeroSiege;
        this.classe = classe;
        this.prixTotal = prixTotal;
        this.deviseCode = deviseCode;
        this.deviseSynnbole = deviseSynnbole;
    }
    
    // Constructeur vide
    public DetailReservation() {}
    
    // Getters et Setters
    public long getIdBillet() {
        return idBillet;
    }
    
    public void setIdBillet(long idBillet) {
        this.idBillet = idBillet;
    }
    
    public String getNumeroBillet() {
        return numeroBillet;
    }
    
    public void setNumeroBillet(String numeroBillet) {
        this.numeroBillet = numeroBillet;
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
    
    public LocalDate getDateNaissance() {
        return dateNaissance;
    }
    
    public void setDateNaissance(LocalDate dateNaissance) {
        this.dateNaissance = dateNaissance;
    }
    
    public String getNationalite() {
        return nationalite;
    }
    
    public void setNationalite(String nationalite) {
        this.nationalite = nationalite;
    }
    
    public String getNumeroPassport() {
        return numeroPassport;
    }
    
    public void setNumeroPassport(String numeroPassport) {
        this.numeroPassport = numeroPassport;
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
    
    public LocalDateTime getDateEmission() {
        return dateEmission;
    }
    
    public void setDateEmission(LocalDateTime dateEmission) {
        this.dateEmission = dateEmission;
    }
    
    public String getBilletStatus() {
        return billetStatus;
    }
    
    public void setBilletStatus(String billetStatus) {
        this.billetStatus = billetStatus;
    }
    
    public String getCodeVol() {
        return codeVol;
    }
    
    public void setCodeVol(String codeVol) {
        this.codeVol = codeVol;
    }
    
    public int getIdVolFille() {
        return idVolFille;
    }
    
    public void setIdVolFille(int idVolFille) {
        this.idVolFille = idVolFille;
    }
    
    public LocalDateTime getDateReelleDepart() {
        return dateReelleDepart;
    }
    
    public void setDateReelleDepart(LocalDateTime dateReelleDepart) {
        this.dateReelleDepart = dateReelleDepart;
    }
    
    public LocalDateTime getDateReelleArrivee() {
        return dateReelleArrivee;
    }
    
    public void setDateReelleArrivee(LocalDateTime dateReelleArrivee) {
        this.dateReelleArrivee = dateReelleArrivee;
    }
    
    public String getVolStatus() {
        return volStatus;
    }
    
    public void setVolStatus(String volStatus) {
        this.volStatus = volStatus;
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
    
    public String getNumeroSiege() {
        return numeroSiege;
    }
    
    public void setNumeroSiege(String numeroSiege) {
        this.numeroSiege = numeroSiege;
    }
    
    public String getClasse() {
        return classe;
    }
    
    public void setClasse(String classe) {
        this.classe = classe;
    }
    
    public double getPrixTotal() {
        return prixTotal;
    }
    
    public void setPrixTotal(double prixTotal) {
        this.prixTotal = prixTotal;
    }
    
    public String getDeviseCode() {
        return deviseCode;
    }
    
    public void setDeviseCode(String deviseCode) {
        this.deviseCode = deviseCode;
    }
    
    public String getDeviseSynnbole() {
        return deviseSynnbole;
    }
    
    public void setDeviseSynnbole(String deviseSynnbole) {
        this.deviseSynnbole = deviseSynnbole;
    }
    
    @Override
    public String toString() {
        return "DetailReservation{" +
                "numeroBillet='" + numeroBillet + '\'' +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                ", codeVol='" + codeVol + '\'' +
                ", numeroSiege='" + numeroSiege + '\'' +
                ", classe='" + classe + '\'' +
                ", prixTotal=" + prixTotal +
                ", deviseCode='" + deviseCode + '\'' +
                '}';
    }
}
