package com.aerocompagnie.model;

import com.aerocompagnie.dao.GenericDAO;
import java.util.List;

public class Aeroport {
    private String code_iata;
    private String nom;
    private String ville;
    private String pays;
    private String fuseau_horaire;

    public boolean save(String table) {
        return GenericDAO.save(this, table);
    }

    public static List<Aeroport> findAll(String table) {
        return GenericDAO.findAll(Aeroport.class, table);
    }

    public static boolean delete(String iata, String table) {
        return GenericDAO.deleteByString(iata, table, "code_iata");
    }

    public String getCode_iata() {
        return code_iata;
    }

    public void setCode_iata(String code_iata) {
        this.code_iata = code_iata;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getVille() {
        return ville;
    }

    public void setVille(String ville) {
        this.ville = ville;
    }

    public String getPays() {
        return pays;
    }

    public void setPays(String pays) {
        this.pays = pays;
    }

    public String getFuseau_horaire() {
        return fuseau_horaire;
    }

    public void setFuseau_horaire(String fuseau_horaire) {
        this.fuseau_horaire = fuseau_horaire;
    }
}
