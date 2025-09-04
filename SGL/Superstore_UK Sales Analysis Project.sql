
-- Superstore_UK Sales Analysis Project
-- Overview:
-- This project analyzes sales data from Superstore_UK.csv to derive insights on sales trends, profitability by category, top customers/products, and shipping efficiency.  
-- Emphasizing SQL for data querying/cleaning,Python for EDA/visualization in Jupyter, and Power BI/Tableau for interactive dashboards. 
-- Skills showcased: SQL (T-SQL in SSMS for cleaning/querying), Python (pandas/seaborn in Jupyter), Power BI/Tableau (dashboarding).

-- Dataset: Superstore_UK.csv (imported into SSMS as table 'Superstore_UK').


-- Step 1: Data Cleaning in SSMS

-- Remove All Countries but United Kingdom
DELETE FROM superstore_UK
WHERE country <> 'United Kingdom';

-- Remove Unspecified/Useless Column
ALTER TABLE Superstore_UK
DROP COLUMN 记录数;

ALTER TABLE Superstore_UK
DROP COLUMN Market2;

ALTER TABLE Superstore_UK
DROP COLUMN Market;

ALTER TABLE Superstore_UK
DROP COLUMN Region;

-- Convert Column Data Types
ALTER TABLE Superstore_UK
ALTER COLUMN Order_Date DATE;

ALTER TABLE Superstore_UK
ALTER COLUMN Ship_Date DATE;

ALTER TABLE Superstore_UK
ALTER COLUMN Discount FLOAT;

ALTER TABLE Superstore_UK
ALTER COLUMN Profit FLOAT;

ALTER TABLE Superstore_UK
ALTER COLUMN Shipping_Cost FLOAT;

ALTER TABLE Superstore_UK
ALTER COLUMN Product_Name VARCHAR(255);

-- Create Aditional Columns
-- Days_To_Ship
ALTER TABLE Superstore_UK
ADD Days_To_Ship INT;

UPDATE Superstore_UK
SET Days_To_Ship = DATEDIFF(DAY, Order_Date, Ship_Date);

-- Month
ALTER TABLE Superstore_UK
ADD Month Nvarchar(20);

UPDATE Superstore_UK
SET Month = DATENAME(MONTH,Order_Date);

-- Avg_Daily_Profit
ALTER TABLE Superstore_UK
ADD Avg_Daily_Profit Float;

UPDATE superstore_UK
SET Avg_Daily_Profit = (
    SELECT AVG(profit)
    FROM superstore_UK t2
    WHERE CAST(t2.order_date AS DATE) = CAST(superstore_UK.order_date AS DATE)
);

-- Check for Duplicates 
SELECT s.*
FROM Superstore_UK s
INNER JOIN (
    SELECT Order_ID, Product_ID, Shipping_Cost
    FROM Superstore_UK
    GROUP BY Order_ID, Product_ID, Shipping_Cost
    HAVING COUNT(*) > 1
) duplicates
ON s.Order_ID = duplicates.Order_ID 
   AND s.Product_ID = duplicates.Product_ID 
   AND s.Shipping_Cost = duplicates.Shipping_Cost
ORDER BY s.Order_ID, s.Product_ID, s.Shipping_Cost;
-- If duplicates found, delete with: DELETE FROM Superstore_UK WHERE Row_ID IN (SELECT Row_ID FROM duplicates_table);

-- Dynamic check for NULLs in all columns
DECLARE @SQL NVARCHAR(MAX) = '';
DECLARE @TableName NVARCHAR(128) = 'Superstore_UK';

SELECT @SQL = @SQL + 'SELECT ''' + COLUMN_NAME + ''' AS ColumnName, COUNT(*) AS NullCount FROM ' + QUOTENAME(@TableName) + ' WHERE ' + QUOTENAME(COLUMN_NAME) + ' IS NULL UNION ALL '
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @TableName;

SET @SQL = LEFT(@SQL, LEN(@SQL) - LEN('UNION ALL '));
EXEC sp_executesql @SQL;
-- Handle NULLs if any, e.g., SELECT COALESCE(Discount, 0) AS discount FROM Superstore_UK;

-- Additional Cleaning: Trim strings and standardize categories
UPDATE Superstore_UK
SET Category = LTRIM(RTRIM(Category)),
    Sub_Category = LTRIM(RTRIM(Sub_Category)),
    City = LTRIM(RTRIM(City)),
    State = LTRIM(RTRIM(State));


-- Step 2: SQL Queries for Analysis 

-- Query 1: Total Sales and Profit by Category
SELECT Category, 
    SUM(Sales) AS Total_Sales, 
    ROUND(SUM(Profit), 4) AS Total_Profit, 
    ROUND(AVG(Discount), 4) AS Avg_Discount
FROM Superstore_UK
GROUP BY Category
ORDER BY Total_Sales DESC;

-- Query 2: Top 10 Customers by Profit
SELECT TOP 10 Customer_Name, 
    ROUND(SUM(Profit), 4) AS Total_Profit,
    SUM(Sales) AS Total_Sales 
FROM Superstore_UK
GROUP BY Customer_Name
ORDER BY Total_Profit DESC;

-- Query 3: Sales Trends by Year
SELECT Year,  
    ROUND(SUM(Profit), 4) AS Total_Profit,
    SUM(Sales) AS Total_Sales
FROM Superstore_UK
GROUP BY Year
ORDER BY Year, Total_Sales DESC;

-- Query 4: Shipping Efficiency (Average Days to Ship by Mode)
SELECT Ship_Mode, 
    AVG(Days_To_Ship) AS Avg_Days_To_Ship,
    ROUND(AVG(Days_To_Ship), 4) AS Avg_Shipping_Cost
FROM Superstore_UK
GROUP BY Ship_Mode
ORDER BY Avg_Days_To_Ship;

-- Query 5: Profit Margin, Total Sales and Profit by Sub-Category
SELECT Sub_Category, 
    ROUND(SUM(Profit) / SUM(Sales) , 4) AS Profit_Margin_Percent, 
    ROUND(SUM(Profit), 4) AS Profit, 
    SUM(Sales) AS Sales
FROM Superstore_UK
GROUP BY Sub_Category
ORDER BY Profit_Margin_Percent DESC;

-- Export query results to CSV for Python/Power BI: Use SSMS 'Results to File' or Tasks > Export Data.

