USE [DataPurBatch01]
GO

-- INNER JOIN: Matching Rows from Both Tables
-- Get patient details with their hospital visit data (only matching records)

SELECT 
  p.patient_id AS p_patient_id
, hv.patient_id AS hv_patient_id
, p.name
, p.age
, hv.department
, hv.visit_date
FROM patients p
INNER JOIN hospital_visits hv ON p.patient_id = hv.patient_id
--INNER JOIN hospital_visits hv ON p.patient_id <> hv.patient_id
--WHERE p.patient_id = 1
--ORDER BY hv.patient_id
-------------------------------------------------------------------------------------
--SELECT * FROM diagnoses p WHERE patient_id = 1

-- LEFT JOIN: All Rows from Left, Matched from Right
-- Get all patients and their diagnosis if any
SELECT 
  p.patient_id AS p_patient_id
, d.patient_id AS d_patient_id
, p.name
, p.age
, d.diagnosis
FROM patients p
LEFT OUTER JOIN diagnoses d ON p.patient_id = d.patient_id
WHERE d.patient_id IS NULL

-- RIGHT JOIN: All Rows from Right, Matched from Left
-- Get all diagnosis records and match patients if they exist

SELECT * FROM patients p

IF OBJECT_ID('tempdb..#temp_diagnoses') IS NOT NULL
    DROP TABLE #temp_diagnoses;

SELECT * INTO #temp_diagnoses FROM diagnoses;
INSERT INTO #temp_diagnoses (diagnosis_id, patient_id, diagnosis)
VALUES 
(10001, 9999, 'Asthma'),
(10002, 10001, 'Allergy');

SELECT 
    p.patient_id AS p_patient_id,
    d.patient_id AS d_patient_id,
    p.name,
    p.age,
    d.diagnosis
FROM patients p
RIGHT JOIN #temp_diagnoses d ON p.patient_id = d.patient_id
WHERE p.patient_id IS NULL;

-- FULL OUTER JOIN: All Records from Both Sides
-- Combine all patients and all diagnosis data
IF OBJECT_ID('tempdb..#temp_diagnoses_v2') IS NOT NULL
    DROP TABLE #temp_diagnoses_v2;

SELECT * INTO #temp_diagnoses_v2 FROM diagnoses;
INSERT INTO #temp_diagnoses_v2 (diagnosis_id, patient_id, diagnosis)
VALUES 
(10001, 9999, 'Asthma'),
(10002, 10001, 'Allergy');

SELECT 
p.patient_id AS p_patient_id,
d.patient_id AS d_patient_id,
p.name AS PatientName, 
d.diagnosis
FROM patients p
FULL OUTER JOIN #temp_diagnoses_v2 d ON p.patient_id = d.patient_id;

-- 6. Self Join
-- Find Providers and their Practices from hierarchy table

SELECT * FROM hierarchy

SELECT 
    child.hierarchy_name AS Provider,
    parent.hierarchy_name AS Practice
FROM hierarchy child
JOIN hierarchy parent ON child.parent_id = parent.hierarchy_id
WHERE child.hierarchy_type = 'Provider' AND parent.hierarchy_type = 'Practice';


-- 7. Cross Join (Cartesian Product)
-- Get every combination of patient and hospital department
SELECT P.patient_id, p.name AS Patient, hv.department
FROM patients p
CROSS JOIN (SELECT DISTINCT department FROM hospital_visits) hv
--Where p.patient_id=1
ORDER BY p.patient_id

-- 8. CROSS APPLY
-- For each patient, get their latest vitals stats using CROSS APPLY
SELECT 
p.patient_id AS p_patient_id, 
p.name, v.vitals_date, v.heart_rate, v.blood_pressure
FROM patients p
CROSS APPLY (
    SELECT TOP 2 v.patient_id, vitals_date, heart_rate, blood_pressure
    FROM patient_vitals v
    WHERE v.patient_id = p.patient_id
    ORDER BY vitals_date DESC
)AS v

SELECT TOP 2 v.patient_id, vitals_date, heart_rate, blood_pressure
FROM patient_vitals v
WHERE v.patient_id = 1
ORDER BY vitals_date DESC
