/*
cse 414-2019sp
Jinlin xiang
homework1
*/

/*
Write a SQL query that returns all restaurants that you like, but have not visited
since more than 3 months ago
*/

SELECT names
from MyRestaurants
where like_or_not = 1 and date(Visite) <= date('now', '-3 month');
