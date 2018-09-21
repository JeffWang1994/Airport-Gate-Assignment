/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package flightassignment;

import java.util.*;

/**
 *
 * @author happy
 */
public class Puck {

    final private String puck_id;
    //the arrive time is the minutes from 19
    final private int arrive_time;
    final private int arrive_type;
    final private int plane_size;
    final private int depart_time;
    final private int depart_type;

    //the gate= 0 is temp gate, -1 is not sure yet
    private int gate=-1;
    //gate instance
    private Gate gate_instance;

    //swift number list， the list is store the pucks swift to this puck
    final private Map<Puck, Integer> swift_map = new HashMap<>();

    //backup
    final private String arrive_airport;
    final private String depart_airport;
    final private String up_info;
    final private String down_info;
    final private String arrive_time_str;
    final private String arrive_date_str;
    final private String arrive_type_str;
    final private String plane_size_str;
    final private String depart_time_str;
    final private String depart_type_str;
    final private String depart_date_str;

    /**
     * constructor
     *
     * @param puck_id
     * @param arrive_date
     * @param arrive_time
     * @param arrive_type
     * @param plane_size
     * @param depart_date
     * @param depart_time
     * @param depart_type
     * @param arrive_airport
     * @param depart_airport
     * @param up
     * @param down
     * @param gate
     * @throws Exception
     */
    public Puck(String puck_id, String arrive_date, String arrive_time, String arrive_type, String plane_size, String depart_date, String depart_time, String depart_type, String arrive_airport, String depart_airport, String up, String down) throws Exception {

        //backup
        this.arrive_date_str = arrive_date;
        this.arrive_time_str = arrive_time;
        this.arrive_type_str = arrive_type;
        this.plane_size_str = plane_size;
        this.depart_date_str = depart_date;
        this.depart_time_str = depart_time;
        this.depart_type_str = depart_type;
        this.arrive_airport = arrive_airport;
        this.depart_airport = depart_airport;
        this.up_info = up;
        this.down_info = down;

        //core......
        this.puck_id = puck_id;
        //parse arrive time
        this.arrive_time = this.parseTime(arrive_date, arrive_time);
        //parse plane size
        this.plane_size = this.parseSize(plane_size);
        //parse depart time
        this.depart_time = this.parseTime(depart_date, depart_time);
        //parse arrive type
        if (arrive_type.contains("I") && !arrive_type.contains("D")) {
            this.arrive_type = Input.ARRIVE_TYPE_I;
        } else if (!arrive_type.contains("I") && arrive_type.equals("D")) {
            this.arrive_type = Input.ARRIVE_TYPE_D;
        } else if (arrive_type.contains("D") && arrive_type.contains("I")) {
            this.arrive_type = Input.ARRIVE_TYPE_BOTH;
        } else {
            this.arrive_type=-1;
            throw new Exception("error arrive type");
        }
        //parse depart type
        if (depart_type.equals("I") && !depart_type.equals("D")) {
            this.depart_type = Input.ARRIVE_TYPE_I;
        } else if (!depart_type.equals("I") && depart_type.equals("D")) {
            this.depart_type = Input.ARRIVE_TYPE_D;
        } else if (depart_type.contains("D") && depart_type.contains("I")) {
            this.depart_type = Input.ARRIVE_TYPE_BOTH;
        } else {
            this.depart_type=-1;
            throw new Exception("error depart type");
        }

    }

    /**
     *
     * @param p
     * @param number
     */
    public void addSwiftNumber(Puck p, int number) {
        Integer num = this.getSwift_map().get(p);
        if (num == null) {
            this.getSwift_map().put(p, number);
        } else {
            this.getSwift_map().replace(p, num, num + number);
        }
    }

    /**
     *
     * @param date
     * @param time
     * @return
     */
    private int parseTime(String date, String time) {
        String[] time_value = time.split(":");
        
        if(time_value.length<=1){
            return Integer.parseInt(time);
        }
        
        int t = Integer.parseInt(time_value[0]) * 60 + Integer.parseInt(time_value[1]);
        if (date.equals("20-Jan-18")) {
            t = t + 24 * 60;
        } else if (date.endsWith("21-Jan-18")) {
            t = t + 48 * 60;
        }
        //  System.out.println(date+" "+time+" "+t);
        return t;
    }

