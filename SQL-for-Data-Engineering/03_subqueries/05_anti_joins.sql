USE [DataPurBatch01]
GO

-- Anti-Join using NOT EXISTS
-- Returns patients who do NOT have any matching record in the diagnoses table
SELECT name, age
FROM patients p
WHERE NOT EXISTS (
    SELECT 1
    FROM diagnoses d
    WHERE d.patient_id = p.patient_id
)

-- Anti-Join using NOT IN
-- Returns patients who do NOT have any matching record in the diagnoses table
-- Note: This query may return no rows if diagnoses.patient_id contains NULLs
SELECT name, age
FROM patients
WHERE patient_id NOT IN (
    SELECT patient_id
    FROM diagnoses
)