DROP TABLE table1;

CREATE TABLE table1
( var1 char(2),
var2 int,
var3 date);

select * from table1;

insert into table1(var1,var2,var3)
values
('kz',18,"2021-12-21"),
('vc',21,"1995-08-18");

DROP TABLE table2;

CREATE TABLE table2
( var1 char(2),
var2 int,
var3 date);

select * from table2;

insert into table2(var1,var2,var3)
values
('kz',18,"2021-12-21"),
('vc',22,"1995-08-18");

insert into table2
set
var1='kz',var2=18,var3="2021-12-21";


-- like
create table table4 like table1

insert into table4(var1,var2)
select var1,var2
from table1;

drop table table4;
select * from table4;


-- select *
drop table table5;
create table table5
select * from table1;

select * from table5;

-- LIMIT
select *
from table1
limit 1;

-- select columns
select var2,var1
from table1;

select var2,var3
from table1;


-- alter table; ADD command
alter table table1
add
(var4 int,
var5 char(2));

-- drop
alter table table1
drop var4,
DROP var5;

select * from table1;

-- MODIFY
alter table table1
modify column var1 char(60),
modify column var2 char(10);

-- rename
alter table table1
change column customer_name var1 char(60),
change column customer_ID var2 char(20);


alter table table1
change column var2 var1 char(60),
change column var1 var2 char(20);


select * from table1;


SET SQL_SAFE_UPDATES = 0;

-- UPDATE
update table1
set
var2= var2/2;

SET SQL_SAFE_UPDATES = 1;

-- update table with set clause *OTHER TABLE*
-- add columns and update

alter table table1
add
(var4 int,
var5 char(2));

select * from table1; 

update table1 as a
set var4 = (select var2 from table2 as b
where a.var1=b.var1);


-- total rows
select * from table1; 

select count(*) -- counts missing values also
from table1; 

select count(var1) -- doesn't count missing values 
from table1; 


-- total columns
select * from information_schema.columns;

select * from table1;

select count(*) as columns -- 
from information_schema.columns
where table_schema= 'test'
and table_name= 'table1'
;

show databases;

-- distinct

select * from table1;

select distinct(var1)
from table1;

-- missing

select count(*) as total,
count(var4) as nonmissing,
count(*) - count(var4) as missing,
round(((count(*) - count(var4))/(count(*))*100),2) as perc_missing
from table1;


-- mean, std_dev

select * from table1;

select avg(var1) -- here missing values ignored
from table1;
 
select stddev(var1)
from table1;

select min(var1) as min
from table1;

select max(var2) max
from table1;

-- Horizontal Join also called append

select var1, var2 from table1 union all -- shows all records
select var1, var2 from table2;

select var1, var2 from table1 union -- removes duplicates; shows only unique values
select var1, var2 from table2;

-- vertical joins

drop table table1;

CREATE TABLE table1
( customer_id int,
customer_name char(20));


insert into table1(customer_id, customer_name)
values
(1, 'tom'),
(2, 'john'),
(3, 'bob');

select * from table1;


drop table table2;

CREATE TABLE table2
( customer_id int,
item_name char(20));


insert into table2(customer_id, item_name)
values
(1, 'apple'),
(1, 'grapes'),
(3, 'apples'),
(5, 'oranges');


select * from table2;

-- left join

select a.customer_id, a.customer_name, b.item_name 
from 
table1 as a
left join
table2 b
on a.customer_id=b.customer_id;

select a.customer_id, a.customer_name, b.item_name 
from 
table2 as b
left join
table1 a
on a.customer_id=b.customer_id;

-- right join

select a.customer_id, a.customer_name, b.customer_id, b.item_name 
from 
table1 as a
right join
table2 b
on a.customer_id=b.customer_id;

-- inner join

select a.customer_id, a.customer_name, b.customer_id, b.item_name 
from 
table1 as a
inner join
table2 b
on a.customer_id=b.customer_id;

-- outer join

