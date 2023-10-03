
Find the average session distance travelled by Google Fit users based on GPS location data. Calculate the distance for two scenarios:



Taking into consideration the curvature of the earth

Taking into consideration the curvature of the earth as a flat surface


Assume one session distance is the distance between the biggest and the smallest step. If the session has only one step id, discard it from the calculation. Assume that session can't span over multiple days.
Output the average session distances calculated in the two scenarios and the difference between them.


Formula to calculate the distance with the curvature of the earth:



R = 6371R=6371

\phi_1 = lat_1 \times \frac{\pi}{180}ϕ 
1
​
 =lat 
1
​
 × 
180
π
​
 

\phi_2 = lat_2 \times \frac{\pi}{180}ϕ 
2
​
 =lat 
2
​
 × 
180
π
​
 

d = \arccos(\sin{\phi_1} \times \sin{\phi_2} + \cos{\phi_1} \times \cos{\phi_2} \times \cos{(longitude2 \times (π / 180) - longitude1 \times (π / 180))}) \times Rd=arccos(sinϕ 
1
​
 ×sinϕ 
2
​
 +cosϕ 
1
​
 ×cosϕ 
2
​
 ×cos(longitude2×(π/180)−longitude1×(π/180)))×R


Formula to calculate distance on a flat surface:



D = 111D=111

d = \sqrt{(lat_2-lat_1)^2 + (lon_2-lon_1)^2} \times Dd= 
(lat 
2
​
 −lat 
1
​
 ) 
2
 +(lon 
2
​
 −lon 
1
​
 ) 
2
 
​
 ×D
 
 
 
 select avg(distance_curvature) as avg_distance_curvature,
avg(distance_flat) as avg_distance_flat,
avg(distance_curvature) - avg(distance_flat) as distance_difference
from(
SELECT *,
          ACOS(SIN(RADIANS(latitude_1))*SIN(RADIANS(latitude_2)) + COS(radians(latitude_1))*COS(radians(latitude_2))*COS(radians(longitude_2 - longitude_1)))*6371 AS distance_curvature,
          sqrt((latitude_2-latitude_1)^2 +(longitude_2-longitude_1)^2)*111 AS distance_flat
from (
select 
             a1.user_id,
             a1.session_id,
             a1.day,
             a1.step_id,
             a1.latitude AS latitude_1,
             a1.longitude AS longitude_1,
             a2.step_id,
             a2.latitude AS latitude_2,
             a2.longitude AS longitude_2, 

rank()OVER (PARTITION BY 
                    a1.user_id,
                        a1.session_id,
                        a1.day
            ORDER BY a2.step_id-a1.step_id DESC) as step_rank

from google_fit_location a1 join google_fit_location a2 on a1.user_id = a2.user_id and a1.session_id = a2.session_id and a1.day = a2.day where a2.step_id > a1.step_id)k where step_rank = 1)o

