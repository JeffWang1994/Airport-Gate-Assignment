/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package flight.light;
import javax.imageio.*;
import java.awt.image.*;
import java.awt.*;
import java.io.*;
/**
 *
 * @author happy
 */
public class Draw {
    
    final private int time_interval=1;
    final private int gate_interval=80;
    
    final private int x_interval=160;
    final private int y_interval=80;
    
    final private int clock_period=2;
    
    public void draw(java.util.List<Flight> flight_list){
        BufferedImage image=new BufferedImage(gate_interval*69,24*60*time_interval,BufferedImage.TYPE_INT_RGB);
        Graphics2D g=(Graphics2D)image.createGraphics();
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, image.getWidth(), image.getHeight());
        
         //
        this.drawGrid(g, image.getWidth(), image.getHeight());
        
        //
        for(int i=0;i<flight_list.size();i++){
            this.drawFlight(g, flight_list.get(i));
        }
               
       
        
        
        try{
            g.dispose();
            ImageIO.write(image, "jpg", new java.io.File("land.jpg"));
            System.out.println("save land successfully.....");
        }catch(IOException exc){
            exc.printStackTrace();
        }
        
        this.drawBackground(image);
        
    }
    
    public void drawBackground(BufferedImage land){
        BufferedImage image=new BufferedImage(land.getWidth()+this.x_interval*2,land.getHeight()+this.y_interval*2,BufferedImage.TYPE_INT_RGB);
        Graphics2D g=(Graphics2D)image.createGraphics();
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, image.getWidth(), image.getHeight());
        g.drawImage(land, x_interval, y_interval, null);
        
        //
        
        int time_clock=0;
        //
        g.setColor(Color.BLACK);
        g.setFont(new Font(Font.SANS_SERIF,Font.ITALIC,40));
        for(int i=this.y_interval;i<image.getHeight();i=i+land.getHeight()*clock_period/24){
            g.drawString(String.valueOf(time_clock)+":00", 20, i+10);
            time_clock=time_clock+this.clock_period;
        }
        int gate_px=this.x_interval;
        for(int i=1;i<=69;i++){
            String gate="";
            if(i<=28){
                gate="T"+i;
            }else{
                gate="S"+(i-28);
            }
            g.drawString(gate,gate_px , this.y_interval);
            gate_px=gate_px+this.gate_interval;
        }
        
        
        try{
            g.dispose();
            ImageIO.write(image, "jpg", new java.io.File("paint.jpg"));
            System.out.println("save paint successfully.....");
        }catch(IOException exc){
            exc.printStackTrace();
        }
    }
    
    public void drawFlight(Graphics g, Flight f){
        //random a color
        g.setColor(new Color((int)(Math.random()*255),(int)(Math.random()*255),(int)(Math.random()*255)));
        //draw
        g.fillRect((f.getGate_id()-1)*this.gate_interval, f.getArrival_time()*this.time_interval, this.gate_interval, (f.getLeave_time()-f.getArrival_time())*this.time_interval);
    }
    
    public void drawGrid(Graphics g, int width, int height){
        g.setColor(Color.GRAY);
        for(int i=0;i<=width;i=i+this.gate_interval){
            g.drawLine(i, 0, i, height);
        }
        g.setColor(Color.PINK);
        for(int i=0;i<=height;i=i+height/24){
            g.drawLine(0, i, width, i);
        }
        
    }
}
