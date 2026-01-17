package com.aero.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.aero.util.DatabaseConnection;

public class Classe {

    private int id;
    private String libelle;

    public Classe() {
    }

    public Classe(int id, String libelle) {
        this.id = id;
        this.libelle = libelle;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public List<Classe> findAll() {
        List<Classe> classes = new ArrayList<>();
        String sql = "SELECT * FROM classe ORDER BY id";
        try (Connection conn = DatabaseConnection.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Classe classe = new Classe();
                classe.setId(rs.getInt("id"));
                classe.setLibelle(rs.getString("libelle"));
                classes.add(classe);
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des classes : " + e.getMessage());
            e.printStackTrace();
        }
        return classes;
    }

    public Classe findById(int id) {
        Classe classe = null;
        String sql = "SELECT * FROM classe WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    classe = new Classe();
                    classe.setId(rs.getInt("id"));
                    classe.setLibelle(rs.getString("libelle"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération de la classe : " + e.getMessage());
            e.printStackTrace();
        }
        return classe;
    }
}
