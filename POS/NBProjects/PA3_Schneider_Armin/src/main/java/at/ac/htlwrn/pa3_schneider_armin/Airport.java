/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package at.ac.htlwrn.pa3_schneider_armin;

/**
 *
 * @author armin
 */
public class Airport {
    
    private int id;
    private String name;
    private String iata;
    private double latitude;
    private double longitude;

    public Airport(int id, String name, String iata, double latitude, double longitude) {
        
        this.id = id;
        this.name = name;
        this.iata = iata;
        this.latitude = latitude;
        this.longitude = longitude;
        
    }

    public int getID() {
        return id;
    }
    
    public String getName() {
        return name;
    }

    public String getIata() {
        return iata;
    }
    
    public double getLatitude() {
        return latitude;
    }
    
    public double getLongitude() {
        return longitude;
    }
    
}
