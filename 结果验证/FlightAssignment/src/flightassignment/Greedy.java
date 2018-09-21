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
public class Greedy {

    //some arguments
    final private int buffer_time = 45;

    //pass time, the first index is travel type, dominate is 1, international is 0
    // the second index is broad type, T is 0 ,S is 1
    //  IT , IS, DT, DS == 00 ,01, 10, 11
    //in minutes
    final private int[][][][] pass_time = new int[2][2][2][2];
    //car time
    final private int[][][][] car_time = new int[2][2][2][2];
    //walk time
    //the first index is T and S, the second index is orient(south,north,...)
    final private int[][][][] walk_time = new int[2][4][2][4];

    //........................................................................................................................
    //case one
    //.......................................................................................................................
    /**
     *
     * @param gate_list
     * @param puck_list
     * @param temp_gate
     */
    public void case_one(List<Gate> gate_list, List<Puck> puck_list, List<Puck> temp_gate) {
        //park all the planes
        for (int i = 0; i < puck_list.size(); i++) {
            Puck p = puck_list.get(i);
            System.out.println("process puck :" + p.getPuck_id() + " ,arrival type=" + p.getArrive_type() + " ,depart type=" + p.getDepart_type() + ", size=" + p.getPlane_size() + " ........................");
            //search all the gates to find the most small idle
            int shortest_idle = Integer.MAX_VALUE;
            int shortest_index = -1;
            for (int j = 0; j < gate_list.size(); j++) {
                //judge can park
                if (this.can_park(p, gate_list.get(j)) == false) {
                    continue;
                }
                //calculate idle
                int idle = p.getArrive_time() - gate_list.get(j).getNextDepartTime();
                System.out.println("search ...  gate=" + gate_list.get(j).getBroad_id() + " ,idle time=" + idle + ", this puck arrival=" + p.getArrive_time() + ", last depart=" + gate_list.get(j).getNextDepartTime() + ", last flight=" + gate_list.get(j).getLastPlaneId());
                //idle is enough, allow park, to find the shortest idle
                if (idle > this.buffer_time) {
                    //compare
                    if (idle < shortest_idle) {
                        shortest_idle = idle;
                        shortest_index = j;
                        System.out.println("current shortest idle time=" + shortest_idle);
                    }
                } else {
                    //if idle < 0, means the park is not available here
                }
            }
            System.out.println("choose =" + shortest_index);
            //found and park
            if (shortest_index >= 0) {
                gate_list.get(shortest_index).park(p);
                p.setGate(gate_list.get(shortest_index).getBroad_id());
                p.setGate_instance(gate_list.get(shortest_index));
            } else {
                //if no place, park in the temporary 
                temp_gate.add(p);
                p.setGate(0);
            }

        }
    }

    /**
     * judge the plane can park or not by fly type and size
     *
     * @param p
     * @param g
     * @return
     */
    public boolean can_park(Puck p, Gate g) {
        //System.out.println("judge can park, gate id="+g.getBroad_id()+" ,arrive type="+p.getArrive_type()+", depart type="+p.getDepart_type()+", size="+p.getPlane_size()+" <=====> gate arrive type="+g.getArrive_type()+", gate depart type="+g.getDepart_type()+", gate size="+g.getPlane_size());
        //size
        if (p.getPlane_size() == g.getPlane_size()) {
            //arrival type
            if (p.getArrive_type() == g.getArrive_type() || g.getArrive_type() == Input.ARRIVE_TYPE_BOTH) {
                //depart type
                if (p.getDepart_type() == g.getDepart_type() || g.getDepart_type() == Input.ARRIVE_TYPE_BOTH) {
                    return true;
                }
            }
        }
        return false;
    }

