/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package flight.light;
/**
 *
 * @author happy
 */
public class Flight {
    
    final private int gate_id;
    final private int arrival_time;
    final private int leave_time;
    
    public Flight(String gate,String arrival_time, String depart_time){
        //parse gate id
        if(gate.contains("T")){
            this.gate_id=Integer.parseInt(gate.replace("T", ""));
        }else if(gate.contains("S")){
            this.gate_id=Integer.parseInt(gate.replace("S", ""))+28;
        }else{
            this.gate_id=Integer.parseInt(gate);
        }
        //arrival time
        this.arrival_time=this.parseTime(arrival_time);
        this.leave_time=this.parseTime(depart_time);
    }
    
    private int parseTime(String time){
        String[] value=time.split(":");
        if(value.length==2){
            return Integer.parseInt(value[0])*60+Integer.parseInt(value[1]);
        }else{
            return Integer.parseInt(value[0])-1440;
        }
    }

    /**
     * @return the gate_id
     */
    public int getGate_id() {
        return gate_id;
    }

    /**
     * @return the arrival_time
     */
    public int getArrival_time() {
        return arrival_time;
    }

    /**
     * @return the leave_time
     */
    public int getLeave_time() {
        return leave_time;
    }
    
    
}
