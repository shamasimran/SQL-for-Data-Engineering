USE [DataPurBatch01]
GO

-- ============================================
-- Correlated Subquery Examples (SELECT, FROM, WHERE)
-- ============================================

-- Correlated Subquery in SELECT Clause
-- Retrieves the latest diagnosis for each patient by matching patient_id
SELECT 
    p.name,
    p.age,
    (
        SELECT TOP 1 d.diagnosis
        FROM diagnoses d
        WHERE d.patient_id = p.patient_id
        ORDER BY d.diagnosis_id DESC
    ) AS LatestDiagnosis
FROM patients p;

-- --------------------------------------------

-- Correlated Subquery in FROM Clause
-- Gets the number of diagnoses per patient and joins it inline
SELECT 
    p.name,
    d.DiagnosisCount
FROM patients p
JOIN (
    SELECT patient_id, COUNT(*) AS DiagnosisCount
    FROM diagnoses
    GROUP BY patient_id
) d ON p.patient_id = d.patient_id;

-- --------------------------------------------

-- Correlated Subquery in WHERE Clause
-- Retrieves patients who have at least one diagnosis entry
SELECT 
    name,
    age
FROM patients p
WHERE EXISTS (
    SELECT 1
    FROM diagnoses d
    WHERE d.patient_id = p.patient_id
);
