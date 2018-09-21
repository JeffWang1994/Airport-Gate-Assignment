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
public class Env {

    public static void test_greedy_case_one() throws Exception {
        List<Gate> gate_list = Input.load_gates("gates.csv");
//        
//        for(int i=0;i<gate_list.size();i++){
//            System.out.println(gate_list.get(i).getArrive_type()+" "+gate_list.get(i).getBroad_id()+" "+gate_list.get(i).getBroad_type()+" "+gate_list.get(i).getDepart_type()+" "+gate_list.get(i).getPlane_size());
//        }
        List<Puck> puck_list = Input.load_pucks("pucks.csv");
        System.out.println(".......................");
        
       //  Eval.count_temp(puck_list);
         System.out.println(".......................");
//
//        for (int i = 0; i < puck_list.size(); i++) {
//            System.out.println(puck_list.get(i).getPuck_id()+" "+puck_list.get(i).getArrive_time()+" "+puck_list.get(i).getArrive_type()+" "+puck_list.get(i).getPlane_size()+" "+puck_list.get(i).getDepart_time()+" "+puck_list.get(i).getDepart_type());
//        }

        Greedy greedy = new Greedy();
        List<Puck> temp_puck = new ArrayList<>();
        
        greedy.case_one(gate_list, puck_list, temp_puck);
        System.out.println("temp gate number="+temp_puck.size());
        Eval.count_temp(temp_puck);
        for (int i = 0; i < gate_list.size(); i++) {
            Gate g = gate_list.get(i);
            List<Puck> rec = g.getPuck_record();
            System.out.println(g.getBroad_id() + "........................");
            for (int j = 0; j < rec.size(); j++) {
                System.out.print("[" + rec.get(j).getPuck_id() + ", " + rec.get(j).getArrive_time() + " " + rec.get(j).getDepart_time() + "]");
            }
            System.out.println();
        }

        //save
        Output.output_puck("greedy1.csv", puck_list);
        System.out.println("start evalution.......");
        //eval
        Eval.eval(gate_list);
    }

    public static void test_greedy_case_two() throws Exception {

        //load gate data and puck data
        List<Gate> gate_list = Input.load_gates("gates.csv");
        List<Puck> puck_list = Input.load_pucks("pucks.csv");

        //load ticket data and add 'swift from ' pucks 
        List<Ticket> t_list = Input.load_tickets("tickets.csv", puck_list);
        Ticket.add_swift_ex(t_list, puck_list);
        //show
//        for (int i = 0; i < puck_list.size(); i++) {
//            Map<Puck, Integer> swift = puck_list.get(i).getSwift_map();
//            System.out.println("puck id=" + puck_list.get(i).getPuck_id() + " ,depart airport=" + puck_list.get(i).getDepart_airport() + ", swift from......");
//            for (Map.Entry<Puck, Integer> e : swift.entrySet()) {
//                System.out.println("    arrive airport=" + e.getKey().getArrive_airport() + ", puck=" + e.getKey().getPuck_id() + " ,num =" + e.getValue());
//            }
//        }
        //greedy
        Greedy greedy=new Greedy();
        List<Puck> temp_puck = new ArrayList<>();
        greedy.case_two(gate_list, puck_list, temp_puck);
        System.out.println("temp gate = "+temp_puck.size());
        Eval.count_temp(temp_puck);
        
        //save
        Output.output_puck("greedy2.csv", puck_list);
         System.out.println("start evalution.......");
        //eval
        Eval.eval(gate_list);
        Eval.eval_swift_2(t_list);
    }

    public static void test_greedy_case_three() throws Exception {

        //load gate data and puck data
        List<Gate> gate_list = Input.load_gates("gates.csv");
        List<Puck> puck_list = Input.load_pucks("pucks.csv");

        //load ticket data and add 'swift from ' pucks 
        List<Ticket> t_list = Input.load_tickets("tickets.csv", puck_list);
        Ticket.add_swift_ex(t_list, puck_list);
        //show
//        for (int i = 0; i < puck_list.size(); i++) {
//            Map<Puck, Integer> swift = puck_list.get(i).getSwift_map();
//            System.out.println("puck id=" + puck_list.get(i).getPuck_id() + " ,depart airport=" + puck_list.get(i).getDepart_airport() + ", swift from......");
//            for (Map.Entry<Puck, Integer> e : swift.entrySet()) {
//                System.out.println("    arrive airport=" + e.getKey().getArrive_airport() + ", puck=" + e.getKey().getPuck_id() + " ,num =" + e.getValue());
//            }
//        }
        //greedy
        Greedy greedy=new Greedy();
        List<Puck> temp_puck = new ArrayList<>();
        greedy.case_three(gate_list, puck_list, temp_puck);
         System.out.println("temp gate = "+temp_puck.size());
        Eval.count_temp(temp_puck);
        
        //save
         Output.output_puck("greedy3.csv", puck_list);
          System.out.println("start evalution.......");
        //eval
        Eval.eval(gate_list);
        Eval.eval_swift_3(t_list);
    }

    public static void eval_genetic(int question)throws Exception{
         Output.change_formula("genetic_raw_"+question+".csv","genetic"+question+".csv");
           //load gate data and puck data
        List<Gate> gate_list = Input.load_gates("gates.csv");
        List<Puck> puck_list = Input.load_pucks("genetic"+question+".csv");
        
        //add gate instance, add puck record to gate
        for(int i=0;i<puck_list.size();i++){
            puck_list.get(i).addGateInstance(gate_list, puck_list.get(i).getGate());
            if(puck_list.get(i).getGate()==0) continue;
            gate_list.get(puck_list.get(i).getGate()-1).park(puck_list.get(i));
        }
        
        //load ticket data and add 'swift from ' pucks 
        List<Ticket> t_list = Input.load_tickets("tickets.csv", puck_list);
        Eval.eval(gate_list);
        Eval.eval_swift_2(t_list);
    }
    
    public static void eval_genetic_1()throws Exception{
        Env.eval_genetic(1);
    }
    public static void eval_genetic_2()throws Exception{
        Env.eval_genetic(2);
    }
    public static void eval_genetic_3()throws Exception{
        Env.eval_genetic(3);
    }
    
}
