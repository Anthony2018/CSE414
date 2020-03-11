-- /* problem 1*/
-- SELECT B.sum2 - A.sum1 + A.sum1/2 as num_connected_cities
-- FROM 
-- (SELECT count(*) as sum1 FROM
-- (
-- SELECT DISTINCT F1.origin_city, F1.dest_city,F2.origin_city, F2.dest_city
-- FROM FLIGHTS AS F1, (SELECT DISTINCT dest_city , origin_city FROM FLIGHTS) AS F2
-- WHERE F1.origin_city = F2.dest_city
-- AND F2.origin_city = F1.dest_city
-- )) AS A,
-- (SELECT count(*) as sum2 FROM
-- (
-- SELECT DISTINCT F1.origin_city, F1.dest_city
-- FROM FLIGHTS AS F1
-- )) AS B 
--- 2351

--problem 2
--SELECT COUNT(*) from (
-- select distinct f.origin_city, f.dest_city, f.actual_time
-- from Flights f 
-- JOIN (select origin_city, min(CASE WHEN[actual_time] = 0 THEN NULL ELSE [actual_time] END) min_time from Flights
-- Group by origin_city) c
-- ON c.origin_city = f.origin_city AND
-- f.actual_time = c.min_time
-- and f.canceled = 0
-- order by f.actual_time asc;
--

--PROBLRM 3
-- SELECT COUNT(*)from (
-- select distinct f.origin_city
-- from Flights f JOIN 
-- (select origin_city, max(actual_time) max from Flights
-- Group by origin_city) c
-- ON c.origin_city = f.origin_city AND
-- f.actual_time = c.max
-- where f.actual_time < 180.0
-- AND f.canceled = 0)

--problem 4
-- SELECT COUNT(*)from (
-- select distinct f.origin_city, (case when ct is null then 0
-- ELSE CAST (ct AS NUMERIC(10,2))*100 / CAST(COUNT(f.fid) AS NUMERIC(10,2)) END) AS percentage
-- from Flights f left JOIN(select origin_city, count(fid) ct from FLIGHTS 
-- WHERE actual_time < 180 OR (actual_time = NULL)
-- AND canceled = 0
-- Group by origin_city) c
-- ON c.origin_city = f.origin_city
-- GROUP BY F.origin_city,ct
-- ORDER BY percentage ASC
-- )

-- problem 5:
/*
List all cities that cannot be reached from Seattle though a direct flight
but can be reached with one stop (i.e., with any two flights that go through an intermediate city).
Do not include Seattle as one of these destinations (even though you could get back with two flights).
Name the output column city. Order the output ascending by city.*/
-- SELECT COUNT(*)from (
-- SELECT DISTINCT F2.dest_city 
-- FROM FLIGHTS AS F1 JOIN
-- (SELECT DISTINCT origin_city, dest_city FROM FLIGHTS
-- WHERE dest_city != 'Seattle WA'
-- AND dest_city NOT IN
-- (SELECT DISTINCT dest_city FROM FLIGHTS
-- WHERE origin_city = 'Seattle WA')
-- --Group by origin_city,dest_city
-- ) F2

-- ON F1.dest_city = F2.origin_city
-- WHERE F1.origin_city = 'Seattle WA'
-- --GROUP by F2.dest_city
-- ORDER BY F2.dest_city ASC
-- )

-- problem 6 
/*
(15 points)
List all cities that cannot be reached from Seattle through a direct flight
and cannot be reached from Seattle with one stop (i.e., with any two flights that go through an intermediate city).
Assume all cities to be the collection of both origin_city and dest_city.
Warning: this query might take a while to execute.
We will learn about how to speed this up in lecture.
Name the output column city. Order the output ascending by city.
*/

-- (
--     SELECT DISTINCT F2.dest_city as sum2
--     FROM FLIGHTS AS F1 JOIN
--     (SELECT DISTINCT origin_city, dest_city FROM FLIGHTS
--     WHERE dest_city != 'Seattle WA'
--     AND dest_city NOT IN
--     (SELECT DISTINCT dest_city FROM FLIGHTS
--     WHERE origin_city = 'Seattle WA')
--     ) F2
--     ON F1.dest_city = F2.origin_city
--     WHERE F1.origin_city = 'Seattle WA'
--     ORDER BY F2.dest_city ASC
-- ) as c2


-- SELECT DISTINCT F.dest_city from FLIGHTS AS F
-- where f.dest_city not in (select c1.dest_city from(
--     SELECT distinct dest_city from FLIGHTS
--     WHERE origin_city = 'Seattle WA'
-- )as c1)
-- and f.dest_city not in (
--     SELECT c2.sum2 FROM
-- (
--     SELECT DISTINCT F2.dest_city as sum2
--     FROM FLIGHTS AS F1 JOIN
--     (SELECT DISTINCT origin_city, dest_city FROM FLIGHTS
--     WHERE dest_city != 'Seattle WA'
--     AND dest_city NOT IN
--     (SELECT DISTINCT dest_city FROM FLIGHTS
--     WHERE origin_city = 'Seattle WA')
--     ) F2
--     ON F1.dest_city = F2.origin_city
--     WHERE F1.origin_city = 'Seattle WA'
--     ORDER BY F2.dest_city ASC
-- ) as c2)



--- problem 7
/*
(10 points)
List the names of carriers that operate flights from Seattle to San Francisco CA.
Name the output column carrier.
Return each carrier's name once.
Order the output ascending by carrier.
*/
-- SELECT C.name
-- FROM FLIGHTS AS F1 
-- JOIN CARRIERS AS C ON C.cid = F1.carrier_id
-- WHERE (F1.dest_city ='San Francisco CA' AND F1.origin_city ='Seattle WA')
-- GROUP BY C.name;

-- problem 8
/*
For each day of the week, find cities with the top two highest average number of arriving flights on that day of week.
Report the day of week, city, and the average number of arriving flights into that city on that day of the week.
Warning: the days of the week occur a different number of times in the Flights dataset.
For example, Sunday occurs on 4 days while Friday occurs on 5 days.
Name the output columns day_of_week, dest_city, avg_flights.
Report day of week names (e.g. Sunday) rather than day of week numbers (e.g. 7).
Order the days of the week from Monday to Sunday in order (e.g. Monday, Tuesday, Wednesday, ...), then by avg_flights descending.
[Output relation cardinality: 14]
*/
-- SELECT day_of_week ,dest_city ,avg_flights FROM(
-- SELECT * FROM(
-- SELECT * FROM(
-- SELECT W.day_of_week AS day_of_week,F.dest_city AS dest_city, avg(F.flight_num) AS avg_flights
-- FROM FLIGHTS AS F
-- JOIN WEEKDAYS AS W ON W.did = F.day_of_week_id
-- GROUP BY F.dest_city,W.day_of_week 
-- )
-- order by avg_flights desc
-- limit 14
-- ) as t
-- JOIN WEEKDAYS AS W ON W.day_of_week = t.day_of_week
-- order by W.did
-- )
With FLIGHTS_DAY AS (Select F.dest_city, F.day_of_month, count(*) AS count_in_day
      From FLIGHTS AS F
      --Where f1.canceled = 0
      Group by F.dest_city, F.day_of_month),

 FLIGHTS_WEEKDAY AS (Select f2.dest_city,f2.day_of_week_id, AVG(fd1.count_in_day) AS AVG_day
      From FLIGHTS_DAY AS fd1, FLIGHTS AS f2
      Where fd1.dest_city = f2.dest_city
       and fd1.day_of_month = f2.day_of_month
      Group by f2.dest_city, f2.day_of_week_id)
Select  DISTINCT fw1.day_of_week_id, max(fw1.AVG_day)AS second, fw1.dest_city 
        From FLIGHTS_WEEKDAY AS fw1
        Group by fw1.day_of_week_id,fw1.dest_city
        order by second

-- FLIGHTS_SECOND  AS (
--         Select fw1.day_of_week_id, max(fw1.AVG_day) AS second
--         From FLIGHTS_WEEKDAY AS fw1
--         Group by fw1.day_of_week_id
--         (Select fw2.day_of_week_id, max(fw2.AVG_day) AS first
--             From FLIGHTS_WEEKDAY AS fw2
--             Group by fw2.day_of_week_id) AS m
--         Where fw1.day_of_week_id = m.day_of_week_id
--         and fw1.AVG_day != m.first
--         Group by fw1.day_of_week_id)

-- Select w1.day_of_week, fw3.dest_city, fw3.AVG_day AS avg_flights
-- From FLIGHTS_WEEKDAY AS fw3, FLIGHTS_SECOND AS fs1, WEEKDAYS AS w1
-- Where fw3.day_of_week_id = w1.did
--  and fw3.day_of_week_id = fs1.day_of_week_id
--  and fw3.AVG_day >= fs1.second
-- Order by w1.did ASC,avg_flights DESC;


