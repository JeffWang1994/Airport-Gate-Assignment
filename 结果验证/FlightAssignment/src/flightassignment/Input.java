/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package flightassignment;

import com.csvreader.*;

import java.util.*;

/**
 *
 * @author yuwei
 */
public class Input {

    final static public int BOARD_TYPE_T = 0;
    final static public int BOARD_TYPE_S = 1;

    final static public int ARRIVE_TYPE_I = 0;
    final static public int ARRIVE_TYPE_D = 1;
    final static public int ARRIVE_TYPE_BOTH = 2;

    final static public int PLANE_SIZE_LARGE = 0;
    final static public int PLANE_SIZE_SMALL = 1;

    final static public int AREA_NORTH = 0;
    final static public int AREA_SOUTH = 1;
    final static public int AREA_EAST = 2;
    final static public int AREA_CENTER = 3;

    /**
     * load gates
     *
     * @param path
     * @return
     * @throws Exception
     */
    public static List<Gate> load_gates(String path) throws Exception {

        //create list
        List<Gate> gate_list = new ArrayList<>();

        //load file
        CsvReader in = new CsvReader("gates.csv");

        //read by line
        in.readHeaders();
        while (in.readRecord()) {
            Gate g = new Gate(in.get(0), in.get(1), in.get(2), in.get(3), in.get(4), in.get(5));
            gate_list.add(g);
        }
        return gate_list;
    }

    /**
     * load gates
     *
     * @param path
     * @return
     * @throws Exception
     */
    public static List<Puck> load_pucks(String path) throws Exception {

        //create list
        List<Puck> puck_list = new ArrayList<>();

        //load file
        CsvReader in = new CsvReader(path);

        //read by line
        in.readHeaders();
        while (in.readRecord()) {
            Puck g = new Puck(in.get(0), in.get(1), in.get(2), in.get(4), in.get(5), in.get(6), in.get(7), in.get(9), in.get(3), in.get(8), in.get(10), in.get(11));
            if ((g.getArrive_time() >= 1440 && g.getArrive_time() <= 2880) || (g.getDepart_time() >= 1440 && g.getDepart_time() <= 2880)) {
                 if(in.getColumnCount()>12){
                     g.setGate(in.get(12));
                 }
                puck_list.add(g);
            }
        }
      
        
        
        //sort,early to late
        Puck.sort(puck_list);
        return puck_list;
    }

    /**
     *
     * @param path
     * @return
     * @throws Exception
     */
    public static List<Ticket> load_tickets(String path, List<Puck> p_list) throws Exception {
        //create list
        List<Ticket> ticket_list = new ArrayList<>();

        //load file
        CsvReader in = new CsvReader(path);

        //read by line
        in.readHeaders();
        while (in.readRecord()) {
            Ticket t = new Ticket(in.get(0), in.get(1), in.get(2), in.get(3), in.get(4), in.get(5), p_list);
            ticket_list.add(t);
        }
        return ticket_list;
    }

}
