/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package red.black.tree;

import java.awt.Graphics2D;
import java.awt.font.FontRenderContext;

/**
 *
 * @author wochi
 */
public class Node {

    private int value;
    private Node left;
    private Node right;
    private Node parent;
    private Color color;
    public static final Node nil = new Node(0);

    public Node(int value) {
        this.value = value;
        left = nil;
        right = nil;
        parent = nil;
        color = Color.BLACK;
    }
    
    

    void leftRotate(){
        Node y = right;
        right = y.left;
        if(y.left != nil){
            y.left.parent = this;
        }
        y.parent = parent;
        if(parent != nil){
            if(this == parent.left){
                parent.left = y;
            } else {
                parent.right = y;
            }
        }
        y.left = this;
        parent = y;
    }
    
    void rightRotate(){
        Node y = left;
        left = y.right;
        if(y.right != nil){
            y.right.parent = this;
        }
        y.parent = parent;
        if(parent != nil){
            if(this == parent.right){
                parent.right = y;
            } else {
                parent.left = y;
            }
        }
        y.right = this;
        parent = y;
    }
    
    private Node getRoot(){
        if(parent != nil){
            return parent.getRoot();
        }
        return this;
    }
    
    
    Node set(int val) {
        if(value>val) {
            if(left==nil){
                left=new Node(val);
                left.parent=this;
                left.color=Color.RED;
                left.setFixup();
            } else {
                return left.set(val);
            }
        } if(value<val){
            if(right==nil){
                right=new Node(val);
                right.parent=this;
                right.color=Color.RED;
                right.setFixup();
            } else {
                return right.set(val);
            }
        }
        
        Root = this.getRoot();
    }
    
    public void setFixup(){
        Node z = this;
        while(parent.color == Color.RED){
            if(parent == parent.parent.left){
                Node y = z.parent.parent.right;
                if(y.color == Color.RED){
                    parent.color = Color.BLACK;
                    y.color = Color.BLACK;
                    z.parent.parent.color = Color.RED;
                    z = z.parent.parent;
                } else {
                    if(z == parent.right){
                        z = z.parent;
                        z.leftRotate();
                    }
                    z.parent.color = Color.BLACK;
                    z.parent.parent.color = Color.RED;
                    z.parent.parent.rightRotate();
                }
            }
            else {
                Node y = z.parent.parent.left;
                if(y.color == Color.RED){
                    parent.color = Color.BLACK;
                    y.color = Color.BLACK;
                    z.parent.parent.color = Color.RED;
                    z = z.parent.parent;
                } else {
                    if(z == parent.left){
                        z = z.parent;
                        z.rightRotate();
                    }
                    z.parent.color = Color.BLACK;
                    z.parent.parent.color = Color.RED;
                    z.parent.parent.leftRotate();
                }
            }
        }
    }

    boolean get(int val) {
        if (value > val) {
            if (left == nil) {
                return false;
            } else {
                return left.get(val);
            }
        } else if (value < val) {
            if (right == nil) {
                return false;
            } else {
                return right.get(val);
            }
        }
        return true;
    }

    int size() {
        int size = 1;
        if (left != nil) {
            size += left.size();
        }
        if (right != nil) {
            size += right.size();
        }
        return size;
    }

    Node remove(int val) {
       return null;
    }


    void draw(Graphics2D g, int x, int y, int w) {
        if (color == Color.BLACK) {
            g.setColor(java.awt.Color.BLACK);
        } else {
            g.setColor(java.awt.Color.RED);
        }
        g.drawString("" + value, x, y);
        g.setColor(java.awt.Color.BLACK);
        if (left != nil) {
            g.drawLine(x, y, x - w / 2, y + 20);
            left.draw(g, x - w / 2, y + 20, w / 2);
        }
        if (right != nil) {
            g.drawLine(x, y, x + w / 2, y + 20);
            right.draw(g, x + w / 2, y + 20, w / 2);
        }
    }
}
