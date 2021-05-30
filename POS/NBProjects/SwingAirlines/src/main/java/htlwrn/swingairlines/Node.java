/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package htlwrn.swingairlines;

import java.util.LinkedList;
import java.util.List;

/**
 *
 * @author Elvin
 */
public class Node {
    
    private String iata;
    private double distance;
    private Node parent;
    private List<Node> iataList;
    
    private Tree tree;

    public Node(String iata, Tree tree) {
        
        this.iata = iata;
        distance = 0;
        parent = null;
        iataList = new LinkedList<>();
        this.tree = tree;
        
    }
    
    public String getIata() {
        return iata;
    }
    
    public Double getDistance() {
        return distance;
    }
    
    public List<Node> getIataList() {
        return iataList;
    }

    public void add(String iata, Node node) {
        if(this.iata.equals(iata)) {
            node.parent = this;
            node.distance = tree.callDistanceFunc(this.iata, node.iata) + this.distance;
            iataList.add(node);
        } else {                            //Zum richtigen Knoten gehen
            for(Node n : iataList) {
                n.add(iata, node);
            }
        }
    }
    
    public void remove(String iata) {
        if(this.iata.equals(iata)) {            //Root removen
            this.iata = "";
            iataList.clear();
        } else {                                //sonst - anderer Flughafen
            removeChild(iata);
        }
    }
    
    private void removeChild(String iata) {
        for(Node n : iataList) {
            if(n.getIata().equals(iata)) {
                iataList.remove(n);
                n.parent = null;
                break;
            } else {
                n.removeChild(iata);
            }
        }
    }
    
    boolean contains(String iata) {
        if(this.iata.equals(iata)) {
            return true;
        } else {
            for(Node n : iataList) {
                if(n.contains(iata)) {
                    return true;
                }
            }
        }
        return false;
    }
    
    public void print() {
        for(Node n : iataList) {
            System.out.println(n.getIata());
            n.print();
        }
    }
    
    
    public List<String> getRoute() {
        
        Node parent = this.parent;
        List<String> routeList = new LinkedList<>();
        
        routeList.add(iata);
        
        while(parent != null) {             //Zum Rootknoten raufwandern
            routeList.add(parent.iata);
            parent = parent.parent; 
        }
        
        return routeList;
        
    }
        
        
   /* alte Aufgabe
    public List<String> getRoute(String goalIata, List<String> routeList) {
        if(iata.equals(goalIata)) {
            routeList.add(iata);
            return routeList;
        } else {
            for(Node n : iataList) {
                List<String> list = n.getRoute(goalIata, routeList);
                if(list != null) {
                    routeList.add(iata);
                    return routeList;
                }
            }
        }
        return null;
        
    }*/
    
    
}
