📊 SQL Retail Sales Analysis - Project README
📌 Project Overview
This project performs comprehensive retail sales analysis using SQL to explore customer purchasing patterns, sales performance, and business insights from a retail sales dataset. The analysis includes data cleaning, exploration, and answering key business questions.

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
transactions_id	INT	Primary key	Unique transaction identifier
sale_date	DATE	Date of sale	Format: YYYY-MM-DD
sale_time	TIME	Time of sale	Used for shift analysis
customer_id	INT	Customer ID	Used for customer segmentation
gender	VARCHAR(15)	Customer gender	'Male', 'Female', etc.
age	INT	Customer age	Used for demographic analysis
category	VARCHAR(20)	Product category	'Clothing', 'Beauty', etc.
quantiy	INT	Quantity purchased	Note: Spelled 'quantiy' in schema
price_per_unit	FLOAT	Price per unit	Unit price of item
cogs	FLOAT	Cost of goods sold	Cost incurred
total_sale	FLOAT	Total sale amount	Revenue generated
🧹 Data Cleaning Process
The script includes data quality checks and cleaning:

NULL Value Checks: Verified critical columns for completeness

Data Removal: Deleted records with NULL values in essential fields:

sale_date

sale_time

customer_id

gender

Data Validation: Ensured data integrity before analysis

📈 Business Questions & SQL Solutions
Q.1: Daily Sales Extraction
sql
-- Retrieve all sales on '2022-11-05'
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
Purpose: Extract specific day's transactions for daily reporting.

Q.2: Category & Quantity Filtering
sql
-- Clothing transactions with quantity ≥4 in November 2022
SELECT * FROM retail_sales 
WHERE category = 'Clothing' 
  AND sale_date >= '2022-11-01' 
  AND sale_date < '2022-12-01'
  AND quantiy >= 4;
Insight: Identifies bulk purchases in specific categories.

Q.3: Category Performance Analysis
sql
-- Total sales per category
SELECT category, 
       SUM(total_sale) AS Total_Sales, 
       COUNT(*) AS Total_Orders 
FROM retail_sales 
GROUP BY category;
Output: Revenue and order count by product category.

Q.4: Customer Demographic Analysis
sql
-- Average age of Beauty category customers
SELECT ROUND(AVG(age)) AS avg_age 
FROM retail_sales 
WHERE category = 'Beauty';
Insight: Target age group for beauty products.

Q.5: High-Value Transactions
sql
-- Transactions with total sale > 1000
SELECT * FROM retail_sales
WHERE total_sale > 1000;
Use Case: Identifying premium purchases.

Q.6: Gender-based Category Analysis
sql
-- Transaction count by gender per category
SELECT gender, category, COUNT(*) AS Total_number 
FROM retail_sales 
GROUP BY gender, category;
Insight: Gender preferences across categories.

Q.7: Monthly Sales Performance
sql
-- Best selling month each year (using window function)
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

Q.8: Top Customer Identification
sql
-- Top 5 customers by total sales
SELECT customer_id, SUM(total_sale) AS Total_Sales 
FROM retail_sales 
GROUP BY customer_id 
ORDER BY Total_Sales DESC 
LIMIT 5;
Business Value: Identify VIP customers for loyalty programs.

Q.9: Customer Reach per Category
sql
-- Unique customers per category
SELECT category, 
       COUNT(DISTINCT(customer_id)) AS cnt_unique_customer
FROM retail_sales 
GROUP BY category;
Metric: Customer base diversity across categories.

Q.10: Time-based Sales Distribution
sql
-- Order distribution by time shifts using CTE
WITH hourly_sale AS (
  SELECT *,
    CASE 
      WHEN HOUR(sale_time) <= 12 THEN 'Morning'
      WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
      ELSE 'Evening'
    END AS shift
  FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders 
FROM hourly_sale
GROUP BY shift;
Technique: Common Table Expression (CTE) for readability.


Step-by-Step Execution
Create Database:

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





