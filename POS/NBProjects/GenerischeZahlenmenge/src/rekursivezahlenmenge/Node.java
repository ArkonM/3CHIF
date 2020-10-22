/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rekursivezahlenmenge;

interface calculator<T> {
    T add(T x, T y);
    T zero();
    T one();
    T div(T x, T y);
    T random(T x, T y);
}
/**
 *
 * @author armin
 */
public class Node<T extends Number & Comparable<T>> {

    private T value;
    private Node<T> left;
    private Node<T> right;

    public Node(T value) {
        this.value = value;
    }

    public void set(T val) {
        set(new Node<T>(val));
    }

    private void set(Node<T> val) {
        if (val.value.compareTo(value) == -1) {
            if (left == null) {
                left = val;
            } else {
                left.set(val);
            }
        } else if (val.value.compareTo(value) == 1) {
            if (right == null) {
                right = val;
            } else {
                right.set(val);
            }
        }
    }

    public boolean get(T val) {
        if (val.compareTo(value) == -1) {
            if (left == null) {
                return false;
            } else {
                return left.get(val);
            }
        } else if (val.compareTo(value) == 1) {
            if (right == null) {
                return false;
            } else {
                return right.get(val);
            }
        }
        return true;
    }

    public T size(calculator<T> calc) {
        T size = calc.one();
        if (left != null) {
            size = calc.add(size, left.size(calc));
        }
        if (right != null) {
            size = calc.add(size, right.size(calc));
        }
        return size;
    }

    public Node<T> remove(T val) {
        if (val.compareTo(value) == 0) {
            if (left == null || right == null) {
                return left == null ? right : left;
            }
            left.set(right);
            return left;

        }
        if (val.compareTo(value) == -1 && left != null) {
            left = left.remove(val);
        } else if (val.compareTo(value) == 1 && right != null) {
            right = right.remove(val);
        }
        return this;
    }

    @Override
    public String toString() {
        return ((left != null) ? (left + " ") : ("")) + value + ((right != null) ? (" " + right) : (""));
    }
    
    T total(calculator<T> calc){
        T sum = calc.zero();
        if(left != null){
            sum = calc.add(sum, left.total(calc));
        }
        if(right != null){
            sum = calc.add(sum, right.total(calc));
        }
        
        return calc.add(sum, value);
    }
    
    public Set<T> clone(Set<T> clone){
        clone.set(value);
        if (left != null){
           left.clone(clone);
        }
        if (right != null){
            right.clone(clone);
      }
      return clone;
  }
    
    public Set<T> intersect(Set<T> inter, Set<T> s2){
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
    
    public Set<T> union(Set<T> uni){
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
    
    public Set<T> diff(Set<T> dif, Set<T> s2){
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
    
    
   public Set<T> range(Set<T> ran, T anf, T end){
       if(((value.compareTo(anf)==1) || (value.compareTo(anf)==0)) && ((value.compareTo(end)==-1) || (value.compareTo(end)==0))){
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
    
    T min(calculator<T> calc){
        if(left!=null){
            return left.min(calc);
        } else {
            return value;
        }
    }
    
    T max(calculator<T> calc){
        if(right!=null){
            return right.max(calc);
        } else {
            return value;
        }
    }
    
    boolean equals(Set<T> s) {
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

