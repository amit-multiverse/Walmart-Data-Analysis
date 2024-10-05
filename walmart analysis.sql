SELECT * FROM sales.`walmartsalesdata.csv`;





---------------------------------------------------------------
-- time_of_day

select 
	time,
    (case
		when time between "00:00:00" and "12:00:00" then "morning"
		when time between "12:01:00" and "16:00:00" then "afternoon"
        else "evening"
	end
    ) as time_of_date
from salesdata;
alter table salesdata add column time_of_day varchar(20);
update salesdata
set time_of_day = (
	case
			when time between "00:00:00" and "12:00:00" then "morning"
			when time between "12:01:00" and "16:00:00" then "afternoon"
			else "evening"
    end
);



-- day name
select 
	date,
    dayname(date) as day_name
from salesdata;

alter table salesdata add column day_name varchar(10);

update salesdata
set day_name = dayname(date);

-- month_name

select 
	date,
    monthname(date)
from salesdata;

alter table salesdata add column month_name varchar(10);

update salesdata
set month_name = monthname(date);

-------------------------------------------------------------------------------------------
generic questions
how many unique cities dos the data have?

select
	distinct city
from salesdata;

-in which city is each branch?-

select
	distinct branch
from salesdata;
 
 select
	distinct city,
    branch
from salesdata;

 -- -----------------------------------------------------------------------------------------
 product questions
  how many unique product lines does the data have?
  
select 
	count(distinct(product_line))
from salesdata;

--what is the most common payment method
select * from salesdata;
select 
	Payment,
    count(Payment) as cnt
from salesdata
group by Payment
order by cnt desc;

--what is the most selling product line?

select 
	product_line,
    count(product_line) as cnt
from salesdata
group by product_line
order by cnt desc;

--what is the total revenue by month?

select
	month_name as month,
    sum(total) as total_revenue
from salesdata
group by month_name
order by total_revenue desc;

--what month had the largest COGS(cost of good sold)?

select
	month_name as month,
    sum(cogs) as cogs
from salesdata
group by month_name
order by cogs desc; 

--what product line had the largest revenue?

select 
	product_line,
    sum(total) as total_revenue
from salesdata
group by product_line
order by total_revenue desc;
 
-- what is the city with the largest revenue?

select 
	branch,
	city,
    sum(total) as total_revenue
from salesdata
group by city, branch
order by total_revenue desc;

--what product line had the largest vat?
select
	product_line,
    avg(vat) as avg_tax
from salesdata
group by product_line
order by avg_tax desc;

--fetch product line and add column to those  product line  showing "good", "bad",.Good if its greater than avg sales
-- which branch sold more products than average product sold?
 select
	branch,
    sum(quantity) as qty
from salesdata
group by branch
having sum(quantity) > (select avg(quantity) from salesdata);

-- what is the most common product line by gender?
 select
	gender, 
    product_line,
    count(gender) as total_cnt
from salesdata
group by gender, product_line
order by total_cnt desc;

--what is the average rating of each product line?
select
	round(avg(rating), 2) as avg_rating,
    product_line
from salesdata
group by product_line
order by avg_rating desc;

------------------------------------------------------------------------------------------
sales

--no of sales made in each time of the day per weekday
select
	time_of_day,
    count(*) as total_sales
from salesdata
where day_name = ""
group by time_of_day
order by total_sales desc;

--which of the customer brings the most revenue?
select 
	customer_type,
    sum(total) as total_rev
from salesdata
group by customer_type
order by total_rev desc;

--which city has the largest tax percent/VAT (value added tax)?

select
	city,
    avg(vat) as VAT
from salesdata
group by city
order by vat desc;

-- which customer type pays the most in VAT?

select
	customer_type,
    avg(vat) as VAT
from salesdata
group by customer_type
order by vat desc;

----------------------------------------------------------------------------------------------
-- Customer
-- how many unique customer type does the data have?

select
	distinct customer_type
from salesdata;

-- how many unique payment methods does the data have?

select
	distinct payment
from salesdata;

-- what is the most common customer type?

select
	customer_type,
	count(*) as cnt
from salesdata
group by customer_type;

-- which customer type buys the most?

select
	customer_type,
    count(*) as cstm_cnt
from salesdata
group by customer_type;

-- what is the gender of most of the customers?
select
	Gender,
    count(*) as gender_cnt
from salesdata
group by gender
order by gender_cnt desc;

-- what is the gender distribution per branch?

select
	Gender,
    count(*) as gender_cnt
from salesdata
where branch = "A"
group by Gender
order by gender_cnt desc;

-- what time of day do customers give most rating?

select
	time_of_day,
    avg(rating) as avg_rating
from salesdata
group by time_of_day
order by avg_rating desc;

-- which time of the day do customers give most ratings per branch?

select
	time_of_day,
    avg(rating) as avg_rating
from salesdata
where branch = "B"
group by time_of_day
order by avg_rating desc;

-- which day for the week has the best avg ratings?

select
	day_name,
    avg(rating) as avg_rating
from salesdata
group by day_name
order by avg_rating desc;

-- which day of the week has the best average ratings per branch?

select
	day_name,
    avg(rating) as avg_rating
from salesdata
where branch = "C"
group by day_name
order by avg_rating desc;

select
	Unit_price
from salesdata;





























	
