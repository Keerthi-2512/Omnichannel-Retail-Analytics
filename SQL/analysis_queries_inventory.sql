---Queries for Inventory datasets

-- Inventory Status Analysis
SELECT 
    product_id,
    inventory_level,
    reorder_point
FROM `sales1.inventory_cleaned`
WHERE inventory_level < reorder_point;


-- Count how many products need restocking
SELECT 
    COUNT(*) AS Products_To_Restock
FROM `sales1.inventory_cleaned`
WHERE inventory_level < reorder_point;

--Show only TOP critical products
SELECT 
    product_id,
    inventory_level,
    reorder_point,
    (reorder_point - inventory_level) AS shortage
FROM `sales1.inventory`
WHERE inventory_level < reorder_point
ORDER BY shortage DESC
LIMIT 10;


-- Total inventory across all products
SELECT 
    SUM(inventory_level) AS Total_Inventory
FROM `sales1.inventory`;

-- Products that need restocking
SELECT 
    product_id,
    inventory_level,
    reorder_point
FROM `sales1.inventory_cleaned`
WHERE inventory_level < reorder_point;

-- Average stock per product
SELECT 
    AVG(inventory_level) AS Avg_Inventory
FROM `sales1.inventory_cleaned`;

-- Average delivery time
SELECT 
    AVG(lead_time_days) AS Avg_Lead_Time
FROM `sales1.inventory_cleaned`;

-- Slow restocking products
SELECT 
    product_id,
    lead_time_days
FROM `sales1.inventory_cleaned`
ORDER BY lead_time_days DESC
LIMIT 10;

-- Total restock required
SELECT 
    SUM(restock_quantity) AS Total_Restock
FROM `sales1.inventory_cleaned`
WHERE inventory_level < reorder_point;

