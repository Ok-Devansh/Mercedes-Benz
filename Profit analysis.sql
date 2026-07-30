-- Which Mercedes model generated the highest profit?
select p.model_name,
		sum(s.profit) as profit
from product as p 
join sales as s 
on p.product_id = s.product_id
group by model_name
order by profit desc
limit 1;

-- Which dealer earned the highest total profit?
select dealer_name,
		sum(profit) as profit 
from dealer as d 
join sales as s 
on d.dealer_id = s.dealer_id
group by dealer_name
order by profit 
limit 1;

-- Which country generated the highest profit?
select country,
		sum(profit) as profit 
from customers as c 
join sales as s
on c.customer_id = s.customer_id 
group by country
order by profit desc
limit 1;

-- Which month recorded the highest profit?
select month_name,
		sum(profit) as profit
from date as d 
join sales as s
on d.date_id = s.date_id
group by month_name
order by profit desc
limit 1;

-- Which products have high sales but low profits?
select product_id
from (select p.product_id,
		sum(s.sales) as sales,
        sum(s.profit) as profit
        from product as p
		join sales as s
        on p.product_id = s.product_id
		group by p.product_id) as summary
	where sales > 500000 and 
    profit <= 2000000;
						