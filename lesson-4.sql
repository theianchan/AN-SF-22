-- 1A. Creating our table
create table a (
	id int,
	name text
);

-- 1B. Loading our dataset into the table we just created
copy a
from '/users/ianchan/downloads/local_table_one.csv'
delimiter ','
csv header;

-- 1C. Creating our second table
create table b (
	id int,
	name text
);

-- 1D. Loading our dataset into the second table we just created
copy b
from '/users/ianchan/downloads/local_table_two.csv'
delimiter ','
csv header;

-- How to DROP our tables
drop table if exists a;
drop table if exists b;

-- How to TRUNCATE our tables
truncate table a;
truncate table b;
