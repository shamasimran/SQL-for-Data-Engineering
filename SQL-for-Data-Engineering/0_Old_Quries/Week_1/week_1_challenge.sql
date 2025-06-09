-- Week 1 – SQL Basics & Data Profiling
-- Challenge: Find the top 10 oldest patients with diabetes
SELECT patient_id, name, age, diagnosis
FROM patients
WHERE diagnosis ILIKE '%diabetes%'
ORDER BY age DESC
LIMIT 10;