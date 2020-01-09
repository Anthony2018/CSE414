/*
cse 414-2019sp
homework1
*/

.header on
.mode column

/* Create a table Edges(Source, Destination) where both Source and Destination are integers.*/
CREATE TABLE Edges (Source int, Destination int);
.table

/*Insert the tuples (10,5), (6,25), (1,3), and (4,4)*/

INSERT INTO Edges (Source, Destination)
VALUES (10, 5), (6, 25), (1, 3), (4, 4);

/*returns all tuples.*/

SELECT*FROM Edges;

/* only column Source for all tuples*/

SELECT Source FROM Edges;

/* returns all tuples where Source > Destination.*/

SELECT*FROM Edges
WHERE Source > Destination;

/*Now insert the tuple ('-1','2000')*/

INSERT INTO Edges (Source, Destination)
VALUES (-1, 2000); 
/*
i have tried both VALUES (-1, 2000) and VALUES ('-1, '2000'), 
but not get the error
i think it tranfers the string to int automatically
*/
SELECT*FROM Edges;