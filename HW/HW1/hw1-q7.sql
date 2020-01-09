/*
cse 414-2019sp
homework1
*/

/*
Write a SQL query that returns all restaurants that are within and including 10 mins from your house.
*/
SELECT names from MyRestaurants 
where Distance <= 10
