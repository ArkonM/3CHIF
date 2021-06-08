package at.ac.htlwrn.pong;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.image.BufferStrategy;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFrame;

public class Pong extends JFrame {
    MouseListener listener;
    KeyListener keys;

    double playerL = 0;
    double playerR = 0;
    double playerSpeed = 100;
    boolean upL = false;
    boolean downL = false;
    boolean upR = false;
    boolean downR = false;

    Color color;

    public Pong() throws IOException {

        color = new Color(0, 0, 0);

        listener = new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                new Sound("C:\\WINDOWS\\Media\\tada.wav").start();
            }

        };

        keys = new KeyAdapter() {
            @Override
            public void keyReleased(KeyEvent e) {
                if(e.getKeyCode() == KeyEvent.VK_DOWN)
                {
                    downR = false;
                }
                if(e.getKeyCode() == KeyEvent.VK_UP)
                {
                    upR = false;
                }
                if(e.getKeyCode() == KeyEvent.VK_S)
                {
                    downL = false;
                }
                if(e.getKeyCode() == KeyEvent.VK_W)
                {
                    upL = false;
                }
            }

            @Override
            public void keyPressed(KeyEvent e) {
                if(!downR && e.getKeyCode() == KeyEvent.VK_DOWN)
                {
                    System.out.println("DownL");
                    downR = true;
                }
                if(!upR && e.getKeyCode() == KeyEvent.VK_UP)
                {
                    System.out.println("UpL");
                    upR = true;
                }
                if(!downL && e.getKeyCode() == KeyEvent.VK_S)
                {
                    System.out.println("DownR");
                    downL = true;
                }
                if(!upL && e.getKeyCode() == KeyEvent.VK_W)
                {
                    System.out.println("UpR");
                    upL = true;
                }
            }

        };

        setLayout(null);
        addMouseListener(listener);
        addKeyListener(keys);

    }

    @Override
    public void paint(Graphics g) {
        super.paint(g);
        Graphics2D g2 = (Graphics2D) g;
        Graphics2D g1 = (Graphics2D) g;
        g2.setColor(Color.ORANGE);
        g2.drawRect(10, (int) playerL, 15, 45);
        g1.setColor(Color.BLUE);
        g1.drawRect(this.getWidth()-28, (int) playerR, 15, 45);

    }
    
    public void update(double deltaInSeconds)
    {
        
        if(upL)
        {
            playerL -= deltaInSeconds * playerSpeed;
        }
        if(downL)
        {
            playerL += deltaInSeconds * playerSpeed;
        }
        if(upR)
        {
            playerR -= deltaInSeconds * playerSpeed;
        }
        if(downR)
        {
            playerR += deltaInSeconds * playerSpeed;
        }
    }

    /**
     * @param args
     * @throws IOException
     */
    public static void main(String[] args) throws IOException {
        Pong b = new Pong();
        b.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        b.setTitle("Pong");
        b.setIgnoreRepaint(true);
        b.setSize(800, 600);
        b.setVisible(true);
        b.createBufferStrategy(2);
        BufferStrategy buffer = b.getBufferStrategy();
        Graphics graphics = null;
        long oldTime = System.nanoTime();
        long newTime = oldTime;
        while (true) {
            try {
                oldTime = newTime;
                newTime = System.nanoTime();
                long delta = (newTime - oldTime);
                //System.out.println("Update " + delta);
                b.update(delta / 1000000000.0);
                // clear back buffer...
                graphics = buffer.getDrawGraphics();
                graphics.setColor(Color.WHITE);
                b.paint(graphics);
                // blit the back buffer to the screen			
                if (!buffer.contentsLost()) {
                    buffer.show();
                }

                // Let the OS have a little time...
                Thread.sleep(2);
            } catch (InterruptedException ex) {
                Logger.getLogger(Pong.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                if (graphics != null) {
                    graphics.dispose();
                }
            }
        }
    }
}
