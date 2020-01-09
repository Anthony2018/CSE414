/*
cse 414-2019sp
homework1
*/

/* build the MyRestaurants table
Name of the restaurant: a varchar field
Type of food they make: a varchar field
Distance (in minutes) from your house: an int

Date of your last visit: a varchar field, interpreted as date
Whether you like it or not: an int, interpreted as a Boolean
*/
CREATE TABLE MyRestaurants(
    names varchar(100),
    Food varchar(100),
    Distance int,
    Visite varchar(100),
    like_or_not int
);
