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
public class Node {

    private int value;
    private Node left;
    private Node right;

    public Node(int value) {
        this.value = value;
    }

    public void set(int val) {
        set(new Node(val));
    }

    private void set(Node val) {
        if (value > val.value) {
            if (left == null) {
                left = val;
            } else {
                left.set(val);
            }
        } else if (value < val.value) {
            if (right == null) {
                right = val;
            } else {
                right.set(val);
            }
        }
    }

    public boolean get(int val) {
        if (value > val) {
            if (left == null) {
                return false;
            } else {
                return left.get(val);
            }
        } else if (value < val) {
            if (right == null) {
                return false;
            } else {
                return right.get(val);
            }
        }
        return true;
    }

    public int size() {
        int size = 1;
        if (left != null) {
            size += left.size();
        }
        if (right != null) {
            size += right.size();
        }
        return size;
    }

    public Node remove(int val) {
        if (value == val) {
            if (left == null || right == null) {
                return left == null ? right : left;
            }
            left.set(right);
            return left;

        }
        if (value > val && left != null) {
            left = left.remove(val);
        } else if (value < val && right != null) {
            right = right.remove(val);
        }
        return this;
    }

    @Override
    public String toString() {
        return ((left != null) ? (left + " ") : ("")) + value + ((right != null) ? (" " + right) : (""));
    }
    
    int total(){
        int sum = 0;
        if(left != null){
            sum+=left.total();
        }
        if(right != null){
            sum+=right.total();
        }
        
        return sum + value;
    }
    
    public Set clone(Set clone){
        clone.set(value);
        if (left != null){
           left.clone(clone);
        }
        if (right != null){
            right.clone(clone);
      }
      return clone;
  }
    
    public Set intersect(Set inter, Set s2){
        if(s2.get(value)){
            inter.set(value);
        }
        if(left != null){
            left.intersect(inter, s2);
        }
        if(right != null){
            right.intersect(inter, s2);
        }
        return inter;
    }
    
    public Set union(Set uni){
        if(!uni.get(value)){
            uni.set(value);
        }
        if(left != null){
            left.union(uni);
        }
        if(right != null){
            right.union(uni);
        }
        return uni;
    }
    
    public Set diff(Set dif, Set s2){
        if(!s2.get(value)){
            dif.set(value);
        }
        if(left != null){
            left.diff(dif, s2);
        }
        if(right != null){
            right.diff(dif, s2);
        }
        return dif;
    }
    
    
   public Set range(Set ran, int anf, int end){
       if(value >= anf && value <= end){
           ran.set(value);
        }
       if(left != null){
            left.range(ran, anf, end);
        }
        if(right != null){
            right.range(ran, anf, end);
        }
        return ran;
   }
    
    int min(){
        if(left!=null){
            return left.min();
        } else {
            return value;
        }
    }
    
    int max(){
        if(right!=null){
            return right.min();
        } else {
            return value;
        }
    }
    
    boolean equals(Set s) {
        if(!s.get(value)){
            return false;
        }
        boolean y = true;
        if(left != null){
            left.equals(s);
        }
        if(y && right != null){
            y = right.equals(s);
        }
        return y;
    }
}

