package com.aerocompagnie.model;

import com.aerocompagnie.dao.GenericDAO;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public class Paiement {
    private int paiement_id;
    private int reservation_id;
    private BigDecimal montant;
    private LocalDateTime date_paiement;
    private String methode_paiement;

    public boolean save(String table) {
        return GenericDAO.save(this, table);
    }

    public static List<Paiement> findAll(String table) {
        return GenericDAO.findAll(Paiement.class, table);
    }

    public boolean effectuerPaiement(int resId, double montantValue, String methode, String table) {
        this.reservation_id = resId;
        this.montant = BigDecimal.valueOf(montantValue);
        this.methode_paiement = methode;
        this.date_paiement = LocalDateTime.now();
        return GenericDAO.save(this, table);
    }

    public int getPaiement_id() {
        return paiement_id;
    }

    public void setPaiement_id(int paiement_id) {
        this.paiement_id = paiement_id;
    }

    public int getReservation_id() {
        return reservation_id;
    }

    public void setReservation_id(int reservation_id) {
        this.reservation_id = reservation_id;
    }

    public BigDecimal getMontant() {
        return montant;
    }

    public void setMontant(BigDecimal montant) {
        this.montant = montant;
    }

    public LocalDateTime getDate_paiement() {
        return date_paiement;
    }

    public void setDate_paiement(LocalDateTime date_paiement) {
        this.date_paiement = date_paiement;
    }

    public String getMethode_paiement() {
        return methode_paiement;
    }

    public void setMethode_paiement(String methode_paiement) {
        this.methode_paiement = methode_paiement;
    }
}
