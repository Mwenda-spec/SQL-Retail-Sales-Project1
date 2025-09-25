-- Defining the database to use and the tables in the database to be used,

SHOW DATABASES;
USE sqlprojects;
SHOW TABLES;
DESC Project1;

-- Step 1 -- Data Cleaning
SELECT COUNT(*) FROM Project1; -- to get the number of imported rows

SELECT * FROM Project1 WHERE 
    TransactionsId IS NULL
    OR
    SaleDate IS NULL 
    OR
    SaleTime IS NULL
    OR 
    CustomerId IS NULL 
    OR 
    Gender IS NULL
    OR 
    Age IS NULL 
    OR 
    Category IS NULL 
    OR 
    PricePerUnit IS NULL 
    OR 
    Cogs IS NULL 
    OR 
    TotalSale IS NULL; -- This is a one time querry to make sure taht there are no null or empty values in the dataset, it is one of the integral parts of data clean up process,,by using the OR Function,
    
    -- Data Exploration  --- STEP 2
    -- 1. How many sales have been made,
    SELECT COUNT(*) AS TotalSales FROM Project1;
    -- How many customers do we have
    SELECT COUNT(Distinct CustomerId) AS TotalCustomers FROM Project1;
    -- How many Categories do we have;
	SELECT COUNT(Distinct Category) AS TotalCategories FROM Project1;
    -- Average age for our customers
    SELECT AVG(Age) FROM Project1;
    
    -- STEP 3 Data Analysis to solve business key problems. 
    
    -- Question 1 ;  Write a SQL querry to retrieve all columns for sales made on '2022-11-05'
    
    SELECT * FROM Project1 
    WHERE SaleDate = '2022-11-05';  -- Done and Dusted!!
    
    -- Question 2 ; Write a SQL Querry to retrieve all transactions where the category is clothing and the quantity sold is more than 10 in the month of nov 2022
  -- Method1 to accomplish this  
SELECT *
FROM project1
WHERE category = 'Clothing'
  AND quantity >= 4
  AND saledate >= '2022-11-01'
  AND saledate < '2022-12-01'; -- making use of the and function to manually specify the date ranges greater than or equal to 1st nov, and less than 1st December
    
-- Method 2 to accomplish this 
SELECT *
FROM project1
WHERE category = 'Clothing'
  AND quantity >=4
  AND EXTRACT(YEAR FROM saledate) = 2022
  AND EXTRACT(MONTH FROM saledate) = 11; -- Directly referencing the year 2022 and month nov usint the extract function
  
  -- Method 3 to accomplish this - this is the most conventional method. 
SELECT *
FROM Project1
WHERE category = 'Clothing'
  AND quantity >= 4
  AND DATE_FORMAT(saledate, '%Y-%m') = '2022-11'; -- specifying the exact format of the sale date with year as 2022 and month as November



    -- Question 3 ; Write a SQL Query to calculate the total sales(total_Sale) for each category ordered by total sales from the highest to te lowest, , 
    
    SELECT Category,SUM(TotalSale) AS TotalSales 
    FROM Project1 
    GROUP BY Category
    ORDER BY TotalSales DESC; -- Done and Dusted
    
    -- Question 4 -; Write a SQL query to find the average age of customers who purchased items from the beauty category, you can include all the categories if you wish,
    
SELECT Category, round(avg(Age),2) as AverageAge 
FROM Project1
GROUP BY 1;

-- Question 5 -; Write a SQL query to find all transactions where the total sale is greater than 1000 - ,

SELECT * FROM Project1 
WHERE Totalsale > 1000;

-- Question 6 -; Write a SQL query to find the total number of transactions (transactionsid) made by each gender in each category  , 

SELECT Category, Gender, 
COUNT(Transactionid) AS TotalTransactions
FROM PROJECT1 
GROUP BY 1,2
ORDER BY 1;

-- Question 7 - ; Write a SQL query to calculate the average sale for each month. Find out the best selling month in each year ,-NB very common question in interviews,,take note!!

-- method 1  this method is premature but forms the basics for learning purposes, it does not cover the question end to end,

SELECT EXTRACT(Month from saledate) AS mm , 
EXTRACT(Year from saledate) as yy,
round(avg(TotalSale),2) as MonthlySalesAverage
FROM PROJECT1
GROUP BY 1,2
ORDER BY 2,3 DESC; -- July was the best selling year in 2022, February was the best selling year in 2023,

-- method 2 is the complete method which covers the question end to end, iths the most conventional as long as answering the question is concerned,

SELECT * FROM 
(SELECT month(saledate) AS mm , 
Year(saledate) as yy,
round(avg(TotalSale),2) as MonthlySalesAverage,
RANK() OVER(PARTITION BY Year(saledate) ORDER BY round(avg(TotalSale),2) DESC) as YearlyRank
FROM PROJECT1
GROUP BY 1,2) as t1
WHERE YearlyRank = 1; -- July was the best selling year in 2022, February was the best selling year in 2023,
    
-- Question 8 - Write a sql query to find the top 5 customers based on the highest total sales - 

SELECT CustomerId, SUM(TotalSale) AS TotalSales
FROM PROJECT1
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Question 9 - Write a sql query to find the number of unique customers who purchased items from each category,

SELECT Category, COUNT(DISTINCT CustomerId) AS NoOfUniqueCustomers
FROM Project1 
GROUP BY 1
order by 2 DESC;

-- Question 10 - Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH HourlySale AS 
(SELECT CASE
	WHEN hour(saletime) < 12 THEN 'Morning'
    WHEN hour(saletime) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening' 
    END AS Shift
    FROM Project1)
    SELECT Shift, COUNT(*) AS NoOfOrders
    FROM HourlySale
    GROUP BY Shift
    ORDER BY 2 DESC;  -- making use of CTE

    
-- METHOD 2 WITHOUT THE CTE
SELECT CASE
	WHEN hour(saletime) < 12 THEN 'Morning'
    WHEN hour(saletime) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening' 
    END AS Shift, 
    COUNT(*) AS NoOfOrders
    FROM Project1
    GROUP BY Shift
    ORDER BY 2 DESC;
    
                                                                -- END OF PROJECT 1 -- 
    
    
	
       
      
    
    
    
    
    
    
    
    
    










