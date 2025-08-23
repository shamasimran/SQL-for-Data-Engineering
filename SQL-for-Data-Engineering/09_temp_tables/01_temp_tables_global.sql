
USE [DataPurBatch01]
GO
-- Step 1: Create and populate a global temp table
IF OBJECT_ID('tempdb..##DeptVisitCounts') IS NOT NULL
    DROP TABLE ##DeptVisitCounts;

SELECT 
    department,
    COUNT(*) AS visit_count
INTO ##DeptVisitCounts
FROM hospital_visits
GROUP BY department;

-- Step 2: Query the global temp table
SELECT * FROM ##DeptVisitCounts;



/*
Test 1:
Run Step 1 in one SQL Server session.
Open a new query window (different session) in SSMS, and run following script
*/

SELECT * FROM ##DeptVisitCounts;

/*
Test 2:
Close this window (where we created this table)
Open a new query window (different session) in SSMS, and run following script
*/

SELECT * FROM ##DeptVisitCounts;