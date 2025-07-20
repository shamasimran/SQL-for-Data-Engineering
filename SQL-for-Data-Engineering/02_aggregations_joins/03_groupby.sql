USE [DataPurBatch01]
GO

SELECT * FROM Sales


----------------------- GROUP BY / Single Column --------------------------
SELECT SUM(Quantity) AS TotalQty
FROM Sales
GROUP BY Region;

SELECT Region, SUM(Quantity) AS TotalQty
FROM Sales
GROUP BY Region;
------------------------- ******************** ----------------------------


----------------------- GROUP BY / Multiple Columns --------------------------
SELECT Region, Product, SUM(Quantity) AS TotalQty
FROM Sales
GROUP BY Region, Product;
------------------------- ******************** -------------------------------


----------------------- GROUP BY / Expression -------------------------------
SELECT * FROM Sales

SELECT YEAR(SaleDate) AS SaleYear, SUM(Quantity) AS TotalQty
FROM Sales
GROUP BY YEAR(SaleDate);

/*
SELECT YEAR(SaleDate) AS SaleYear, SUM(Quantity) AS TotalQty
FROM Sales
GROUP BY SaleYear;
*/
------------------------- ******************** -------------------------------

----------------------- GROUP BY / ROLLUP -----------------------------------
SELECT Region, Product, SUM(Quantity) AS TotalQty
FROM Sales
WHERE Region IS NOT NULL
GROUP BY ROLLUP (Region, Product);

------------------------- ******************** -------------------------------


----------------------- GROUP BY / CUBE -------------------------------------
SELECT Region, Product, SUM(Quantity) AS TotalQty
FROM Sales
WHERE Region IS NOT NULL
GROUP BY CUBE (Region, Product);
------------------------- ******************** -------------------------------


----------------------- GROUP BY / GROUPING_ID -------------------------------
SELECT 
		Region, Product, 
		SUM(Quantity) AS TotalQty,
		GROUPING_ID(Region, Product) AS GroupLevel,
		CASE GROUPING_ID(Region, Product)
		WHEN 0 THEN 'RegionalProducts'
		WHEN 1 THEN 'Regional'
		WHEN 2 THEN 'Products'
		WHEN 3 THEN 'GrandTotals'
		END AS ReportLevel
FROM Sales
WHERE Region IS NOT NULL
GROUP BY ROLLUP (Region, Product);

SELECT 
    Region, 
    Product, 
    SUM(Quantity) AS TotalQty,
    GROUPING_ID(Region, Product) AS GroupLevel,
	CASE GROUPING_ID(Region, Product)
		WHEN 0 THEN 'RegionalProducts'
		WHEN 1 THEN 'Regional'
		WHEN 2 THEN 'Products'
		WHEN 3 THEN 'GrandTotals'
	END AS ReportLevel
FROM Sales
WHERE Region IS NOT NULL
GROUP BY CUBE (Region, Product);

------------------------- ******************** -------------------------------


----------------------- GROUP BY / HAVING -------------------------------
SELECT Region, SUM(Quantity) AS TotalQty
FROM Sales
WHERE Region IS NOT NULL
GROUP BY Region
HAVING SUM(Quantity) >= 3;
------------------------- ******************** ----------------------------