/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rekursivezahlenmenge;
        
/**
 *
 * @author armin
 */
public class Set<T extends Comparable<T> > {
    Node<T> root = null;
    
    public void set(T val)
    {
        if(root == null)
        {
            root = new Node(val);
        }
        else
        {
            root.set(val);
        }
    }
    
    public boolean get(int val)
    {
        if(root == null)
        {
            return false;
        }
        else
        {
            return root.get(val);
        }
    }
    
    public int size()
    {
        if(root == null)
        {
            return 0;
        }
        else
        {
            return root.size();
        }
    }
    
    public void remove(int val)
    {
        if(root != null)
        {
            root = root.remove(val);
        }
    }
    
    
    public Set clone(){
        Set s = new Set();
        if(root != null){
            return root.clone(s);
        }
        return s;
     }
    

    @Override
    public String toString() {
        return "" + (root != null ? root : "");
    }
    
    public void print()
    {
        System.out.println(this);
    }
    
    public Set intersect(Set s){
        Set inter = new Set();
        if(root != null){
            return root.intersect(inter,s);
        }
        return inter;
    }
    
    public Set union(Set s){
        Set uni = new Set();
        if(root != null){
            uni=root.union(uni);
            return s.root.union(uni);
        }
        return uni;
    } 
    
    public Set diff(Set s){
        Set s1 = new Set();
        if(root != null){
            return root.diff(s1,s);
        }
        return s1;
    } 
    
    public Set range(int anf, int end){
        Set ran = new Set();
        if(root != null){
            return root.range(ran, anf, end);
        }
        return ran;
    }
    
    public int total(){
        if(root != null) {
            return root.total();
        }
        return 0;
    }
    
    public double average(){
        double d= total();
        double d1=size();
        return d/d1;
    }
    
    public int min(){
        if(root != null) {
            return root.min();
        }
        return 0;
    }
    
    public int max(){
        if(root != null) {
            return root.max();
        }
        return 0;
    }
    
    public boolean equals(Set val){
        if(root != null) {
            return root.equals(val);
        }
        return false;
    }
    
    public int zufallsZahl(){
        int random = 0;
        do {
            random = (int) (min() + (Math.random() * (max()-min())));
        } while(!get(random));
        return random;
        }
    
    
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Set s1 = new Set();
        Set s2 = new Set();
        
        
        s1.set(10);
        s1.set(7);
        s1.set(40);
        s1.set(1);
        s1.set(5);
        s1.set(20);
        s1.set(15);
        System.out.println("s1:");
        s1.print();
        
        s1.remove(15);
        System.out.println("Rmoved 15 from s1:");
        s1.print();
        
        System.out.println("Total:");
        System.out.println(s1.total());
        System.out.println("Average:");
        System.out.println(s1.average());
        System.out.println("Min:");
        System.out.println(s1.min());
        System.out.println("Max");
        System.out.println(s1.max());    
        System.out.println("Zufallszahl:");
        System.out.println(s1.zufallsZahl());
        
        System.out.println("Clone:");
        s2 = s1.clone();
        s2.print();
        
        System.out.println("Equals:");
        System.out.println(s1.equals(s2));
                
        s2.remove(20);
        s2.remove(40);
        s2.remove(5);
        System.out.println("Removed 20,40,5 from s2");
        s1.remove(15);
        s1.remove(7);
        s1.remove(1);
        System.out.println("Removed 15,1,7 from s1");
        
        System.out.println("Intersect:");
        System.out.println(s1.intersect(s2));
        System.out.println("Union:");
        System.out.println(s1.union(s2));
        
        s2.remove(20);
        s2.remove(7);
        s2.remove(5);
        System.out.println("Removed 20,40,5 from s2");
        
        System.out.println("Difference:");
        System.out.println(s1.diff(s2));
        
        System.out.println("Range(5,10):");
        s2=s1.range(5,10);
        s2.print();
        
        System.out.println("Average:");
        System.out.println(s1.average());
        
        
    }
}