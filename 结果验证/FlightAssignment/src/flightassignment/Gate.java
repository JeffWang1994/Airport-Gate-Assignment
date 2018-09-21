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
public class Gate {
    
    //init argument
    final private int broad_id;
    final private int broad_type;
    final private int arrive_type;
    final private int depart_type;
    final private int plane_size;
    final private int area;
    
    //puck record
    final private List<Puck> puck_record=new ArrayList<>();
    
    //backup in string
    final private String broad_id_str;
    final private String broad_type_str;
    final private String arrive_type_str;
    final private String depart_type_str;
    final private String plane_size_str;
    final private String area_str;
    
    /**
     * constructor
     * @param broad_id
     * @param board_type
     * @param area
     * @param arrive_type
     * @param depart_type
     * @param plane_size 
     * @throws java.lang.Exception 
     */
    public Gate(String broad_id, String board_type,String area,String arrive_type, String depart_type, String plane_size ) throws Exception{
        
        //backup in string
        this.broad_id_str=broad_id;
        this.broad_type_str=board_type;
        this.arrive_type_str=arrive_type;
        this.depart_type_str=depart_type;
        this.plane_size_str=plane_size;
        this.area_str=area;
        
        //parse poard id and type
        if(board_type.equals("T")){
            this.broad_type=Input.BOARD_TYPE_T;
            this.broad_id=Integer.parseInt(broad_id.substring(1));
        }else if(board_type.equals("S")){
            this.broad_type=Input.BOARD_TYPE_S;
            this.broad_id=Integer.parseInt(broad_id.substring(1))+28;
        }else{
            throw new Exception("error broad type");
        }
        //parse arrive type
        if(arrive_type.equals("I")){
            this.arrive_type=Input.ARRIVE_TYPE_I;
        }else if(arrive_type.equals("D")){
            this.arrive_type=Input.ARRIVE_TYPE_D;
        }else if(arrive_type.contains("D") && arrive_type.contains("I")){
            this.arrive_type=Input.ARRIVE_TYPE_BOTH;
        }else{
            throw new Exception("error arrive type");
        }
        //parse depart type
        if(depart_type.equals("I")){
            this.depart_type=Input.ARRIVE_TYPE_I;
        }else if(depart_type.equals("D")){
            this.depart_type=Input.ARRIVE_TYPE_D;
        }else if(depart_type.contains("D") && depart_type.contains("I") ){
            this.depart_type=Input.ARRIVE_TYPE_BOTH;
        }else{
            throw new Exception("error depart type");
        }
        //parse plane size
        if(plane_size.equals("N")){
            this.plane_size=Input.PLANE_SIZE_SMALL;
        }else if(plane_size.equals("W")){
            this.plane_size=Input.PLANE_SIZE_LARGE;
        }else{
            throw new Exception("error plane size");
        }
        //parse size
        if(area.equals("North")){
            this.area=Input.AREA_NORTH;
        }else  if(area.equals("South")){
            this.area=Input.AREA_SOUTH;
        }else if(area.equals("Center")){
            this.area=Input.AREA_CENTER;
        }else if(area.equals("East")){
            this.area=Input.AREA_EAST;
        }else{
            throw new Exception("error area");
        }
        
    }

    /**
     * 
     * @return 
     */
    public int getNextDepartTime(){
       if(this.getPuck_record().isEmpty()==false){
           Puck p=this.getPuck_record().get(this.getPuck_record().size()-1);
           return p.getDepart_time();
       }else{
           return 0;
       }
    }
    
    public String getLastPlaneId(){
        if(this.getPuck_record().isEmpty()==false){
           Puck p=this.getPuck_record().get(this.getPuck_record().size()-1);
           return p.getPuck_id();
       }else{
           return null;
       }
    }
    
    /**
     * 
     * @param puck 
     */
    public void park(Puck puck){
        this.getPuck_record().add(puck);
    }
    
    
    //..............................
    /**
     * @return the broad_id
     */
    public int getBroad_id() {
        return broad_id;
    }

    /**
     * @return the broad_type
     */
    public int getBroad_type() {
        return broad_type;
    }

    /**
     * @return the arrive_type
     */
    public int getArrive_type() {
        return arrive_type;
    }

    /**
     * @return the depart_type
     */
    public int getDepart_type() {
        return depart_type;
    }

    /**
     * @return the plane_size
     */
    public int getPlane_size() {
        return plane_size;
    }

    /**
     * @return the puck_record
     */
    public List<Puck> getPuck_record() {
        return puck_record;
    }

    /**
     * @return the broad_id_str
     */
    public String getBroad_id_str() {
        return broad_id_str;
    }

    /**
     * @return the broad_type_str
     */
    public String getBroad_type_str() {
        return broad_type_str;
    }

    /**
     * @return the arrive_type_str
     */
    public String getArrive_type_str() {
        return arrive_type_str;
    }

    /**
     * @return the depart_type_str
     */
    public String getDepart_type_str() {
        return depart_type_str;
    }

    /**
     * @return the plane_size_str
     */
    public String getPlane_size_str() {
        return plane_size_str;
    }

    /**
     * @return the area_str
     */
    public String getArea_str() {
        return area_str;
    }

    /**
     * @return the area
     */
    public int getArea() {
        return area;
    }
    
    
    
}
