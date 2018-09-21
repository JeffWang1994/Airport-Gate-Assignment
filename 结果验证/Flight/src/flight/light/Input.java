/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package flight.light;

import com.csvreader.CsvReader;
import java.util.*;

/**
 *
 * @author happy
 */
public class Input {

    public static List<Flight> loadFlight() {
        List<Flight> flight_list = new ArrayList<>();

        try {
            // 创建CSV读对象
            CsvReader csvReader = new CsvReader("GA_Flight_3_2028.csv");

            // 读表头
            csvReader.readHeaders();
            while (csvReader.readRecord()) {

                // 读一整行
                //System.out.println(csvReader.getRawRecord());
                // 读这行的某一列
                Flight f = new Flight(csvReader.get(12), csvReader.get(2), csvReader.get(7));
                if (f.getGate_id() > 0) {
                    flight_list.add(f);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return flight_list;
    }

}
