A movie theater gave you two tables: seats that are available for an upcoming screening and neighboring seats for each seat listed. You are asked to find all pairs of seats that are both adjacent and available.
Output only distinct pairs of seats in two columns such that the seat with the lower number is always in the first column and the one with the higher number is in the second column.


WITH adjacent_seats AS
  (SELECT seat_number AS seat,
          seat_left AS adj_seat
   FROM theater_seatmap
   UNION SELECT seat_number AS seat,
                seat_right AS adj_seat
   FROM theater_seatmap)
   
   select seat as x1, adj_seat as x2
   from  adjacent_seats  s1
   join theater_availability a1 on s1.seat = a1.seat_number
   join theater_availability a2 on s1.adj_seat = a2.seat_number
   where a1.is_available and a2.is_available and seat < adj_seat
