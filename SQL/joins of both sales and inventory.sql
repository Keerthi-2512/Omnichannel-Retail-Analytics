-- High demand but low stock
SELECT 
    s.ProductName,
    SUM(s.Quantity) AS Total_Sold,
    i.inventory_level
FROM `sales1.sales_combined` s
JOIN `sales1.inventory_cleaned` i
ON s.ProductID = i.product_id
GROUP BY s.ProductName, i.inventory_level
HAVING i.inventory_level < 50
ORDER BY Total_Sold DESC
LIMIT 10;

-- Approx demand vs stock
SELECT 
    s.ProductName,
    SUM(s.Quantity) AS Total_Sold,
    i.inventory_level,
    SAFE_DIVIDE(SUM(s.Quantity), i.inventory_level) AS Demand_Stock_Ratio
FROM `sales1.sales_combined` s
JOIN `sales1.inventory_cleaned` i
ON s.ProductID = i.product_id
GROUP BY s.ProductName, i.inventory_level
ORDER BY Demand_Stock_Ratio DESC
LIMIT 10;


