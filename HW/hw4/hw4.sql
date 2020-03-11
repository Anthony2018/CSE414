select count(*) from (
select *
from Sales as s1, Sales as s2
where s1.price != s2.price
and s1.discount = s2.discount)