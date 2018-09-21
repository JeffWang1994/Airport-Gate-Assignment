/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package flightassignment;

import com.csvreader.*;
import java.io.*;
import java.util.*;

/**
 *
 * @author happy
 */
public class Output {

    public static void output_puck(String file, List<Puck> puck_list) throws Exception {
        PrintStream out = new PrintStream(file);
        for (int i = 0; i < puck_list.size(); i++) {
            Puck p = puck_list.get(i);
            String gate = "";
            if (p.getGate() > 28) {
                gate = "S" + String.valueOf(p.getGate() - 28);
            } else {
                gate = "T" + String.valueOf(p.getGate());
            }
            out.printf("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n", p.getPuck_id(), p.getArrive_date_str(), p.getArrive_time(), p.getArrive_airport(), p.getArrive_type_str(), p.getPlane_size_str(), p.getDepart_date_str(), p.getDepart_time(), p.getDepart_airport(), p.getDepart_type_str(), p.getUp_info(), p.getDown_info(), gate);
        }
        System.out.println("save " + file + " successfully.");
        out.close();

    }

    public static void change_formula(String in_path, String out_path) throws Exception {
        List<Puck> p_list = Input.load_pucks("pucks.csv");

        PrintStream out = new PrintStream(out_path);

        //load file
        CsvReader in = new CsvReader(in_path);

        //read by line
        in.readHeaders();
        while (in.readRecord()) {
            int arrive_time = Integer.parseInt(in.get(2));
            int depart_time = Integer.parseInt(in.get(7));
            String arrive_airport = in.get(3).substring(1,in.get(3).length()-1);
            String depart_airport = in.get(8).substring(1,in.get(8).length()-1);
            int gate_id = Integer.parseInt(in.get(12));
            String gate = "";
            if (gate_id > 28) {
                gate = "S" + String.valueOf(gate_id - 28);
            } else {
                gate = "T" + String.valueOf(gate_id);
            }

            for (int i = 0; i < p_list.size(); i++) {
                Puck p = p_list.get(i);
                if ((p.getArrive_time() == arrive_time || p.getDepart_time() == depart_time) && p.getArrive_airport().equals(arrive_airport) && p.getDepart_airport().equals(depart_airport)) {
                    out.printf("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n", p.getPuck_id(), p.getArrive_date_str(), p.getArrive_time(), p.getArrive_airport(), p.getArrive_type_str(), p.getPlane_size_str(), p.getDepart_date_str(), p.getDepart_time(), p.getDepart_airport(), p.getDepart_type_str(), p.getUp_info(), p.getDown_info(), gate);
                }
            }
        }
        System.out.println("save " + out_path + " successfully.");
        out.close();

    }
}
