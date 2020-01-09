/*
cse 414-2019sp
Jinlin xiang
homework1
*/
.header on
.mode column

/*
Write a SQL query that returns only the name and distance of all restaurants within and
including 20 minutes of your house. The query should list the restaurants in alphabetical order of names.
*/
SELECT names, Distance from MyRestaurants
where Distance < 20
order by names asc 