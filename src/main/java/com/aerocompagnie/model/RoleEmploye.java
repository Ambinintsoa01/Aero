package com.aerocompagnie.model;

import com.aerocompagnie.dao.GenericDAO;
import java.util.List;

public class RoleEmploye {
    private int role_id;
    private String role_nom;

    public boolean save(String table) {
        return GenericDAO.save(this, table);
    }

    public static List<RoleEmploye> findAll(String table) {
        return GenericDAO.findAll(RoleEmploye.class, table);
    }

    public int getRole_id() {
        return role_id;
    }

    public void setRole_id(int role_id) {
        this.role_id = role_id;
    }

    public String getRole_nom() {
        return role_nom;
    }

    public void setRole_nom(String role_nom) {
        this.role_nom = role_nom;
    }
}
