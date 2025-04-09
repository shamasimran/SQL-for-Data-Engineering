-- Week 2 – Joins & Data Relationships
-- Challenge: Get the latest blood pressure reading for each patient along with their diagnosis
WITH latest_vitals AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY vitals_date DESC) AS rn
  FROM patient_vitals
)
SELECT p.patient_id, p.name, d.diagnosis, v.blood_pressure, v.vitals_date
FROM patients p
JOIN diagnoses d ON p.patient_id = d.patient_id
JOIN latest_vitals v ON p.patient_id = v.patient_id AND v.rn = 1;