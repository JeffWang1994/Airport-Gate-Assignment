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
public class Eval {

    /**
     *
     * @param gate_list
     */
    public static void eval(List<Gate> gate_list) {

        int width_count_broad_num = 0;
        double width_avg_spent_time = 0;
        int narrow_count_broad_num = 0;
        double narrow_avg_spent_time = 0;
        
        int s_gate_count=0;
        int t_gate_count=0;
        double s_gate_time=0;
        double t_gate_time=0;

        for (int i = 0; i < gate_list.size(); i++) {
            List<Puck> puck_list = gate_list.get(i).getPuck_record();

            double spent_time = 0;
            for (int j = 0; j < puck_list.size(); j++) {
                Puck p = puck_list.get(j);
                int depart = p.getDepart_time();
                int arrive = p.getArrive_time();
                if (depart < 24 * 60) {
                    depart = 24 * 60;
                }
                if (depart > 48 * 60) {
                    depart = 48 * 60;
                }
                if (arrive < 24 * 60) {
                    arrive = 24 * 60;
                }
                if (arrive > 48 * 60) {
                    arrive = 48 * 60;
                }
                spent_time = spent_time + depart - arrive;
            }
            spent_time = spent_time / 60;
            System.out.println("gate id=" + gate_list.get(i).getBroad_id() + ", spent hours= " + spent_time);
            if (gate_list.get(i).getPlane_size() == Input.PLANE_SIZE_LARGE) {
                if (spent_time != 0) {
                    width_count_broad_num = width_count_broad_num + 1;
                }
                width_avg_spent_time = width_avg_spent_time + spent_time;

            } else {
                if (spent_time != 0) {
                    narrow_count_broad_num = narrow_count_broad_num + 1;
                }
                narrow_avg_spent_time = narrow_avg_spent_time + spent_time;

            }
            if(gate_list.get(i).getBroad_id()<=28){
                if(spent_time !=0){
                    t_gate_count=t_gate_count+1;
                }
                t_gate_time=t_gate_time+spent_time;
            }else{
                if(spent_time !=0){
                    s_gate_count=s_gate_count+1;
                }
                s_gate_time=s_gate_time+spent_time;
            }
        }
        System.out.println("width gate: used gate number=" + width_count_broad_num);
        System.out.println("width gate: average spent time percent=" + width_avg_spent_time / (width_count_broad_num)+" /24");
        System.out.println("narrow gate: used gate number=" + narrow_count_broad_num);
        System.out.println("narrow gate: average spent time percent=" + narrow_avg_spent_time / (narrow_count_broad_num)+" /24");
         System.out.println("t gate: used gate number=" + t_gate_count);
        System.out.println("t gate: average spent time percent=" + t_gate_time / (t_gate_count)+" /24");
        System.out.println("s gate: used gate number=" + s_gate_count);
        System.out.println("s gate: average spent time percent=" + s_gate_time / (s_gate_count)+" /24");
    }

    public static void eval_swift_2(List<Ticket> ticket_list) {

        Map<Integer, Integer> freq_map = new HashMap<>();
        Map<Integer, Integer> nerve_map = new HashMap<>();

        int success_swift_count = 0;
        int total_count = 0;

        Greedy g = new Greedy();
        int[][][][] pass_list = g.init_pass_time_table();
        for (int i = 0; i < ticket_list.size(); i++) {
            Ticket ticket = ticket_list.get(i);
            int depart = ticket.getNext_flight_depart_time();
            int arrive = ticket.getLast_flight_arrive_time();

            Puck depart_puck = ticket.getDepart_puck();
            Puck arrive_puck = ticket.getArrive_puck();
            if (depart_puck == null || arrive_puck == null || arrive_puck.getGate_instance() == null || depart_puck.getGate_instance() == null) {
                continue;
            }
            //pass distance
            int pass_minute = pass_list[arrive_puck.getArrive_type()][arrive_puck.getGate_instance().getBroad_type()][depart_puck.getDepart_type()][depart_puck.getGate_instance().getBroad_type()];
            //System .out.println("ticket="+ticket.getTicket_id()+", time="+(depart-arrive)+", from puck="+arrive_puck.getPuck_id()+", to puck="+depart_puck.getPuck_id());
            Integer freq = freq_map.get(pass_minute / 5);
            if (freq == null) {
                freq_map.put(pass_minute / 5, ticket.getPeople_num());
            } else {
                freq_map.replace(pass_minute / 5, freq, freq + ticket.getPeople_num());
            }

            //nerve
            double nerve = (double) pass_minute / (double) (depart - arrive);
            int nerve_grid = (int) Math.floor(nerve / 0.1);
            //nerve freq
            Integer nerve_freq = nerve_map.get(nerve_grid);
            if (nerve_freq == null) {
                nerve_map.put(nerve_grid, ticket.getPeople_num());
            } else {
                nerve_map.replace(nerve_grid, nerve_freq, nerve_freq + ticket.getPeople_num());
            }

            //judge
            if ((depart - arrive) > pass_minute) {
                success_swift_count = success_swift_count + ticket.getPeople_num();
            }
            total_count = total_count + ticket.getPeople_num();
        }
        System.out.println("the success swift people number=" + success_swift_count + ", total people =" + total_count + ", rate=" + success_swift_count / total_count);
        System.out.println("the freq map=" + freq_map);
        System.out.println("the nerve map=" + nerve_map);
    }

