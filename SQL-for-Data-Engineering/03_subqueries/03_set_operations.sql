USE [DataPurBatch01]
GO

-- Set Operators: UNION, UNION ALL, INTERSECT, EXCEPT

-- Sample Data Prep (if needed, use a temp table or run independently)
-- These queries assume patient names may appear in both groups (for demo)

-- UNION vs UNION ALL
-- UNION removes duplicates, UNION ALL keeps them

-- UNION: Removes duplicate names
SELECT name FROM patients WHERE age > 60
UNION
SELECT name FROM patients WHERE diagnosis = 'Hypertension';

-- UNION ALL: Keeps duplicates (may show same name multiple times)
SELECT name FROM patients WHERE age > 60
UNION ALL
SELECT name FROM patients WHERE diagnosis = 'Hypertension';

-- INTERSECT: Returns names that appear in both sets
SELECT name FROM patients WHERE age > 60
INTERSECT
SELECT name FROM patients WHERE diagnosis = 'Hypertension';

-- EXCEPT: Returns names in the first set but NOT in the second
SELECT name FROM patients WHERE age > 60
EXCEPT
SELECT name FROM patients WHERE diagnosis = 'Hypertension';
