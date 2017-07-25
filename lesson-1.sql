-- 1. Which products come in packs > 12?
select *
from products
where pack > 12;
-- 1,106

-- 2. Which products have a case cost < $70?
select *
from products
where case_cost < 70;
-- 3,938

-- 3. Which products come in packs > 12 AND have a case cost < $70?
select *
from products
where case_cost < 70 and pack > 12;
-- 632

-- 4. Which categories of products have a proof of 85+?
select category_name AS "category"
from products
where cast(proof as int) > 85;
-- 1,518

-- 5. Which products are Scotch Whiskies OR are > 85 proof?
select *
from products
where proof::int > 85
	or category_name = 'SCOTCH WHISKIES';
-- 1,733

-- How many unique products have less than 12 in a pack?
-- COUNT DISTINCT

-- What is the total # of bottles sold and the total cost of sales from 1,000 selected entries?

-- How many stores are active vs inactive?

-- What is the average bottle price per vendor of Canadian whiskies?
