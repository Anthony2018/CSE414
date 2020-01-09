/*
cse 414-2019sp
Jinlin xiang
homework1
*/

/*print the results in comma-separated form*/
.mode csv
SELECT *From MyRestaurants;

/*print the results in list form, delimited by "|"*/
.separator "|"
.mode list
SELECT *From MyRestaurants;

/*print the results in column form, and make each column have width 15*/
.mode column
.width 15 15 15 15 15
SELECT *From MyRestaurants;
/*for each of the formats above, try printing/not printing the column headers with the results
*/
.headers off
/*print the results in comma-separated form*/
.mode csv
SELECT * From MyRestaurants;

/*print the results in list form, delimited by "|"*/
.separator "|"
.mode list
SELECT *From MyRestaurants;

/*print the results in column form, and make each column have width 15*/
.mode column
.width 15 15 15 15 15
SELECT *from MyRestaurants;

