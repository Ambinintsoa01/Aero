package com.aerocompagnie.model;

public class SeatInfo {
    private int totalEco;
    private int reservedEco;
    private int availableEco;
    private int totalBusiness;
    private int reservedBusiness;
    private int availableBusiness;

    public SeatInfo(int totalEco, int reservedEco, int totalBusiness, int reservedBusiness) {
        this.totalEco = totalEco;
        this.reservedEco = reservedEco;
        this.availableEco = totalEco - reservedEco;
        this.totalBusiness = totalBusiness;
        this.reservedBusiness = reservedBusiness;
        this.availableBusiness = totalBusiness - reservedBusiness;
    }

    public int getTotalEco() {
        return totalEco;
    }

    public int getReservedEco() {
        return reservedEco;
    }

    public int getAvailableEco() {
        return availableEco;
    }

    public int getTotalBusiness() {
        return totalBusiness;
    }

    public int getReservedBusiness() {
        return reservedBusiness;
    }

    public int getAvailableBusiness() {
        return availableBusiness;
    }

    public int getTotalSeats() {
        return totalEco + totalBusiness;
    }

    public int getTotalReserved() {
        return reservedEco + reservedBusiness;
    }

    public int getTotalAvailable() {
        return availableEco + availableBusiness;
    }
}
