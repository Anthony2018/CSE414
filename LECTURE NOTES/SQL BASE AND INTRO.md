## SQL BASE AND INTRO:

### 1.BUILD A TABLE

```SQL
sqlite> create table payroll
   ...> (userid name job salary)
   ...> ;
```

### 2. CHECK THE TABLE:

```sql
sqlite> .table
```

```
output: payroll
```

### 3. insert :

```sql
CREATE TABLE Payroll (UserID VARCHAR, Names VARCHAR, Job VARCHAR, Salary int);
/*Insert the tuples */

INSERT INTO Payroll (UserID, Names, Job , Salary )
VALUES ('123','jack 123','ta bdsjkbc','5000'), ('345','allision','ta','6000'),('567','magda','prof','9000'),('789','dan','prof','10000');

CREATE TABLE Regist (UserID VARCHAR, Car VARCHAR);
INSERT INTO Regist (UserID , Car )
VALUES ('123','Charger'), ('567','Civic'),('567','Pinto');
```



