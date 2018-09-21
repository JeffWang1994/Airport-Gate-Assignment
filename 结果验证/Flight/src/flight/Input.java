/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package flight;
import java.util.*;
import java.text.SimpleDateFormat;
import com.csvreader.*;
/**
 *
 * @author happy
 */
public class Input {
    
    public static List<Gate> loadGates(){
        
        List<Gate> gate_list=new ArrayList<>();
        
        try {
            // 创建CSV读对象
            CsvReader csvReader = new CsvReader("gates.csv");

            // 读表头
            csvReader.readHeaders();
            while (csvReader.readRecord()){
                
                // 读一整行
                //System.out.println(csvReader.getRawRecord());
                // 读这行的某一列
                Gate g=new Gate(csvReader.get(0),csvReader.get(1),csvReader.get(2),csvReader.get(3),csvReader.get(4),csvReader.get(5));
                gate_list.add(g);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return gate_list;

    }
    
    public static List<Puck> loadPuck(){
        List<Puck> puck_list=new ArrayList<>();
        
        try {
            // 创建CSV读对象
            CsvReader csvReader = new CsvReader("puck.csv");

            SimpleDateFormat f=new SimpleDateFormat("HH:mm");
            // 读表头
            csvReader.readHeaders();
            while (csvReader.readRecord()){
                
                // 读一整行
                //System.out.println(csvReader.getRawRecord());
                // 读这行的某一列
                Puck p=new Puck(csvReader.get(0),f.parse(csvReader.get(2)),csvReader.get(4),csvReader.get(5),f.parse(csvReader.get(7)),csvReader.get(9));
                puck_list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return puck_list;
    }
    
}
