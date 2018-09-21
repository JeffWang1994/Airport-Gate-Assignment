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
public class Ticket {

    final private String ticket_id;
    final private int people_num;
    final private String arrive_airport;
    final private String arrive_date;
    final private String depart_airport;
    final private String depart_date;

    private int last_flight_arrive_time = 0;
    private int next_flight_depart_time = 0;

    private Puck depart_puck;
    private Puck arrive_puck;

    /**
     *
     * @param ticket_id
     * @param num
     * @param arr_airport
     * @param arr_date
     * @param depart_airport
     * @param depart_date
     */
    public Ticket(String ticket_id, String num, String arr_airport, String arr_date, String depart_airport, String depart_date, List<Puck> puck_list) {
        this.ticket_id = ticket_id;
        this.people_num = Integer.parseInt(num);
        this.arrive_airport = arr_airport;
        this.arrive_date = arr_date;
        this.depart_airport = depart_airport;
        this.depart_date = depart_date;

        //find flight time
        this.arrive_puck = Ticket.findPuckByArrivalAirportAndDate(puck_list, arr_airport, arr_date);
        this.depart_puck = Ticket.findPuckByDepartAirportAndDate(puck_list, depart_airport, depart_date);
        if (arrive_puck != null) {
            this.last_flight_arrive_time = arrive_puck.getArrive_time();
        }
        if (depart_puck != null) {
            this.next_flight_depart_time = depart_puck.getDepart_time();
        }
    }

    /**
     * @return the ticket_id
     */
    public String getTicket_id() {
        return ticket_id;
    }

    /**
     * @return the people_num
     */
    public int getPeople_num() {
        return people_num;
    }

    /**
     * @return the arrive_airport
     */
    public String getArrive_airport() {
        return arrive_airport;
    }

    /**
     * @return the arrive_date
     */
    public String getArrive_date() {
        return arrive_date;
    }

    /**
     * @return the depart_airport
     */
    public String getDepart_airport() {
        return depart_airport;
    }

    /**
     * @return the depart_date
     */
    public String getDepart_date() {
        return depart_date;
    }

    /**
     * @deprecated @param tick_list
     * @param puck_list
     */
    public static void add_swift(List<Ticket> tick_list, List<Puck> puck_list) {
        for (int i = 0; i < tick_list.size(); i++) {
            Ticket t = tick_list.get(i);
            Puck arrive_puck = Ticket.findPuckByArrivalAirportAndDate(puck_list, t.getArrive_airport(), t.getArrive_date());
            if (arrive_puck != null) {
                Puck depart_puck = Ticket.findPuckByDepartAirportAndDate(puck_list, t.depart_airport, t.depart_date);
                if (depart_puck != null) {
                    arrive_puck.addSwiftNumber(depart_puck, t.people_num);
                }
            }
        }
    }

    /**
     *
     * @param tick_list
     * @param puck_list
     */
    public static void add_swift_ex(List<Ticket> tick_list, List<Puck> puck_list) {
        for (int i = 0; i < tick_list.size(); i++) {
            Ticket t = tick_list.get(i);
            Puck depart_puck = Ticket.findPuckByDepartAirportAndDate(puck_list, t.getDepart_airport(), t.getDepart_date());
            if (depart_puck != null) {
                Puck arrive_puck = Ticket.findPuckByArrivalAirportAndDate(puck_list, t.arrive_airport, t.arrive_date);
                if (arrive_puck != null) {
                    depart_puck.addSwiftNumber(arrive_puck, t.people_num);
                }
            }
        }
    }

    /**
     *
     * @param puck_list
     * @param airport
     * @param date
     * @return
     */
    public static Puck findPuckByArrivalAirportAndDate(List<Puck> puck_list, String airport, String date) {
        for (int i = 0; i < puck_list.size(); i++) {
            Puck p = puck_list.get(i);
            if (airport.equals(p.getArrive_airport()) == true && date.equals(p.getArrive_date_str()) == true) {
                return p;
            }
        }
        return null;
    }

    /**
     *
     * @param puck_list
     * @param airport
     * @param date
     * @return
     */
    public static Puck findPuckByDepartAirportAndDate(List<Puck> puck_list, String airport, String date) {
        for (int i = 0; i < puck_list.size(); i++) {
            Puck p = puck_list.get(i);
            if (airport.equals(p.getDepart_airport()) == true && date.equals(p.getDepart_date_str()) == true) {
                return p;
            }
        }
        return null;
    }

    /**
     * @return the last_flight_arrive_time
     */
    public int getLast_flight_arrive_time() {
        return last_flight_arrive_time;
    }

    /**
     * @return the next_flight_depart_time
     */
    public int getNext_flight_depart_time() {
        return next_flight_depart_time;
    }

    /**
     * @return the depart_puck
     */
    public Puck getDepart_puck() {
        return depart_puck;
    }

    /**
     * @return the arrive_puck
     */
    public Puck getArrive_puck() {
        return arrive_puck;
    }

}
