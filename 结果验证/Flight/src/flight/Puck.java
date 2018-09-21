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
public class Puck {
    
    
    final private String id;
    final private Date arrival_time;
    final private String arrival_type;
    final private String size;
    final private Date depart_time;
    final private String depart_type;
    
    public Puck(String id, Date arrival_time, String arrival_type, String size, Date depart_time, String depart_type ){
        this.id=id;
        this.arrival_time=arrival_time;
        this.arrival_type=arrival_type;
        this.size=size;
        this.depart_time=depart_time;
        this.depart_type=depart_type;
    }

    /**
     * @return the id
     */
    public String getId() {
        return id;
    }

    /**
     * @return the arrival_time
     */
    public Date getArrival_time() {
        return arrival_time;
    }

    /**
     * @return the arrival_type
     */
    public String getArrival_type() {
        return arrival_type;
    }

    /**
     * @return the size
     */
    public String getSize() {
        return size;
    }

    /**
     * @return the depart_time
     */
    public Date getDepart_time() {
        return depart_time;
    }

    /**
     * @return the depart_type
     */
    public String getDepart_type() {
        return depart_type;
    }
    
    
}
