 SQL Retail Sales Analysis - Project README
 
 Project Overview
 This project performs comprehensive retail sales analysis using SQL to explore customer purchasing patterns, 
 sales performance, and business insights from a retail sales dataset. The analysis includes data cleaning, 
 exploration, and answering key business questions.

🗃️ Dataset Information
Table Name: retail_sales

Database: sql_project_p1

Records: Multiple sales transactions with customer demographics

Time Period: Includes November 2022 data

Columns: 11 attributes covering transactions, customers, products, and financials

📂 File Structure
text
sql-retail-analysis/
│
├── SQL_query_p1.sql        # Main SQL script with complete analysis
├── README.md               # Project documentation (this file)
└── (Optional) data/        # Folder for raw data files if needed
🛠️ Database Schema
Table: retail_sale:
Column	Data Type	Description	Notes

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

 Data Cleaning Process
The script includes data quality checks and cleaning:
NULL Value Checks: Verified critical columns for completeness

Data Removal: Deleted records with NULL values in essential fields:
delete from retail_sales
where sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null;

Data Validation: Ensured data integrity before analysis

📈 Business Questions & SQL Solutions

 Q.1 Write a SQL query to retrieve all columns for sales made on '2622-11-05
     select * from retail_sales where sale_date = '2022-11-05';

Q.2: Write a SQL query to retrieğe all transactions where the category is 'Clothing' and the quantity sold is more than 4 tis the month of Nov-2022

SELECT * FROM retail_sales 
WHERE category = 'Clothing' 
  AND sale_date >= '2022-11-01' 
  AND sale_date < '2022-12-01'
  AND quantiy >= 4;
Insight: Identifies bulk purchases in specific categories.

Q.3: Write a SQL query to calculate the total sales (total sale) for each category.
SELECT category, 
       SUM(total_sale) AS Total_Sales, 
       COUNT(*) AS Total_Orders 
FROM retail_sales 
GROUP BY category;
Output: Revenue and order count by product category.

Q.4: Write a SQL query to find the average age of customers who purchased itens from the 'Beauty' category.
SELECT ROUND(AVG(age)) AS avg_age 
FROM retail_sales 
WHERE category = 'Beauty';
Insight: Target age group for beauty products.

Q.5: Write a SQL query to find all transactions where the total sale is greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale > 1000;
Use Case: Identifying premium purchases.

Q.6: Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT gender, category, COUNT(*) AS Total_number 
FROM retail_sales 
GROUP BY gender, category;
Insight: Gender preferences across categories.

Q.7: Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- window function
SELECT * FROM (
  SELECT 
    YEAR(sale_date) AS Years,
    MONTH(sale_date) AS Months,
    ROUND(AVG(total_sale)) AS Avg_sale,
    RANK() OVER(PARTITION BY YEAR(sale_date) 
                ORDER BY ROUND(AVG(total_sale)) DESC) AS Ranks 
  FROM retail_sales 
  GROUP BY Years, Months
) AS t1
WHERE Ranks = 1;
Advanced Feature: Window functions for ranking.

Q.8:  Write a SQL query to find the top 5 customers based on the highest total sales
SELECT customer_id, SUM(total_sale) AS Total_Sales 
FROM retail_sales 
GROUP BY customer_id 
ORDER BY Total_Sales DESC 
LIMIT 5;
Business Value: Identify VIP customers for loyalty programs.

Q.9: Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category, 
       COUNT(DISTINCT(customer_id)) AS cnt_unique_customer
FROM retail_sales 
GROUP BY category;
Metric: Customer base diversity across categories.

Q.10:  Write a SQL query to create each shift and number of orders (Example Morning <=12, 
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

Step-by-Step Execution

sql
CREATE DATABASE sql_project_p1;
USE sql_project_p1;
Run the Script:

🔧 Technical Features
SQL Techniques Used
Basic Operations: SELECT, WHERE, GROUP BY, ORDER BY

Aggregate Functions: SUM, COUNT, AVG, ROUND

Date Functions: YEAR(), MONTH(), HOUR(), DATE_FORMAT()

Window Functions: RANK() for ranking operations

CTE (Common Table Expressions): For complex queries

CASE Statements: Conditional logic implementation

Performance Optimizations
Primary key on transactions_id for faster lookups

Efficient date filtering using range queries

Appropriate use of indexes (consider adding on sale_date, category)

Code Quality
Consistent formatting and indentation

Meaningful column aliases

Commented sections for clarity

Error handling for NULL values

📊 Expected Results & Insights
Key Findings
Category Performance: Which product categories generate most revenue

Customer Behavior: Demographics and purchasing patterns

Temporal Patterns: Best performing months and time shifts

VIP Customers: Top 5 customers contributing to revenue

Sales Distribution: How sales are distributed throughout the day


📚 Learning Resources
SQL Fundamentals
W3Schools SQL Tutorial

MySQL Official Documentation

SQLZoo Interactive Practice

Advanced Topics
Window Functions: Mode Analytics Guide







