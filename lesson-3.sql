-- 1. Which unique stores (store # and store name) sold a Whiskey product?

select distinct on (sales.store)
	stores.name,
	sales.store,
	sales.category_name
from sales
	inner join stores
		on sales.store = stores.store
where
	category_name ilike '%whiskey%';
-- 1298

-- 2. How many sales are attached to products listed in ‘10?
select
	sales.vendor,
	sales.total,
	sales.description,
	products.list_date
from sales
	inner join products
		on sales.item = products.item_no
where products.list_date between '2010-01-01' and '2010-12-31';
-- 68255

-- 3. Display total sales by store name
select
	st.name,
	sum(sl.total)
from sales sl
	inner join stores st
		on sl.store = st.store
group by 1
order by 2 desc;
-- 1305

-- 4. Question #3 + only stores in a county w/ >=100k people
select
	st.name,
	sum(sl.total)
from sales sl
	inner join stores st
		on sl.store = st.store
	inner join counties ct
		on ct.county = sl.county
where ct.population >= 100000
group by 1
order by 2 desc;
-- 507

-- 5. Question #4 + only for products w/ proof 80+  category
select
	st.name,
	sum(sl.total)
from sales sl
	inner join stores st
		on sl.store = st.store
	inner join products pr
		on sl.item = pr.item_no
where pr.proof::int >= 80
group by 1
order by 2 desc;
-- 1304

-- events
	-- user_id     integer,
	-- event_code  integer,
	-- data1       text,
	-- data2       text,
	-- data3       text,
	-- "timestamp" numeric,
	-- session_id  text

-- survey
	-- user_id integer,
	-- q1      text,
	-- ...
	-- q14     text

-- users
	-- id                integer,
	-- location          text,
	-- fx_version        text,
	-- os                text,
	-- version           text,
	-- survey_answers    text,
	-- number_extensions integer

select
	*
from users
	left join events
	on events.user_id = users.id
	left join survey
	on survey.user_id = users.id
limit 10;

select
	count(id),
	count(distinct id)
from users;

select
  u.id
, count(e.*)
from users u
  left join events e
  on u.id = e.user_id
where e.user_id is null
group by 1;

-- find and replace if null
coalesce(column_name, $value)

-- 1A. LEFT JOIN to extract 10k entries showing sales total, and population
select
	sales.total,
	counties.population
from sales
	left join counties
	on sales.county = counties.county
limit 10000;

-- 1B. 1A, but this time ORDER BY population DESC
select
	sales.total,
	counties.population
from sales
	left join counties
	on sales.county = counties.county
order by 2 desc
limit 10000;

-- 1C. 1B, but this time COUNT all transactions where population IS NULL
select
	count(sales.total)
from sales
	left join counties
	on sales.county = counties.county
where counties.population is null;
-- 1719

-- 2. Extract 10k sales entries to stores showing total, store name and address
select
	sales.total,
	stores.name,
	stores.store_address
from sales
	left join stores
	on sales.store = stores.store
limit 10000;

-- 3. Which products have not had a sale?
select
	products.item_description,
	sum(sales.total)
from products
	left join sales
	on products.item_no = sales.item
group by 1
having sum(sales.total) is null;
-- 4475

-- 4. Which sales are not tied to an entry in our products table?
select
	sales.description,
	sales.total,
	products.item_no
from sales
	left join products
	on sales.item = products.item_no
where products.item_no is null;
-- 1,120

-- 5. #4 + Total sales per each product not listed in our products table?
select
	sales.description,
	sum(sales.total)
from sales
	left join products
	on sales.item = products.item_no
where products.item_no is null
group by 1;
-- 60
