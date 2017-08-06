drop table if exists sf;

create table sf (
	ee_name text,
	job_title text,
	base_pay numeric,
	overtime_pay numeric,
	other_pay numeric,
	benefit_pay numeric,
	total_pay numeric,
	total_pay_benfits numeric,
	date_year text,
	agency text,
	status text
);

copy sf
from '/users/ianchan/downloads/san-francisco-2015.csv'
delimiter ','
csv header;

select
	*
from sf
order by 3 desc;

select
	sf.status,
	round(avg(sf.base_pay), 2)
from sf
group by 1
order by 2 desc;

-- numeric

drop table if exists longnum;

create table longnum (
	long_num numeric(8, 2)
);

copy longnum
from '/users/ianchan/downloads/long-num.csv'
delimiter ','
csv header;

select
	long_num,
	round(long_num, 2)
from longnum;

-- end numeric

-- temporary table (session only)
select
	*
into temp table sf_high_income
-- into table sf_high_income
-- creates an actual table
from sf
where base_pay >= 100000;

-- temporary table (query only)
with sf_high_income as (
		select
			*
		from sf
		where base_pay >= 100000
) select
	status,
	min(base_pay)
from sf_high_income
group by 1

-- subquery syntax
select $column_name
from (
	$query
) as $alias

select
	$column_name,
	($query)
from $table
-- maybe?

-- subquery
select
	sf_high_income.status,
	min(sf_high_income.base_pay)
from (
	select
		*
	from sf
	where base_pay >= 100000
) as sf_high_income
group by 1

-- Some stuff happened to result in a table called temp

select *
into table subscriptions
from temp
where uid not in (
	select distinct no_ltv_users.uid
	-- if you're going to use in or not in, this level of query has to return a single column
	from (
			select
				uid,
				max(ltv)
			from temp
			group by uid
			having max(ltv) <= 0
	) as no_ltv_users
)

select
	*
from sales
where county in (
	select
		*
	from counties
	where population < 100000
);
