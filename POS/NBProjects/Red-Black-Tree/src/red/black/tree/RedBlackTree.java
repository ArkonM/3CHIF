/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package red.black.tree;

import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.font.FontRenderContext;
import java.util.Random;
import javax.swing.JFrame;
import javax.swing.JPanel;

/**
 *
 * @author wochi
 */
public class RedBlackTree extends JPanel 
{
    
    Node root = null;
    
    public void set(int val)
    {
        if(root == null)
        {
            root = new Node(val);
        }
        else
        {
            root = root.set(val);
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
    
    public void remove(int val)
    {
        if(root == null)
        {
            return;
        }
        else
        {
            root = root.remove(val);
        }
    }
    
    public int getTreeSize()
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
    
     protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        Graphics2D g2 = (Graphics2D)g;
        g2.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING,
                            RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
        if(root != null)
            root.draw(g2, 400, 20, 400);
        
    }
    

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args)
    {
        RedBlackTree rbt = new RedBlackTree();
//        Random r = new Random();
//        for(int i = 0; i < 50; i++)
//        {
//            rbt.set(r.nextInt(1000));
//        }
        rbt.set(50);
        rbt.set(25);
        rbt.set(15);
        rbt.set(5);
        rbt.set(10);
        rbt.set(20);
        rbt.set(30);
        rbt.set(40);
        rbt.get(25);
//        rbt.remove(15);
        JFrame f = new JFrame();
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        f.getContentPane().add(rbt);
        f.setSize(800,400);
        f.setLocation(10,10);
        f.setVisible(true);
    }
}
