USE [DataPurBatch01]
GO

-- Basic SELECT with Column Aliases

SELECT * FROM patients;

SELECT 
    patient_id AS ID, 
    name AS PatientName, 
    age 
FROM patients;


-- Alternate Alias Syntax (Alias = ColumnName)
SELECT 
    ID = patient_id, 
    PatientName = name , 
    age AS CurrentAge
FROM patients;

-- Filter: Age >= 60 AND Diagnosis = 'Hypertension'
SELECT name, age, diagnosis 
FROM patients 
WHERE age = 60 
AND diagnosis = 'Hypertension';

-- Filter: Patients under 30 with either Diabetes OR Hypertension
SELECT name, age, diagnosis 
FROM patients 
WHERE age < 30 AND (diagnosis = 'Diabetes' OR diagnosis = 'Hypertension');

-- Filter: Exclude Patients Diagnosed with Diabetes
SELECT name, diagnosis 
FROM patients 
WHERE NOT diagnosis = 'Diabetes';

-- LIKE: Names starting with 'P'
SELECT name FROM patients WHERE name LIKE 'P%';

-- LIKE: Names where second character is 'a'
SELECT name FROM patients WHERE name LIKE '_a%';

-- LIKE with character set: Match Sara or Sera
SELECT name FROM patients WHERE name LIKE 'p[ae]tient 1%';

-- LIKE with exclusion: Match Jihn, Jehn (exclude John)
SELECT name FROM patients WHERE name LIKE 'patient [^1]';


-- ORDER BY Age Descending (Oldest to Youngest)
SELECT name, age 
FROM patients 
ORDER BY age DESC, Name Asc;

-- IS NULL: Patients without email address
SELECT name, diagnosis 
FROM patients 
WHERE diagnosis IS NULL;


SELECT * FROM patients 
WHERE diagnosis IS NULL;

-- IS NOT NULL: Patients with email address
SELECT name, diagnosis 
FROM patients 
WHERE diagnosis IS NOT NULL;

SELECT     
name,
age, 
CASE diagnosis
WHEN 'Diabetes' THEN 'High Risk'
WHEN 'Hypertension' THEN 'Mild Risk'
ELSE 'No Risk'
END AS RiskLevel
FROM patients;


-- CASE Statement: Categorize Age Groups
SELECT 
    name,
    age,
    diagnosis,
    CASE 
        WHEN age < 30 THEN 'Young'
        WHEN age BETWEEN 30 AND 59 THEN 'Middle Aged'
        ELSE 'Senior'
    END AS AgeGroup
FROM patients;


-- IIF Function (SQL Server): Simple Age Category
SELECT 
    name,
    age,
    IIF(age > 50, 'TRUE', 'FALSE') AS AgeCategory
FROM patients;