    //........................................................................................................................
    //case two
    //.......................................................................................................................
    public void case_two(List<Gate> gate_list, List<Puck> puck_list, List<Puck> temp_gate) {
        //park all the planes
        for (int i = 0; i < puck_list.size(); i++) {
            Puck p = puck_list.get(i);
            System.out.println("process puck :" + p.getPuck_id() + " ,arrival type=" + p.getArrive_type() + " ,depart type=" + p.getDepart_type() + ", size=" + p.getPlane_size() + " ........................");
            //search all the gates to find the most small idle
            double shortest_cost = Integer.MAX_VALUE;
            int shortest_index = -1;
            for (int j = 0; j < gate_list.size(); j++) {
                //judge can park
                if (this.can_park(p, gate_list.get(j)) == false) {
                    continue;
                }
                //calculate idle
                int idle = p.getArrive_time() - gate_list.get(j).getNextDepartTime();
                System.out.println("search ...  gate=" + gate_list.get(j).getBroad_id() + " ,idle time=" + idle + ", this puck arrival=" + p.getArrive_time() + ", last depart=" + gate_list.get(j).getNextDepartTime() + ", last flight=" + gate_list.get(j).getLastPlaneId());

                //idle is enough, allow park, to find the shortest cost, both idle and pass time
                if (idle > this.buffer_time) {
                    //calculate the average pass time
                    double avg = this.avg_pass_time(p, gate_list.get(j));
                    double cost = idle + 20 * avg;
                    //compare
                    if (cost < shortest_cost) {
                        shortest_cost = cost;
                        shortest_index = j;
                        System.out.println("  current shortest cost =" + shortest_cost + ", idle=" + idle + ", pass time=" + avg);
                    }
                } else {
                    //if idle < 0, means the park is not available here
                }
            }
            //found and park
            if (shortest_index >= 0) {
                gate_list.get(shortest_index).park(p);
                p.setGate(gate_list.get(shortest_index).getBroad_id());
                p.setGate_instance(gate_list.get(shortest_index));
                System.out.println("choose gate =" + gate_list.get(shortest_index).getBroad_id());
            } else {
                //if no place, park in the temporary 
                temp_gate.add(p);
                p.setGate(0);
                System.out.println("choose temp");
            }
        }
    }

    public int[][][][] init_pass_time_table() {
        //00->00 IT->IT
        this.pass_time[0][0][0][0] = 20;
        //00->01 IT->IS
        this.pass_time[0][0][0][1] = 30;
        //IT ->DT
        this.pass_time[0][0][1][0] = 35;
        //IT->DS
        this.pass_time[0][0][1][1] = 40;
        //IS ->IT
        this.pass_time[0][1][0][0] = 30;
        //IS ->IS 
        this.pass_time[0][1][0][1] = 20;
        //IS->DT
        this.pass_time[0][1][1][0] = 40;
        //IS->DS
        this.pass_time[0][1][1][1] = 45;
        //DT->IT
        this.pass_time[1][0][0][0] = 35;
        //DT->IS
        this.pass_time[1][0][0][1] = 40;
        //DT->DT
        this.pass_time[1][0][1][0] = 15;
        //DT->DS
        this.pass_time[1][0][1][1] = 20;
        //DS->IT
        this.pass_time[1][1][0][0] = 40;
        //DS->IS
        this.pass_time[1][1][0][1] = 35;
        //DS->DT
        this.pass_time[1][1][1][0] = 20;
        //DS->DS
        this.pass_time[1][1][1][1] = 15;

        return this.pass_time;
    }

    /**
     * calculate the average of all the swift passengers from puck p in the gate
     * g
     *
     * @param to_g
     * @param p
     * @return
     */
    public double avg_pass_time(Puck p, Gate to_g) {
        //init pass time table
        this.init_pass_time_table();

        //get swift from list
        Map<Puck, Integer> from_map = p.getSwift_map();
        //calculate the average
        double avg = 0;
        int count = 0;
        for (Map.Entry<Puck, Integer> e : from_map.entrySet()) {
            Puck from_p = e.getKey();
            Gate from_g = e.getKey().getGate_instance();
            if (from_g == null) {
                continue;
            }
            int num = e.getValue();
            avg = avg + num * this.pass_time[from_p.getArrive_type()][from_g.getBroad_type()][p.getDepart_type()][to_g.getBroad_type()];
            count = count + num;
        }
        if (count == 0) {
            return avg;
        } else {
            return avg / count;
        }
    }

