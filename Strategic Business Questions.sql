------------------------------------------------------------------

-- Which products should receive increased marketing investment?
select p.product_id,
		sum(sales) as sales
from product as p
join sales as s 
on p.product_id = s.product_id
group by p.product_id
order by sales
limit 1;

-- Which low-performing models should be discontinued or redesigned?
select model_name,
		sum(sales) as sales
from product as p
join sales as s 
on p.product_id = s.product_id
group by model_name
order by sales
limit 1;

-- Which dealers should receive performance incentives?
select dealer_name,
	ttl,
    dense_rank() over(order by ttl desc) as r
from (
		select d.dealer_name,
        sum(sales) as ttl
        from dealer as d
        join sales as s
        on d.dealer_id = s.dealer_id
        group by d.dealer_name) as sales
limit 5;

-- Which customer segments should be targeted for future marketing campaigns?
select age_group as customer_segment
from (
		select c.age_group,
        sum(s.sales) as sales
        from customers as c
		join sales as s
		on c.customer_id = s.customer_id
        group by age_group) as t
where sales < 100000000
order by sales desc
limit 1;


-- Which countries represent the greatest market expansion opportunity
-- (countries that have:
-- Low total sales
-- Low number of purchases
-- High average sales per order)?
select c.country as country,
sum(s.sales) as sales,
sum(s.quantity) as purchases,
avg(s.sales) as average_sales
from sales as s
join customers as c
on s.customer_id = c.customer_id
group by country
order by sales asc, average_sales desc;


-- Which vehicle category should Mercedes focus on based on profitability?
select category,
	percent_rank() over(order by profit) as priority_rank
from(
		select category,
        sum(profit) as profit
        from product as p
        join sales as s
        on p.product_id = s.product_id
        group by category
        ) as t
	order by priority_rank desc;

-- 2 fuel types - Mercedes prioritise for future production?
select fuel_type as prioritise,
		sum(s.sales) as sale_occured
from product as p 
join sales as s
on p.product_id = s.product_id
group by prioritise
order by sale_occured desc
limit 2;

-- Which dealers require operational improvement based on sales performance?
select dealer_name,
		total_sales
from (select d.dealer_name,
		sum(s.sales) as total_sales
        from dealer as d
		join sales as s
		on d.dealer_id = s.dealer_id
		group by dealer_name) as t
where total_sales < 2000000;

-- Which product categories generate strong sales with minimal discounts?
select category as category_name,
		sales
	from(select p.category,
			sum(s.sales) as sales
            from product as p
            join sales as s
            on p.product_id = s.product_id
            where s.`discount_%` < 5
            group by category) as t
        order by sales desc;
        
-- Which combination of dealer, model, and country generates the highest overall revenue?
select d.dealer_name,
				p.model_name,
						c.country,
								sum(s.sales) as sales
			from dealer as d
            join sales as s
            on d.dealer_id = s.dealer_id
            join customers as c
            on s.customer_id = c.customer_id
            join product as p 
            on s.product_id = p.product_id
            group by dealer_name,
						model_name, 
							country
			order by sales desc;


select * from customers;
select * from date;
select * from dealer;
select * from product;
select * from sales;