    /**
     *
     * @param size
     * @return
     */
    private int parseSize(String size) {
        if (size.equals("332") || size.equals("333") || size.equals("33E") || size.equals("33L") || size.equals("33H") || size.equals("773")) {
            return Input.PLANE_SIZE_LARGE;
        } else {
            return Input.PLANE_SIZE_SMALL;
        }
    }

    /**
     * @return the puck_id
     */
    public String getPuck_id() {
        return puck_id;
    }

    /**
     * @return the arrive_time
     */
    public int getArrive_time() {
        return arrive_time;
    }

    /**
     * @return the arrive_type
     */
    public int getArrive_type() {
        return arrive_type;
    }

    /**
     * @return the plane_size
     */
    public int getPlane_size() {
        return plane_size;
    }

    /**
     * @return the depart_time
     */
    public int getDepart_time() {
        return depart_time;
    }

    /**
     * @return the depart_type
     */
    public int getDepart_type() {
        return depart_type;
    }

    /**
     * sort
     *
     * @param puck_list
     */
    public static void sort(List<Puck> puck_list) {
        for (int i = 0; i < puck_list.size() - 1; i++) {
            for (int j = 0; j < puck_list.size() - 1 - i; j++) {
                if (puck_list.get(j).getArrive_time() > puck_list.get(j + 1).getArrive_time()) {
                    Puck temp = puck_list.get(j);
                    puck_list.set(j, puck_list.get(j + 1));
                    puck_list.set(j + 1, temp);
                }
            }
        }

    }

    /**
     * @return the gate
     */
    public int getGate() {
        return gate;
    }

    /**
     * @param gate the gate to set
     */
    public void setGate(int gate) {
        this.gate = gate;
    }

    public void setGate(String gate){
        if(gate.contains("S")){
            this.gate=Integer.parseInt(gate.substring(1,gate.length()))+28;
        }else if(gate.contains("T")){
            this.gate=Integer.parseInt(gate.substring(1,gate.length()));
        }else{
            this.gate=Integer.parseInt(gate);
        }
    }
    
    /**
     * @return the arrive_airport
     */
    public String getArrive_airport() {
        return arrive_airport;
    }

    /**
     * @return the depart_airport
     */
    public String getDepart_airport() {
        return depart_airport;
    }

    /**
     * @return the up_info
     */
    public String getUp_info() {
        return up_info;
    }

    /**
     * @return the down_info
     */
    public String getDown_info() {
        return down_info;
    }

    /**
     * @return the arrive_time_str
     */
    public String getArrive_time_str() {
        return arrive_time_str;
    }

    /**
     * @return the arrive_date_str
     */
    public String getArrive_date_str() {
        return arrive_date_str;
    }

    /**
     * @return the arrive_type_str
     */
    public String getArrive_type_str() {
        return arrive_type_str;
    }

    /**
     * @return the plane_size_str
     */
    public String getPlane_size_str() {
        return plane_size_str;
    }

    /**
     * @return the depart_time_str
     */
    public String getDepart_time_str() {
        return depart_time_str;
    }

    /**
     * @return the depart_type_str
     */
    public String getDepart_type_str() {
        return depart_type_str;
    }

    /**
     * @return the depart_date_str
     */
    public String getDepart_date_str() {
        return depart_date_str;
    }

    /**
     * @return the swift_map
     */
    public Map<Puck, Integer> getSwift_map() {
        return swift_map;
    }

    /**
     * @return the gate_instance
     */
    public Gate getGate_instance() {
        return gate_instance;
    }

    /**
     * @param gate_instance the gate_instance to set
     */
    public void setGate_instance(Gate gate_instance) {
        this.gate_instance = gate_instance;
    }
    public void addGateInstance(List<Gate> list, int gate){
        for(int i=0;i<list.size();i++){
            if(gate==list.get(i).getBroad_id()){
                this.gate_instance=list.get(i);
                return ;
            }
        }
    }

}
