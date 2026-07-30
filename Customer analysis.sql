
-- Which age group purchased the most vehicles?
select age_group,
		sum(quantity) as count
from sales as s 
join customers as c 
on s.customer_id = c.customer_id
group by age_group
order by count desc;

-- Which gender generated the highest sales?

-- Which customer country has the highest number of purchases?
select c.country,
		count(*) as total_p
from sales as s 
join customers as c 
on s.customer_id = c.customer_id
group by country
order by total_p desc;

-- Which customers are the top 10 by total spending?
select c.customer_name,
		sum(s.sales) as spend
from customers as c
join sales as s
on c.customer_id = s.customer_id
group by customer_name
order by spend desc
limit 10;

-- Which customers purchased more than one vehicle?
select c.customer_id,
		sum(s.quantity) as purchased
from customers as c
join sales as s
on c.customer_id = s.customer_id
group by customer_id
having sum(s.quantity) > 1
order by purchased desc;

-- What is the average spending by each age group?
select age_group, 
			avg(sales) as avg_spend
from customers as c
join sales as s
on c.customer_id = s.customer_id
group by age_group;

-- Which age group prefers Electric vehicles?
select c.age_group as age_group_prefers_Electric_vehicles,
		sum(s.quantity) as no_of_purchases
from customers as c
join sales as s on
c.customer_id = s.customer_id
join product as p 
on s.product_id = p.product_id 
where p.fuel_type = "Electric"
group by age_group_prefers_Electric_vehicles
order by no_of_purchases desc
limit 1;

-- Which gender prefers Sports models the most?
select c.gender as gender_prefers_Sports,
		sum(quantity) as purchased_total_sport_cars
from customers as c 
join sales as s
on c.customer_id = s.customer_id
join product as p
on s.product_id = p.product_id
where category = "Sports"
group by gender_prefers_Sports
order by purchased_total_sport_cars desc
limit 1;

-- Which country has the highest average order value?
select country,
			avg(sales) as averag_order_value
from customers as c 
join sales as s 
on c.customer_id = s.customer_id
group by country
order by averag_order_value desc
limit 1;

-- Which customers purchased the highest-priced vehicles?
select c.customer_name,
			sum(s.cost) as highest_priced_vehicles
from customers as c 
join sales as s
on c.customer_id = s.customer_id
group by customer_name
order by highest_priced_vehicles desc;