    //...................................................................................................
    //case 3
    //...................................................................................................
    public void case_three(List<Gate> gate_list, List<Puck> puck_list, List<Puck> temp_gate) {
        //park all the planes
        for (int i = 0; i < puck_list.size(); i++) {
            Puck p = puck_list.get(i);
            System.out.println("process puck :" + p.getPuck_id() + " ,arrival type=" + p.getArrive_type() + " ,depart type=" + p.getDepart_type() + ", size=" + p.getPlane_size() + " ........................");
            //search all the gates to find the most small idle
            double shortest_cost = Integer.MAX_VALUE;
            int shortest_index = -1;
            for (int j = 0; j < gate_list.size(); j++) {
                //judge can park
                if (this.can_park(p, gate_list.get(j)) == false) {
                    continue;
                }
                //calculate idle
                int idle = p.getArrive_time() - gate_list.get(j).getNextDepartTime();
                System.out.println("search ...  gate=" + gate_list.get(j).getBroad_id() + " ,idle time=" + idle + ", this puck arrival=" + p.getArrive_time() + ", last depart=" + gate_list.get(j).getNextDepartTime() + ", last flight=" + gate_list.get(j).getLastPlaneId());

                //idle is enough, allow park, to find the shortest cost, both idle and pass time
                if (idle > this.buffer_time) {
                    //calculate the average pass time
                    double avg_pass = this.avg_pass_time(p, gate_list.get(j));
                    double avg_car=this.avg_car_time(p, gate_list.get(j));
                    double avg_walk=this.avg_walk_time(p, gate_list.get(j));
                    double cost = idle + 20 * (avg_pass+avg_car+avg_walk);
                    //compare
                    if (cost < shortest_cost) {
                        shortest_cost = cost;
                        shortest_index = j;
                        System.out.println("  current shortest cost =" + shortest_cost + ", idle=" + idle + ", pass time=" + avg_pass+", cae time="+avg_car+" ,walk time="+avg_walk);
                    }
                } else {
                    //if idle < 0, means the park is not available here
                }
            }
            //found and park
            if (shortest_index >= 0) {
                gate_list.get(shortest_index).park(p);
                p.setGate(gate_list.get(shortest_index).getBroad_id());
                p.setGate_instance(gate_list.get(shortest_index));
                System.out.println("choose gate =" + gate_list.get(shortest_index).getBroad_id());
            } else {
                //if no place, park in the temporary 
                temp_gate.add(p);
                p.setGate(0);
                System.out.println("choose temp");
            }
        }
    }

    /**
     *
     * @param p
     * @param to_g
     * @return
     */
    public double avg_car_time(Puck p, Gate to_g) {
        this.init_car_time_table();
        //get swift from list
        Map<Puck, Integer> from_map = p.getSwift_map();

        double avg = 0;
        int count = 0;
        for (Map.Entry<Puck, Integer> e : from_map.entrySet()) {
            Puck from_p = e.getKey();
            Gate from_g = from_p.getGate_instance();
            if (from_g == null) {
                continue;
            }

            int num = e.getValue();
            avg = avg + num * this.car_time[from_p.getArrive_type()][from_g.getBroad_type()][p.getDepart_type()][to_g.getBroad_type()] * 8;
            count = count + num;
        }
        if (count == 0) {
            return avg;
        } else {
            return avg / count;
        }

    }

    /**
     *
     * @param p
     * @param to_g
     */
    public double avg_walk_time(Puck p, Gate to_g) {

        this.init_walk_time();

        Map<Puck, Integer> from_map = p.getSwift_map();

        double avg = 0;
        int count = 0;
        for (Map.Entry<Puck, Integer> e : from_map.entrySet()) {
            Puck from_p = e.getKey();
            Gate from_g = from_p.getGate_instance();
            if (from_g == null) {
                continue;
            }
            int num = e.getValue();
            avg = avg + num * this.walk_time[from_g.getBroad_type()][from_g.getArea()][to_g.getBroad_type()][to_g.getArea()];
            count = count + num;

        }
         if (count == 0) {
            return avg;
        } else {
            return avg / count;
        }
    }

    /**
     *
     * @return
     */
    public int[][][][] init_car_time_table() {
        //00->00 IT->IT
        this.pass_time[0][0][0][0] = 0;
        //00->01 IT->IS
        this.pass_time[0][0][0][1] = 1;
        //IT ->DT
        this.pass_time[0][0][1][0] = 0;
        //IT->DS
        this.pass_time[0][0][1][1] = 1;
        //IS ->IT
        this.pass_time[0][1][0][0] = 1;
        //IS ->IS 
        this.pass_time[0][1][0][1] = 0;
        //IS->DT
        this.pass_time[0][1][1][0] = 1;
        //IS->DS
        this.pass_time[0][1][1][1] = 2;
        //DT->IT
        this.pass_time[1][0][0][0] = 0;
        //DT->IS
        this.pass_time[1][0][0][1] = 1;
        //DT->DT
        this.pass_time[1][0][1][0] = 0;
        //DT->DS
        this.pass_time[1][0][1][1] = 1;
        //DS->IT
        this.pass_time[1][1][0][0] = 1;
        //DS->IS
        this.pass_time[1][1][0][1] = 0;
        //DS->DT
        this.pass_time[1][1][1][0] = 1;
        //DS->DS
        this.pass_time[1][1][1][1] = 0;
        return this.car_time;
    }

