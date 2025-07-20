USE [DataPurBatch01]
GO

SELECT * FROM Sales

------------------------- Aggregate Functions ----------------------------
SELECT 
MIN(Quantity) AS MinQtn, 
MAX(Quantity) AS MaxQtn, 
SUM(Quantity) AS SumQtn,
AVG(Quantity) AS AVGQtn
FROM Sales
------------------------- ******************** ----------------------------



------------------------- Aggregate Functions / DISTINCT  -----------------
SELECT * FROM Sales
SELECT  Count(Region) AS UnqRegionCount  FROM Sales
SELECT  Count(DISTINCT Region) AS UnqRegionCount  FROM Sales
------------------------- ******************** ----------------------------



------------------------- Aggregate Functions / NULL Handling  ------------
SELECT * FROM Sales
SELECT COUNT(*) AS TotalRows FROM Sales;
SELECT COUNT(Region) AS NonNullRegions FROM Sales;
SELECT COUNT(*) AS TotalRows FROM Sales WHERE Region IS NOT NULL;
------------------------- ******************** ----------------------------