select a.customer_id, a.customer_name, b.customer_id, b.item_name 
from 
table1 as a
full outer join
table2 b
on a.customer_id=b.customer_id;

select *
from 
table1 as a full outer join table2 b
on a.customer_id=b.customer_id;

-- INDEX

drop table table1;

CREATE TABLE table1
( customer_id int,
customer_name char(20),
pincode int);

insert into table1(customer_id, customer_name, pincode)
values
(88, 'john', 8000),
(89, 'james',8001),
(90, 'joe',8002),
(91, 'null', 8003),
(92, 'joe',8002)
;

select * from table1;

alter table table1
add primary key(customer_id);

alter table table1
add unique index_name(customer_id, customer_name);

alter table table1
add index index_name1(customer_name, pincode);

show index from table1;


-- nested subquery

drop table table1;

CREATE TABLE table1
( customer_id int,
customer_name char(20),
spend int,
region char(20));

insert into table1(customer_id, customer_name, spend, region)
values
(88, 'john', 500, 'alaska' ),
(89, 'james',800, 'alaska'),
(90, 'joe',400, 'alabama'),
(91, 'null', 450, 'alabama'),
(92, 'joe',450, 'alabama')
;

select * from table1;

drop table table2;

CREATE TABLE table2
( customer_id int,
item_name char(20));


insert into table2(customer_id, item_name)
values
(91, 'apple'),
(91, 'grapes'),
(90, 'apples'),
(88, 'oranges');


select * from table2;

select * from table1
where customer_id in
(select distinct customer_id from table2)
;

select a.customer_id, a.customer_name, a.spend, a.region, b.item_name
from table1 as a
left join
table2 b
on a.customer_id=b.customer_id;

--  correlated subquery
drop table table1;

CREATE TABLE table1
( customer_id int,
customer_name char(20),
spend int,
region char(20));

insert into table1(customer_id, customer_name, spend, region)
values
(88, 'john', 500, 'alaska' ),
(89, 'james',800, 'alaska'),
(90, 'joe',400, 'alabama'),
(91, 'null', 450, 'alabama'),
(92, 'joe',450, 'alabama')
;

select * from table1;

drop table table2;

CREATE TABLE table2
( customer_id int,
item_name char(20));


insert into table2(customer_id, item_name)
values
(91, 'apple'),
(91, 'grapes'),
(90, 'apples'),
(88, 'oranges');


select * from table2;

select customer_id, customer_name
from table1 as A
where spend >
( select avg(spend)
from table1
where region= a.region);

drop table table3;

CREATE TABLE table3
( var1 int,
var2 int,
var3 int);


insert into table3(var1, var2, var3)
values
(88, 45, 45),
(88, 45, 45),
(89, null, 45),
(90, 45, 47);


select * from table3;

update table3
set var2= ifnull(var2, 45);


-- percentile

-- case end
drop table table4;

CREATE TABLE table4
( var1 int,
var2 int, var3 int);


insert into table4(var1, var2, var3)
values
(88, 80, 45),
(88, 81, 45),
(89, 82, 45),
(90, 83, 47),
(90, 84, 47);

select var1, var2,
case
when var2<82 then 1
when var2 = 82 then 2
else 3
end as var4
from table4;

-- coalesce

drop table monthly_income;

CREATE TABLE monthly_income
( id int,
jan int, feb int,
mar int);


insert into monthly_income(id, jan, feb, mar)
values
(1,88, 80, 45),
(2,88, 81, 45),
(3, null, 82, 45),
(4, 90, 83, 47),
(5, null, null, 47);

select *,
coalesce(jan, feb, mar) as first_income from monthly_income;

-- scalar

DROP TABLE table5;

CREATE TABLE table5
( var1 char(20),
var2 decimal(10,2));

select * from table5;

insert into table5(var1,var2)
values
('john',5500.32),
('James',6642.343);

select ucase(var1) uppercase, lcase(var1) lowercase, mid(var1,2,2) middle_term, length(var1) length, round(var2,1) rounded, now() today from
table5;

-- check user details

select current_user();

