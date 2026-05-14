-- first 10 rows of the entire sales table

select*from `sales1.sales_combined`
limit 10

-- Total Revenue
SELECT SUM(Sales) AS Total_Revenue
FROM `sales1.sales_combined`;


-- 5 Best-Selling Products
SELECT  ProductID,ProductName,
    SUM(Sales) AS Total_Revenue
FROM `sales1.sales_combined`
GROUP BY ProductID, ProductName
ORDER BY Total_Revenue DESC
LIMIT 5;

-- Average Revenue per Order
SELECT 
    
    AVG(order_value) AS Avg_Revenue_Per_Order
FROM (
    SELECT OrderID, Avg(Sales) AS order_value
    FROM `sales1.sales_combined`
    GROUP BY OrderID
);

-- Top Products by Quantity
SELECT 
    ProductName AS Product,
    SUM(Quantity) AS Total_Quantity
FROM `sales1.sales_combined`
GROUP BY Product
ORDER BY Total_Quantity DESC
LIMIT 10;

-- Top Products by Channel (Offline)
SELECT 
    Channel,
    ProductName,
    SUM(Sales) AS Revenue
FROM `sales1.sales_combined`
GROUP BY Channel, ProductName
Having Channel='Offline'
ORDER BY Channel, Revenue DESC
limit 10


-- Top Products by Channel (Online)
SELECT 
    Channel,
    ProductName,
    SUM(Sales) AS Revenue
FROM `sales1.sales_combined`
GROUP BY Channel, ProductName
Having Channel='Online'
ORDER BY Channel, Revenue DESC
limit 10


-- Orders by Channel
SELECT 
    Channel,
    COUNT(DISTINCT OrderID) AS Total_Orders
FROM `sales1.sales_combined`
GROUP BY Channel;

--Time-Based Insights
SELECT 
    FORMAT_TIMESTAMP('%y-%m', Date) AS Month,
    SUM(Sales) AS Revenue
FROM `sales1.sales_combined`
GROUP BY Month
ORDER BY Month;

-- Revenue by Day of Week
SELECT 
    FORMAT_TIMESTAMP('%A',Date) AS Day,
    SUM(Sales) AS Revenue
FROM `sales1.sales_combined`
GROUP BY Day
ORDER BY Revenue DESC;

--Peak Hours
SELECT 
    EXTRACT(HOUR FROM Date) AS Hour,
    SUM(Sales) AS Revenue
FROM `sales1.sales_combined`
GROUP BY Hour
ORDER BY Hour;

-- Number of Orders per Day
SELECT 
    DATE(Date) AS Date,
    COUNT(DISTINCT OrderID) AS Total_Orders
FROM `sales1.sales_combined`
GROUP BY Date
ORDER BY Date;

-- Group products by stock levels
SELECT 
    CASE 
        WHEN inventory_level < 50 THEN 'Low Stock'
        WHEN inventory_level BETWEEN 50 AND 200 THEN 'Medium Stock'
        ELSE 'High Stock'
    END AS Stock_Category,
    COUNT(*) AS Product_Count
FROM `sales1.inventory`
GROUP BY Stock_Category;