    public static void eval_swift_3(List<Ticket> ticket_list) {

        Map<Integer, Integer> freq_map = new HashMap<>();
        Map<Integer, Integer> nerve_map = new HashMap<>();

        int success_swift_count = 0;
        int total_count = 0;

        Greedy g = new Greedy();
        int[][][][] pass_list = g.init_pass_time_table();
        int[][][][] walk_list = g.init_walk_time();
        int[][][][] car_list = g.init_car_time_table();
        for (int i = 0; i < ticket_list.size(); i++) {
            Ticket ticket = ticket_list.get(i);
            int depart = ticket.getNext_flight_depart_time();
            int arrive = ticket.getLast_flight_arrive_time();

            Puck depart_puck = ticket.getDepart_puck();
            Puck arrive_puck = ticket.getArrive_puck();
            if (depart_puck == null || arrive_puck == null || arrive_puck.getGate_instance() == null || depart_puck.getGate_instance() == null) {
                continue;
            }
            //pass distance
            int pass_minute = pass_list[arrive_puck.getArrive_type()][arrive_puck.getGate_instance().getBroad_type()][depart_puck.getDepart_type()][depart_puck.getGate_instance().getBroad_type()];
            int car_minute = car_list[arrive_puck.getArrive_type()][arrive_puck.getGate_instance().getBroad_type()][depart_puck.getDepart_type()][depart_puck.getGate_instance().getBroad_type()];
            int walk_minute = walk_list[arrive_puck.getGate_instance().getBroad_type()][arrive_puck.getGate_instance().getArea()][depart_puck.getGate_instance().getBroad_type()][depart_puck.getGate_instance().getArea()];

            int cost = pass_minute + car_minute + walk_minute;
            //judge
            if ((depart - arrive) > (cost)) {
                success_swift_count = success_swift_count + ticket.getPeople_num();
            }

            //freq
            Integer freq = freq_map.get(cost / 5);
            if (freq == null) {
                freq_map.put(cost / 5, ticket.getPeople_num());
            } else {
                freq_map.replace(cost / 5, freq, freq + ticket.getPeople_num());
            }
            //nerve
            double nerve = (double) cost / (double) (depart - arrive);
            int nerve_grid = (int) Math.floor(nerve / 0.1);
            //nerve freq
            Integer nerve_freq = nerve_map.get(nerve_grid);
            if (nerve_freq == null) {
                nerve_map.put(nerve_grid, ticket.getPeople_num());
            } else {
                nerve_map.replace(nerve_grid, nerve_freq, nerve_freq + ticket.getPeople_num());
            }

            total_count = total_count + ticket.getPeople_num();
        }
        System.out.println("the success swift people number=" + success_swift_count + ", total people =" + total_count + ", rate=" + success_swift_count / total_count);
        System.out.println("the freq map=" + freq_map);
        System.out.println("the nerve map=" + nerve_map);
    }
    
    public static void count_temp(List<Puck> g){
        int width_num=0;
        int narr_num=0;
        for(int i=0;i<g.size();i++){
            if(g.get(i).getPlane_size()==Input.PLANE_SIZE_LARGE){
                width_num=width_num+1;
            }else{
                narr_num=narr_num+1;
            }
        }
        System.out.println("width plane in temp = "+width_num+", narrow plane in temp = "+narr_num );
    }
    
    
    
   

}
