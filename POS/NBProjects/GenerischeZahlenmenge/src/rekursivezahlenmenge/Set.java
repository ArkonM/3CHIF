/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rekursivezahlenmenge;
        
import java.util.Random;

/**
 *
 * @author armin
 */

class calc implements calculator<Integer> {
        @Override
        public Integer add(Integer x, Integer y) {
            return x + y;
        }
        
        @Override
        public Integer zero() {
            return 0;
        }
        
        @Override
        public Integer one() {
            return 1;
        }
        
        @Override
        public Integer div(Integer x, Integer y) {
            return x/y;
        }
        
        @Override
        public Integer random(Integer x, Integer y) {
            Random r = new Random();
            return r.nextInt(x)+y;
        }
}    

public class Set<T extends Number & Comparable<T> > {
    private Node<T> root = null;
    
    public void set(T val)
    {
        if(root == null)
        {
            root = new Node<T>(val);
        }
        else
        {
            root.set(val);
        }
    }
    
    public boolean get(T val)
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
    
    public T size(calculator <T> calc)
    {
        if(root == null)
        {
            return calc.zero();
        }
        else
        {
            return root.size(calc);
        }
    }
    
    public void remove(T val)
    {
        if(root != null)
        {
            root = root.remove(val);
        }
    }
    
    
    public Set<T> clone(){
        Set<T> s = new Set();
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
    
    public Set<T> intersect(Set<T> s){
        Set<T> inter = new Set();
        if(root != null){
            return root.intersect(inter,s);
        }
        return inter;
    }
    
    public Set<T> union(Set<T> s){
        Set<T> uni = new Set();
        if(root != null){
            uni=root.union(uni);
            return s.root.union(uni);
        }
        return uni;
    } 
    
    public Set<T> diff(Set<T> s){
        Set<T> s1 = new Set();
        if(root != null){
            return root.diff(s1,s);
        }
        return s1;
    } 
    
    public Set<T> range(T anf, T end){
        Set<T> ran = new Set();
        if(root != null){
            return root.range(ran, anf, end);
        }
        return ran;
    }
    
    public T total(calculator<T> calc){
        if(root != null) {
            return root.total(calc);
        }
        return calc.zero();
    }
    
    public T average(calculator<T> calc){
        T d= total(calc);
        T d1=size(calc);
        return calc.div(d,d1);
    }
    
    public T min(calculator<T> calc){
        if(root != null) {
            return root.min(calc);
        }
        return calc.zero();
    }
    
    public T max(calculator<T> calc){
        if(root != null) {
            return root.max(calc);
        }
        return calc.zero();
    }
    
    public boolean equals(Set<T> val){
        if(root != null) {
            return root.equals(val);
        }
        return false;
    }
    
    public T zufallsZahl(calculator<T> calc){
        T random = calc.zero();
        do {
            random = calc.random(min(calc), max(calc));
        } while(!get(random));
        return random;
    }
    
    
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        calc calc = new calc();
        Set<Integer> s1 = new Set();
        Set<Integer> s2 = new Set();
        
        
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
        System.out.println(s1.total(calc));
        System.out.println("Average:");
        System.out.println(s1.average(calc));
        System.out.println("Min:");
        System.out.println(s1.min(calc));
        System.out.println("Max");
        System.out.println(s1.max(calc));    
        System.out.println("Zufallszahl:");
        System.out.println(s1.zufallsZahl(calc));
        
        System.out.println("Clone:");
        s2 = s1.clone();
        s2.print();
        
        System.out.println("Equals:");
        System.out.println(s1.equals(s2));
                
        s2.remove(20);
        s2.remove(40);
        s2.remove(5);
        System.out.println("Removed 20,40,5 from s2");
        s2.print();
        s1.remove(15);
        s1.remove(7);
        s1.remove(1);
        System.out.println("Removed 15,1,7 from s1");
        s1.print();
        
        System.out.println("Intersect:");
        System.out.println(s1.intersect(s2));
        System.out.println("Union:");
        System.out.println(s1.union(s2));
        
        s2.remove(7);
        System.out.println("Removed 7 from s2");
        s2.print();
        
        System.out.println("Difference:");
        System.out.println(s1.diff(s2));
        
        System.out.println("Range(5,10):");
        s2=s1.range(5,10);
        s2.print();

        
        
    }
}