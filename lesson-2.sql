select vendor
from products
order by vendor desc
limit 1000;

-- 1. Unique categories in our products table?
select distinct category_name
from products;
-- 70

-- 2. Unique proofs in our products table?
select distinct proof
from products
order by proof;
-- 131

-- 3. Unique proofs and bottle sizes in our products table?
select distinct
	proof,
	bottle_size
from products
order by 1, 2;
-- 723

-- 4. Unique categories w/ a proof >= 100?
select distinct category_name
from products
where proof::int >= 100;
-- 39

-- 5. Unique vendors selling ‘SCOTCH WHISKIES’ OR selling w/ a proof >= 100?
select distinct
	vendor,
	vendor_name
from products
where
	proof::int >= 100
	or category_name = 'SCOTCH WHISKIES'
order by 1, 2;
-- 70

select btl_price::numeric
from sales
limit 10;

-- 1. Products listed BETWEEN ‘2009-01-01’ AND ‘2009-12-31’
select *
from products
where
	list_date >= '2009-01-01'
	and list_date <= '2009-12-31';

select *
from products
where list_date
	between '2009-01-01'
	and '2009-12-31';
-- 637

-- 2. Products where item_description contains “Three Olives”
select *
from products
where
	item_description ilike '%three olives%';
-- 73

-- 3. Products stocked by vendor 55, 305, 395
select *
from products
where vendor in (55, 305, 395);
-- 817

-- 4. Unique products not sold by vendor 55, 305, 395
select distinct on (item_description)
	*
from products
where vendor not in (55, 305, 395);
-- 9,160 if item_no x item_description
-- 6,675 if item_description

-- 5. Unique categories where vendor = 55 OR (proof >= 80 AND bottle_price < 6)
select distinct on (category_name)
	category_name,
	vendor,
	proof,
	bottle_price
from products
where
	vendor = 55
	or (
		proof::int >= 80
		and bottle_price::numeric < 6
	)
order by 1 asc;
-- 52

select count(distinct category_name)
from products
where
	vendor = 55
	or (
		proof::int >= 80
		and bottle_price::numeric < 6
	)
order by 1 desc;

select
	sum(total) as "total_sales",
	min(btl_price::numeric),
	max(btl_price::numeric),
	avg(btl_price::numeric),
	count(*)
from
	sales;

-- 1. Total (SUM) population of counties?
-- 2. Average (AVG) population of counties?
-- 3. Maximum (MAX), and Minimum (MIN) population of counties?
-- 4. Number of entries (COUNT) in our counties table?
-- 5. Standard deviation of population? May need Google’s help!
select
	sum(population),
	avg(population),
	max(population),
	min(population),
	count(*),
	stddev(population)
from
	counties;
-- 3,046,352
-- 30,771.232323232323
-- 430,640
-- 4,029
-- 99
-- 52,888.73787468

-- 1. # of entries per liquor category in our products table?
-- 2. AVG case_cost per liquor category in our products table?
select
	category_name,
	count(*),
	avg(case_cost)
from
	products
group by
	category_name
order by
	3 desc;

-- 3. MAX case_cost per liquor category WHERE proof >= 80?
select
	category_name,
	max(case_cost)
from
	products
where
	proof::int >= 80
group by
	category_name
order by
	max(case_cost) desc;
-- 49

-- 4. Total sales per vendor WHERE date >= ‘2014-01-01’?
select
	vendor,
	sum(total)
from sales
where date >= '2014-01-01'
group by vendor;


-- 5. Total sales by county WHERE county contains ‘SCOTT’?
select
	county,
	sum(total)
from sales
where county ilike '%scott%'
group by county;

select
	proof,
	sum(bottle_size)
from products
group by 1
having sum(bottle_size) >= 1000000
order by 2 desc;

-- 1. Liquor categories w/ 500+ entries in our products table?
select
	category_name,
	count(category_name)
from products
group by 1
having count(category_name) >= 500
order by 2 desc;
-- 5

-- 2. Liquor categories w/ <500 entries in our products table?
select
	category_name,
	count(category_name)
from products
group by 1
having count(category_name) < 500
order by 2 desc;
-- 65

-- 3. Liquor categories w/ 500 - 600 (inclusive) entries in our products table?
select
	category_name,
	count(category_name)
from products
group by 1
having count(category_name) between 500 and 600
order by 2 desc;
-- 2

-- 4. Vendors who sold $10M+ WHERE date >= ‘2014-01-01’?
select
	vendor_no,
	vendor,
	sum(total)
from sales
where date >= '2014-01-01'
group by 1, 2
having sum(total) >= 10000000
order by 3 desc;
-- 11

-- 5. Vendors who sold < $10M WHERE date >= ‘2014-01-01’?
select
	vendor_no,
	vendor,
	sum(total)
from sales
where date >= '2014-01-01'
group by 1, 2
having sum(total) < 10000000
order by 3 desc;
-- 182

select
	ct.county,
	ct.population,
	sum(sl.total) as "total_sales",
	sum(sl.total) / avg(ct.population) as "per_capita"
from
	counties ct
	inner join sales sl
	on ct.county = sl.county
group by 1, 2
order by 4 desc;

-- 1. INNER JOIN to obtain pop. for 10 sales entries
select
	counties.county,
	population,
	vendor,
	description,
	total
from
	counties
	inner join sales
	on counties.county = sales.county
limit 10;

-- 2. INNER JOIN to obtain pop. for 10 sales entries WHERE pop. >= 100,000
select
	counties.county,
	population,
	vendor,
	description,
	total
from
	counties
	inner join sales
	using (county)
where population >= 100000
limit 10;

-- 3. INNER JOIN to obtain proof for 100 sales entries
select
	description,
	proof,
	total
from
	sales
	inner join products
	on sales.item = products.item_no
limit 100;

-- 4. INNER JOIN to obtain proof for 100 sales entries WHERE proof >= 80
select
	description,
	proof,
	total
from sales
	inner join products
	on sales.item = products.item_no
where proof::int >= 80
limit 100;

-- 5. INNER JOIN to obtain proof and population for 10 sales entries
select
	counties.county,
	description,
	proof,
	population,
	total
from sales
	inner join products
		on sales.item = products.item_no
	inner join counties
		on sales.county = counties.county
limit 10;

-- other stuff

where x is null
where x is not null

-- concatenate

select store || name
from stores
limit 1;
