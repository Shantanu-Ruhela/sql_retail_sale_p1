-- Sql Retail Sales Analysis - p1
use sql_project_p1;

-- Create Table
drop table if exists retail_sales;
create table retail_sales(
transactions_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(15),
age int,
category varchar(20),
quantiy int,
price_per_unit float,
cogs float,
total_sale float
);

select * from retail_sales limit 10;

select count(*) from retail_sales ;

-- Data Cleaning
select * from retail_sales 
where transactions_id is null;

select * from retail_sales 
where sale_date is null;

select * from retail_sales 
where sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null;

--
delete from retail_sales
where sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null;

-- Data Exploration

-- How many sales we have?
select count(*) as total_sale from retail_sales;

-- How many customer we have?
select count(distinct(customer_id)) as total_customer from retail_sales;

-- How many category have?
select distinct(category) from retail_sales;

-- Data Analysis & Business key problems & Answer
-- My Analysis & Findings
-- 0.1 Write a SQL query to retrieve all columns for sales made on '2622-11-05
-- Q.2 Write a SQL query to retrieğe all transactions where the category is 'Clothing' and the quantity sove is more than 40 tis the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total sale) for each category.
-- 0.4 Write a SQL query to find the average age of customers who purchased itens from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- 0.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- 0.1 Write a SQL query to retrieve all columns for sales made on '2622-11-05
select * from retail_sales where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieğe all transactions where the category is 'Clothing' and the quantity sold is more than 4 tis the month of Nov-2022
select * from retail_sales where category = 'Clothing' and
date_format(sale_date,'%Y-%m')= '2022-11'
and quantiy >=4;
select * from retail_sales;

SELECT * FROM retail_sales 
WHERE category = 'Clothing' 
  AND sale_date >= '2022-11-01' 
  AND sale_date < '2022-12-01' -- Ensures all of November is included
  AND quantiy >= 4;

-- Q.3 Write a SQL query to calculate the total sales (total sale) for each category.
select category ,sum(total_sale) as Total_Sales, count(*) as Total_Orders from retail_sales group by category;

-- 0.4 Write a SQL query to find the average age of customers who purchased itens from the 'Beauty' category.
select round(avg(age)) as avg_age from retail_sales where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total sale is greater than 1000.
select * from retail_sales
where total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select gender, category, count(*) as Total_number from retail_sales group by gender,category;

-- 0.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- window function
select * from(
select 
year(sale_date) as Years,
month(sale_date) as Months,
round(avg(total_sale)) as Avg_sale,
rank() over(partition by year(sale_date) order by round(avg(total_sale)) desc ) as Ranks 
from retail_sales group by Years,Months) as t1
where Ranks = 1;
-- order by Years,Avg_sale desc


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
select * from retail_sales;
select customer_id,sum(total_sale) as Total_Sales from retail_sales group by customer_id 
order by Total_Sales desc limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category, count(distinct(customer_id)) as cnt_unique_customer
from retail_sales group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, 
-- Afternoon Between 12 & 17, Evening >17)
-- CTE method Common table expression
with hourly_sale
as
(
select *,
case 
when hour(sale_time) <= 12 then 'Morning'
when hour(sale_time) between 12 and 17 then 'Aftenoon'
else 'Evening'
end as shift
from retail_sales)
select
shift,
count(*) as total_orders from hourly_sale
group by shift;

-- END of prject

