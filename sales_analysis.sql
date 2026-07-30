-- Mercedes model wise total revenue generated from highest to low
select p.model_name, 
		sum(s.sales) as total_sales
from sales as s 
join product as p
on s.product_id = p.product_id
group by p.model_name
order by total_sales desc;

-- Which product category contributed the highest sales revenue?
select category,
		sum(sales) as revenue
from sales as s
join product as p
on s.product_id = p.product_id
group by category
order by revenue desc
limit 1;

-- Which fuel type generated the highest sales?
select fuel_type,
		sum(sales) type_wise_revenue
from product as p
join sales as s 
on p.product_id = s.product_id
group by fuel_type
order by type_wise_revenue desc
limit 1;

-- Which dealer achieved the highest total sales?
select dealer_name,
		sum(sales) ttl_sales
from dealer as d 
join sales as s 
on d.dealer_id = s.dealer_id
group by dealer_name
order by ttl_sales desc
limit 1;

-- Country wise revenue?
select c.country,
		sum(s.sales) country_wise_revenue
from customers as c 
join sales as s
on c.customer_id = s.customer_id
group by country
order by country_wise_revenue desc;

-- Which month recorded the highest sales?
select month_name,
		sum(sales) as sale
from date as d
join sales as s 
on d.date_id = s.date_id
group by month_name
order by sale desc
limit 1;

-- Which quarter generated the highest sales?
select d.quarter,
		sum(s.sales) as sale
from date as d
join sales as s 
on d.date_id = s.date_id
group by quarter
order by sale desc
limit 1;

-- Which models had the lowest sales performance?
select p.model_name, 
		sum(s.sales) as total_sales
from sales as s 
join product as p
on s.product_id = p.product_id
group by p.model_name
order by total_sales asc
limit 1;

-- What is the average sales value per order?
select avg(sales) as avg_sales_value_per_order
from sales;
