select
	county,
	population,
	case
		when population = 7682
			then 1
		else 0
	end as "is_adair",
	case
		when population <= 10000
			then 1
		else 0
	end as "small_county"
from counties;

--

select
	county,
	population,
	case
		when population > 100000
			then 'large'
		when population > 50000
			then 'medium'
		else 'small'
	end as "county_type"
from counties
order by 2 desc;

--

-- invalid in postgresql btw
case
	when used_date is not null then 'used'
	when voucher_exp > getdate() then 'pending'
	when voucher_exp >= getdate() then 'valid'
	else null

--

case
	when x.txn_date > x.banned_date then 'banned'

--

select
	column_name,
	sum(
		case
			when txn.user_coupon_id <> ''
			and txn.total_usd = 0
				then 19.95
			else txn.total_usd
		end
	) as "ufr_collections"
from table_name
group by 1;

-- 1. Label any county w/ population >= 100k AS ‘high’ ELSE ‘low’

select
	c.county,
	case
		when c.population >= 100000
			then 'high'
		else 'low'
	end as "poulation_category"
from counties c;

-- 2. Label all product categories as strong (proof >= 80), or not_strong

-- 3. Create a binary column for stores located in Cedar Falls

-- 4. Label any sale >= $129 as ‘above_average’ (LIMIT 10K)

-- 5. Label any sale where product list_date >= 2010 THEN ‘new’ (LIMIT 10K)
