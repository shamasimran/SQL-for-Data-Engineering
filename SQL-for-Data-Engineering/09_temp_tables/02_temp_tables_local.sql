USE [DataPurBatch01]
GO


-- Step 0: Drop the local temp table if it already exists
IF OBJECT_ID('tempdb..#PatientSummary') IS NOT NULL
    DROP TABLE #PatientSummary;

-- Step 1: Create a local temp table
CREATE TABLE #PatientSummary (
    patient_id INT,
    department VARCHAR(100),
    visit_count INT
);

-- Step 2: Populate it from existing tables
INSERT INTO #PatientSummary (patient_id, department, visit_count)
SELECT 
    hv.patient_id,
    hv.department,
    COUNT(*) AS visit_count
FROM hospital_visits hv
GROUP BY hv.patient_id, hv.department;

-- Step 3: Create a nonclustered index on the temp table
CREATE NONCLUSTERED INDEX IX_PatientSummary_Department
ON #PatientSummary (department);

-- Step 4: Query using the index
SELECT *
FROM #PatientSummary
WHERE department = 'Cardiology';

-- Step 5: Drop explicitly (optional, will auto-drop at session end)
DROP TABLE #PatientSummary;
