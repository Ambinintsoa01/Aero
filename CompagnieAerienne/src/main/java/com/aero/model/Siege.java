package com.aero.model;

/**
 * Modèle pour un siège dans un avion
 */
public class Siege {
    private long id;
    private int id_avion;
    private String numero_siege;
    private String classe;
    private boolean disponible = true;

    public Siege() {
    }

    public Siege(int id_avion, String numero_siege, String classe) {
        this.id_avion = id_avion;
        this.numero_siege = numero_siege;
        this.classe = classe;
    }

    public Siege(long id, int id_avion, String numero_siege, String classe) {
        this.id = id;
        this.id_avion = id_avion;
        this.numero_siege = numero_siege;
        this.classe = classe;
    }

    // Getters et Setters
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public int getId_avion() {
        return id_avion;
    }

    public void setId_avion(int id_avion) {
        this.id_avion = id_avion;
    }

    public String getNumero_siege() {
        return numero_siege;
    }

    public void setNumero_siege(String numero_siege) {
        this.numero_siege = numero_siege;
    }

    public String getClasse() {
        return classe;
    }

    public void setClasse(String classe) {
        this.classe = classe;
    }

    public boolean isDisponible() {
        return disponible;
    }

    public void setDisponible(boolean disponible) {
        this.disponible = disponible;
    }

    @Override
    public String toString() {
        return "Siege{" +
                "id=" + id +
                ", id_avion=" + id_avion +
                ", numero_siege='" + numero_siege + '\'' +
                ", classe='" + classe + '\'' +
                ", disponible=" + disponible +
                '}';
    }
}
