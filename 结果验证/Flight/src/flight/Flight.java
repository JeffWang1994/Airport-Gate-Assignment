/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package flight;
import java.util.*;
import flight.light.*;
/**
 *
 * @author happy
 */
public class Flight {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws Exception{
        // TODO code application logic here

        List<flight.light.Flight> p_list=flight.light.Input.loadFlight();
        for(int i=0;i<p_list.size();i++){
            flight.light.Flight f=p_list.get(i);
            System.out.println(f.getGate_id()+" "+f.getArrival_time()+" "+f.getLeave_time());
        }
      new Draw().draw(p_list);
//      Anumiate a=new Anumiate();
//      while(true){
//          a.draw(p_list);
//          Thread.sleep(5000);
//      }

        
        
    }
    
}
