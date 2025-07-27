USE [DataPurBatch01]
GO

-- ============================================
-- Scalar Subquery Examples (SELECT, FROM, WHERE)
-- ============================================ 
-- Scalar Subquery in SELECT Clause
-- Adds the overall average age to every patient row
SELECT 
    name,
    age,
    (SELECT AVG(age) FROM patients) AS AvgAge
FROM patients;

-- --------------------------------------------

-- Scalar Subquery in FROM Clause
-- Retrieves total number of patients as a single-row result
SELECT TotalPatients AS PatientCount
FROM (
    SELECT COUNT(*) AS TotalPatients
    FROM patients
) AS sub

-- --------------------------------------------

-- Scalar Subquery in WHERE Clause
-- Retrieves patients older than the average patient age
SELECT 
    name,
    age
FROM patients
WHERE age > (SELECT AVG(age) FROM patients)
