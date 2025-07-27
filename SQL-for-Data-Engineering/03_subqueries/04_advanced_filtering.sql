USE [DataPurBatch01]
GO

-- IN: Returns patients who have been diagnosed with 'Diabetes Type 2'
SELECT name, age
FROM patients
WHERE patient_id IN (
    SELECT patient_id
    FROM diagnoses
    WHERE diagnosis = 'Diabetes Type 2'
);

-- NOT IN: Returns patients who have NOT been diagnosed with 'Hypertension Stage 1'
SELECT name, age
FROM patients
WHERE patient_id NOT IN (
    SELECT patient_id
    FROM diagnoses
    WHERE diagnosis = 'Hypertension Stage 1'
);

-- EXISTS: Returns patients who have at least one diagnosis
SELECT name, age
FROM patients p
WHERE EXISTS (
    SELECT 1
    FROM diagnoses d
    WHERE d.patient_id = p.patient_id
);

-- NOT EXISTS: Returns patients who have no diagnosis at all
SELECT name, age
FROM patients p
WHERE NOT EXISTS (
    SELECT 1
    FROM diagnoses d
    WHERE d.patient_id = p.patient_id
);
