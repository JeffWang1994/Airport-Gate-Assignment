/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package flight;
import java.util.*;
/**
 *
 * @author happy
 */
public class A1 {
    public static List<Gate> cal(List<Gate> g, List<Puck> p){
        
        for(int i=0;i<p.size();i++){
            Puck p_=p.get(i);
            for(int j=0;j<g.size();j++){
                Gate g_=g.get(j);
                if(g_.isOpen()==true){
                    if(g_.getArrival().contains(p_.getArrival_type()) && g_.getDeparture().contains(p_.getDepart_type()) && g_.getDepart_time().before(p_.getArrival_time())){
                        g_.setDepart_time(p_.getDepart_time());
                        break;
                    }
                }
            }
            for(int j=0;j<g.size();j++){
                Gate g_=g.get(j);
                    if(g_.getArrival().contains(p_.getArrival_type()) && g_.getDeparture().contains(p_.getDepart_type()) && g_.getDepart_time().before(p_.getArrival_time())){
                        g_.setDepart_time(p_.getDepart_time());
                        g_.setOpen(true);
                        break;
                    }
            }
            
        }
        return g;
    }
}
