package com.aerocompagnie.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;

public class VolDisponibleDTO {
    private int instanceId;
    private String numeroVol;
    private String aeroportDepart;
    private String aeroportArrivee;
    private LocalDate dateDepart;
    private LocalTime heureDepart;
    private LocalTime heureArrivee;
    private String avionImmat;
    private String avionModele;
    private int placesEco;
    private int placesBusiness;
    private BigDecimal prix;

    public VolDisponibleDTO() {}

    public VolDisponibleDTO(int instanceId, String numeroVol, String aeroportDepart, String aeroportArrivee,
                            LocalDate dateDepart, LocalTime heureDepart, LocalTime heureArrivee,
                            String avionImmat, String avionModele, int placesEco, int placesBusiness,
                            BigDecimal prix) {
        this.instanceId = instanceId;
        this.numeroVol = numeroVol;
        this.aeroportDepart = aeroportDepart;
        this.aeroportArrivee = aeroportArrivee;
        this.dateDepart = dateDepart;
        this.heureDepart = heureDepart;
        this.heureArrivee = heureArrivee;
        this.avionImmat = avionImmat;
        this.avionModele = avionModele;
        this.placesEco = placesEco;
        this.placesBusiness = placesBusiness;
        this.prix = prix;
    }

    public int getInstanceId() {
        return instanceId;
    }

    public void setInstanceId(int instanceId) {
        this.instanceId = instanceId;
    }

    public String getNumeroVol() {
        return numeroVol;
    }

    public void setNumeroVol(String numeroVol) {
        this.numeroVol = numeroVol;
    }

    public String getAeroportDepart() {
        return aeroportDepart;
    }

    public void setAeroportDepart(String aeroportDepart) {
        this.aeroportDepart = aeroportDepart;
    }

    public String getAeroportArrivee() {
        return aeroportArrivee;
    }

    public void setAeroportArrivee(String aeroportArrivee) {
        this.aeroportArrivee = aeroportArrivee;
    }

    public LocalDate getDateDepart() {
        return dateDepart;
    }

    public void setDateDepart(LocalDate dateDepart) {
        this.dateDepart = dateDepart;
    }

    public LocalTime getHeureDepart() {
        return heureDepart;
    }

    public void setHeureDepart(LocalTime heureDepart) {
        this.heureDepart = heureDepart;
    }

    public LocalTime getHeureArrivee() {
        return heureArrivee;
    }

    public void setHeureArrivee(LocalTime heureArrivee) {
        this.heureArrivee = heureArrivee;
    }

    public String getAvionImmat() {
        return avionImmat;
    }

    public void setAvionImmat(String avionImmat) {
        this.avionImmat = avionImmat;
    }

    public String getAvionModele() {
        return avionModele;
    }

    public void setAvionModele(String avionModele) {
        this.avionModele = avionModele;
    }

    public int getPlacesEco() {
        return placesEco;
    }

    public void setPlacesEco(int placesEco) {
        this.placesEco = placesEco;
    }

    public int getPlacesBusiness() {
        return placesBusiness;
    }

    public void setPlacesBusiness(int placesBusiness) {
        this.placesBusiness = placesBusiness;
    }

    public BigDecimal getPrix() {
        return prix;
    }

    public void setPrix(BigDecimal prix) {
        this.prix = prix;
    }
}
