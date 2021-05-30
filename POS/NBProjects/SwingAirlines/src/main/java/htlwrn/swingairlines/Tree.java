/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package htlwrn.swingairlines;

import java.util.LinkedList;
import java.util.List;
import javax.swing.JOptionPane;

/**
 *
 * @author Elvin
 */
public class Tree {
    
    public Node root = null;
    
    private Main obj;
    private Airport start, end;
    private List<Airport> airports;
    private List<String> routeList;
    
    public Tree() {
        airports = new LinkedList<>();
        routeList = new LinkedList<>();
    }
    
    public void setMain(Main obj) {
        this.obj = obj;
    }
    
    public List<String> getRouteList() {
        return routeList;
    }
    
    public void setAttributes(Airport start, Airport end, List<Airport> airports) {
        this.start = start;
        this.end = end;
        this.airports = airports;
    }
    
    
   /* alte Aufgabe
    public void createTree() {
        
        String goalIata = "", currentIata = "";
        List<String> knownList = new LinkedList<>();
        List<String> checkList = new LinkedList<>();
        
        root = new Node(start.getIata());
        checkList.add(start.getIata());
        
        while(checkList.size() > 0) {
            if(!goalIata.equals(end.getIata())) {
                currentIata = checkList.get(0);
                airports = obj.getChildAirports(obj.getAirportFromIata(currentIata));
                checkList.remove(currentIata);
                for(int i = 0; i < airports.size(); i++) {
                    
                    goalIata = airports.get(i).getIata();
                    
                    if(!knownList.contains(goalIata)) {
                        knownList.add(goalIata);
                        checkList.add(goalIata);
                        root.add(currentIata, new Node(goalIata));
                    }
                    
                    if(goalIata.equals(end.getIata())) {
                        checkList.clear();
                        break;
                    }
                }
            }
        }
        //root.print();
        routeList = root.getRoute(end.getIata(), new LinkedList<>());
        if(routeList != null) {
            System.out.println(routeList.size());
            for(String s : routeList)
                System.out.println(s);
        } else {
            JOptionPane.showMessageDialog(null, "Es wurde keine Route gefunden!");
        }
    }*/

    public void createTree() {
        
        double smallestDistance = Double.MAX_VALUE, currentDistance;
        
        List<Node> list = new LinkedList<>();
        
        Node currNode, endNode = null;
        Airport airp1, airp2;
        
        root = new Node(start.getIata(), this);
        list.add(root);
        
        while(list.size() > 0) {
            currNode = list.get(0);
            list.remove(currNode);
            if(currNode.getDistance() < smallestDistance) {
                
                airports = obj.getChildAirports(obj.getAirportFromIata(currNode.getIata()));
                
                for(int i = 0; i < airports.size(); i++) {
                    
                    Node child = new Node(airports.get(i).getIata(), this);
                    
                    airp1 = obj.getAirportFromIata(currNode.getIata());
                    airp2 = obj.getAirportFromIata(child.getIata());
                    
                    currentDistance = getCurrentDistance(airp1.getLatitude(), airp1.getLongitude(), airp2.getLatitude(), airp2.getLongitude()) + currNode.getDistance();
                    //System.out.println(currentDistance);

                    if((currentDistance < smallestDistance) && (child.getIata().equals(end.getIata()))) {
                        
                        root.remove(end.getIata());                 //Löschen und Hinzufügen, damit beim "endNode" die distance (geschieht im add) gespeichert wird
                        root.add(currNode.getIata(), child);
                        endNode = child;
                        smallestDistance = currentDistance;
                        System.out.println("in: " + currentDistance + " " + currNode.getIata());
                        
                    } else if(!root.contains(child.getIata())) {
                        root.add(currNode.getIata(), child);            //zu currNode füg ich child hinzu
                        list.add(child);
                    }
                    //System.out.println(list.size());
                    
                }
                
                if(!checkDistance(smallestDistance, list)) {
                    break;
                }
                
                //root.print();
            }
        }
        if(endNode != null) {
            routeList = endNode.getRoute();
        } else {
            JOptionPane.showMessageDialog(null, "Es wurde keine Route gefunden!");
        }
        //root.print();
        //routeList = root.getRoute(end.getIata(), new LinkedList<>());
        if(routeList != null) {
            System.out.println(routeList.size());
            for(String s : routeList)
                System.out.println(s);
        } else {
            JOptionPane.showMessageDialog(null, "Es wurde keine Route gefunden!");
        }
    }
    
    public void clear() {
        root = null;
    }

    public double getCurrentDistance(double latitude1, double longitude1, double latitude2, double longitude2) {
        
        double latitudeDiff = latitude1 - latitude2;
        double longitudeDiff = ((longitude1 - longitude2) > 180) ? 360 - (longitude1 - longitude2) : longitude1 - longitude2;
        
        return Math.sqrt((latitudeDiff * latitudeDiff) + (longitudeDiff * longitudeDiff));
        
    }

    public double callDistanceFunc(String iata1, String iata2) {
        
        Airport airp1 = obj.getAirportFromIata(iata1);
        Airport airp2 = obj.getAirportFromIata(iata2);
        
        return getCurrentDistance(airp1.getLatitude(), airp1.getLongitude(), airp2.getLatitude(), airp2.getLongitude());
        
    }

    private boolean checkDistance(double distance, List<Node> list) {
        for(Node n : list) {
            if(n.getDistance() < distance) {
                return true;
            }
        }
        return false;
    }
    
}
