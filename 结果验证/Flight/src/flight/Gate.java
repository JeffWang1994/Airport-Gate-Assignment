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
public class Gate {
    
    final private String id;
    final private String type;
    final private String loc;
    final private String arrival;
    final private String departure;
    final private String size;
    
    
    private boolean open=false; 
    private Date depart_time;
    
    public Gate(String id, String type, String loc, String arrival, String departure, String size){
        this.id=id;
        this.type=type;
        this.loc=loc;
        this.arrival=arrival;
        this.departure=departure;
        this.size=size;
    }

    
    
    /**
     * @return the id
     */
    public String getId() {
        return id;
    }

    /**
     * @return the type
     */
    public String getType() {
        return type;
    }

    /**
     * @return the loc
     */
    public String getLoc() {
        return loc;
    }

    /**
     * @return the arrival
     */
    public String getArrival() {
        return arrival;
    }

    /**
     * @return the departure
     */
    public String getDeparture() {
        return departure;
    }

    /**
     * @return the size
     */
    public String getSize() {
        return size;
    }

    /**
     * @return the open
     */
    public boolean isOpen() {
        return open;
    }

    /**
     * @param open the open to set
     */
    public void setOpen(boolean open) {
        this.open = open;
    }

    /**
     * @return the depart_time
     */
    public Date getDepart_time() {
        return depart_time;
    }

    /**
     * @param depart_time the depart_time to set
     */
    public void setDepart_time(Date depart_time) {
        this.depart_time = depart_time;
    }
    
    
    
    
    
}
