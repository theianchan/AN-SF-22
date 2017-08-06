-- sql slack question before class
select
  a.store
, b.name
, date_trunc('year', date)
, sum(a.total)
from sales a
  left join stores b on a.store = b.store
group by 1,2,3

select
  county,
  date_trunc('year', date),
  sum(sales.total)
from sales
group by 1, 2
order by 1, 2, 3
limit 10;
-- Takes 1m

/* local db */
--------------------------------------------------
-- 1a. creating our table
create table tablea
( id int, name text);

-- 1b. loading our dataset into the table we just created
copy tablea
from '/users/colby.schrauth/desktop/local_table_one.csv' delimiter ',' csv header;

-- 1c. creating our second table
create table tableb
( id int, name text);

-- 1d. loading our dataset into the second table we just created
copy tableb
from '/users/colby.schrauth/desktop/local_table_two.csv' delimiter ',' csv header;

-- how to drop our tables
drop table if exists tablea;
drop table if exists tableb;

-- how to truncate our tables
truncate table tablea;
truncate table tableb;

/* case when */
--------------------------------------------------
-- 1. label any county w/ population >= 100k as "high" else "low"
select
  *
, case when population >= 100000 then 'high' else 'low' end as "population_category"
from counties
order by population desc;

-- 2. label all product categories as strong (proof >= 80), or not_strong
select
  category_name
, proof::int
, case when proof::int >= 80 then 'strong' else 'not_strong' end as "proof_category"
from products
order by proof::int desc;

-- 3. create a binary column for stores located in cedar falls
select
  *
, case when store_address ilike '%cedar falls%' then 1 else 0 end as "in_cedar_falls"
from stores
order by 6 desc;

-- 4. label any sale >= $129 as ‘above_average’ (limit 10k)
select
  category_name
, description
, date
, total
, case when total >= 129 then 'above_avg' else 'below_or_equal_to_avg' end as "total_category"
from sales
order by 1 asc
limit 10000;

-- 5. any sale where product list_date >= 2010 then 'new' else 'old' (limit 10,000)
select
  a.description
, a.total
, b.list_date
, case when b.list_date >= '2010-01-01' then 'new' else 'old' end as "listing_category"
from sales a
  left join products b on a.item = b.item_no
limit 10000;

/* case when, continued */
--------------------------------------------------
-- 1. county population >= 400k (l), >= 100k and < 400 (m), <100k (s)
select
  county
, population
, case
    when population >= 400000 then 'large'
    when population >= 100000 and population < 400000 then 'medium'
    when population < 100000 then 'small'
  end as "county_size"
from counties;

-- 2. total vodka sales, and whiskey sales in the same query
select
  sum(
    case
      when category_name ilike '%vodka%'
        then total
      else 0
    end
  ) as "vodka_sales"
, sum(
    case
      when category_name ilike '%whisk%'
        then total
      else 0
    end
  ) as "whiskey_sales"
from sales

-- 3. total sum of shelf_price for vendor 305 and 391 for vodka, and vendor 380 for whiskey
select
  sum(
    case
      when (
          (vendor = 305 or vendor = 391)
          and category_name ilike '%vodka%'
        )
        then shelf_price
      else 0
    end
  ) as "305_total"
, sum(case when vendor = 391 and category_name ilike '%vodka%' then shelf_price else 0 end) as "391_total"
, sum(case when vendor = 380 and category_name ilike '%whisk%' then shelf_price else 0 end) as "380_total"
from products;

-- 4. count of whiskey products in our products table using case when
select
  sum(case when category_name ilike '%whisk%' then 1 else 0 end) as "whiskey_count"
from products;

-- check
select count(*)
from products
where category_name ilike '%whisk%'

-- 5. % of products that are whiskey in our products table using case when
select
  avg(case when category_name ilike '%whisk%' then 1 else 0 end) as "whiskey_count"
from products;