    public int[][][][] init_walk_time() {
        //T=0,S=1,  / north=0 sorth=2, east =2, center=3
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_NORTH][Input.BOARD_TYPE_T][Input.AREA_NORTH] = 10;
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_NORTH][Input.BOARD_TYPE_T][Input.AREA_CENTER] = 15;
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_NORTH][Input.BOARD_TYPE_T][Input.AREA_SOUTH] = 20;
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_NORTH][Input.BOARD_TYPE_S][Input.AREA_NORTH] = 25;
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_NORTH][Input.BOARD_TYPE_S][Input.AREA_CENTER] = 20;
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_NORTH][Input.BOARD_TYPE_S][Input.AREA_SOUTH] = 25;
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_NORTH][Input.BOARD_TYPE_S][Input.AREA_EAST] = 25;
        //..
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_CENTER][Input.BOARD_TYPE_T][Input.AREA_NORTH] = 15;
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_CENTER][Input.BOARD_TYPE_T][Input.AREA_CENTER] = 10;
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_CENTER][Input.BOARD_TYPE_T][Input.AREA_SOUTH] = 15;
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_CENTER][Input.BOARD_TYPE_S][Input.AREA_NORTH] = 20;
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_CENTER][Input.BOARD_TYPE_S][Input.AREA_CENTER] = 15;
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_CENTER][Input.BOARD_TYPE_S][Input.AREA_SOUTH] = 20;
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_CENTER][Input.BOARD_TYPE_S][Input.AREA_EAST] = 20;
        //
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_SOUTH][Input.BOARD_TYPE_T][Input.AREA_NORTH] = 20;
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_SOUTH][Input.BOARD_TYPE_T][Input.AREA_CENTER] = 15;
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_SOUTH][Input.BOARD_TYPE_T][Input.AREA_SOUTH] = 10;
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_SOUTH][Input.BOARD_TYPE_S][Input.AREA_NORTH] = 25;
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_SOUTH][Input.BOARD_TYPE_S][Input.AREA_CENTER] = 20;
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_SOUTH][Input.BOARD_TYPE_S][Input.AREA_SOUTH] = 25;
        this.walk_time[Input.BOARD_TYPE_T][Input.AREA_SOUTH][Input.BOARD_TYPE_S][Input.AREA_EAST] = 25;
        //
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_NORTH][Input.BOARD_TYPE_T][Input.AREA_NORTH] = 25;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_NORTH][Input.BOARD_TYPE_T][Input.AREA_CENTER] = 20;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_NORTH][Input.BOARD_TYPE_T][Input.AREA_SOUTH] = 25;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_NORTH][Input.BOARD_TYPE_S][Input.AREA_NORTH] = 10;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_NORTH][Input.BOARD_TYPE_S][Input.AREA_CENTER] = 15;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_NORTH][Input.BOARD_TYPE_S][Input.AREA_SOUTH] = 20;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_NORTH][Input.BOARD_TYPE_S][Input.AREA_EAST] = 20;
        //
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_CENTER][Input.BOARD_TYPE_T][Input.AREA_NORTH] = 20;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_CENTER][Input.BOARD_TYPE_T][Input.AREA_CENTER] = 15;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_CENTER][Input.BOARD_TYPE_T][Input.AREA_SOUTH] = 20;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_CENTER][Input.BOARD_TYPE_S][Input.AREA_NORTH] = 15;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_CENTER][Input.BOARD_TYPE_S][Input.AREA_CENTER] = 10;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_CENTER][Input.BOARD_TYPE_S][Input.AREA_SOUTH] = 15;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_CENTER][Input.BOARD_TYPE_S][Input.AREA_EAST] = 15;
        //
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_SOUTH][Input.BOARD_TYPE_T][Input.AREA_NORTH] = 25;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_SOUTH][Input.BOARD_TYPE_T][Input.AREA_CENTER] = 20;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_SOUTH][Input.BOARD_TYPE_T][Input.AREA_SOUTH] = 25;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_SOUTH][Input.BOARD_TYPE_S][Input.AREA_NORTH] = 20;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_SOUTH][Input.BOARD_TYPE_S][Input.AREA_CENTER] = 15;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_SOUTH][Input.BOARD_TYPE_S][Input.AREA_SOUTH] = 10;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_SOUTH][Input.BOARD_TYPE_S][Input.AREA_EAST] = 20;
        // 
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_EAST][Input.BOARD_TYPE_T][Input.AREA_NORTH] = 25;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_EAST][Input.BOARD_TYPE_T][Input.AREA_CENTER] = 20;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_EAST][Input.BOARD_TYPE_T][Input.AREA_SOUTH] = 25;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_EAST][Input.BOARD_TYPE_S][Input.AREA_NORTH] = 20;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_EAST][Input.BOARD_TYPE_S][Input.AREA_CENTER] = 15;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_EAST][Input.BOARD_TYPE_S][Input.AREA_SOUTH] = 20;
        this.walk_time[Input.BOARD_TYPE_S][Input.AREA_EAST][Input.BOARD_TYPE_S][Input.AREA_EAST] = 10;
        //
        return this.walk_time;
    }

}
