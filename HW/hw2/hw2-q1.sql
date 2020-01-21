-- q1:
.header on
.mode column

SELECT DISTINCT F.flight_num 
FROM FLIGHTS AS F, CARRIERS AS C, WEEKDAYS AS W
WHERE C.cid = F.carrier_id
AND W.did = F.day_of_week_id
AND C.name ='Alaska Airlines Inc.'
AND F.origin_city ='Seattle WA'
AND F.dest_city ='Boston MA'
AND W.day_of_week ='Friday';

-- flight_num
-- 12
-- 24
-- 734

--q2
SELECT
C.name,
F1.fid,
F1.origin_city,
F1.dest_city,
F2.fid,
F2.origin_city,
F2.dest_city,
F1.actual_time,
F2.actual_time,
F1.actual_time + F2.actual_time AS total_time
FROM FLIGHTS AS F1 
JOIN FLIGHTS AS F2 ON F1.dest_city = F2.origin_city
AND F1.month_id = F2.month_id
AND F1.day_of_month = F2.day_of_month
AND F1.carrier_id = F2.carrier_id
JOIN WEEKDAYS AS W ON F1.day_of_week_id = W.did
JOIN MONTHS AS M ON F1.month_id = M.mid
JOIN CARRIERS AS C ON F1.carrier_id = C.cid
WHERE F1.origin_city = 'Boston MA'
AND F2.dest_city = 'Seattle WA'
AND F1.day_of_month = 4
AND M.months = 'July'
AND total_time < 480
--q3
SELECT day_of_week, AVG(F.arrival_delay) arrival_delay FROM FLIGHTS F
JOIN WEEKDAYS W ON W.did = F.day_of_week_id
GROUP BY W.did
ORDER BY arrival_delay DESC
LIMIT 1;
-- Friday|14.4725010477787
--Q4

SELECT DISTINCT C.name
FROM FLIGHTS AS F
JOIN MONTHS M ON M.mid = F.month_id
JOIN CARRIERS AS C ON C.cid = f.carrier_id
GROUP BY f.day_of_month,M.months,C.name
HAVING COUNT(*)>1000;
/*
American Airlines Inc.
Comair Inc.
Delta Air Lines Inc.
Envoy Air
ExpressJet Airlines Inc.
ExpressJet Airlines Inc. (1)
JetBlue Airways
Northwest Airlines Inc.
SkyWest Airlines Inc.
Southwest Airlines Co.
US Airways Inc.
United Air Lines Inc.
*/
--Q5
SELECT C.name, AVG(F.canceled) cancle_per
FROM FLIGHTS AS F
JOIN CARRIERS C ON C.cid = F.carrier_id
WHERE F.origin_city = 'Seattle WA'
GROUP BY C.cid HAVING cancle_per >0.006
ORDER BY cancle_per ASC;
/*
SkyWest Airlines Inc.|0.00728291316526611
Frontier Airlines Inc.|0.00840336134453781
United Air Lines Inc.|0.00983767830791933
JetBlue Airways|0.0100250626566416
Northwest Airlines Inc.|0.014336917562724
ExpressJet Airlines Inc.|0.032258064516129
*/

--q6
SELECT C.name, MIN(F1.price) min_price
FROM FLIGHTS AS F1 
JOIN CARRIERS AS C ON C.cid = F1.carrier_id
WHERE (F1.dest_city = 'Seattle WA' AND F1.origin_city ='New York NY')
OR (F1.dest_city = 'New York NY' AND F1.origin_city ='Seattle WA')
GROUP BY C.name;
/*
American Airlines Inc.|114
Delta Air Lines Inc.|107
JetBlue Airways|101
*/
-- Q7
SELECT SUM(F.capacity)
FROM FLIGHTS AS F
JOIN MONTHS AS M ON F.month_id = M.mid
WHERE (F.dest_city = 'Seattle WA' AND F.origin_city ='San Francisco CA')
OR (F.dest_city = 'San Francisco CA' AND F.origin_city ='Seattle WA')
AND F.day_of_month = 11
AND M.months = 'July';
/*11004*/