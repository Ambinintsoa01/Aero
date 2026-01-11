package com.aerocompagnie.model;

import com.aerocompagnie.dao.GenericDAO;
import java.util.List;

public class StatutAvion {
    private int statut_id;
    private String statut_nom;

    public boolean save(String table) {
        return GenericDAO.save(this, table);
    }

    public static List<StatutAvion> findAll(String table) {
        return GenericDAO.findAll(StatutAvion.class, table);
    }

    public int getStatut_id() {
        return statut_id;
    }

    public void setStatut_id(int statut_id) {
        this.statut_id = statut_id;
    }

    public String getStatut_nom() {
        return statut_nom;
    }

    public void setStatut_nom(String statut_nom) {
        this.statut_nom = statut_nom;
    }
}
