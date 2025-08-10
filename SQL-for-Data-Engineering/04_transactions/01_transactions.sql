USE [DataPurBatch01]
GO

SELECT patient_id, name, age
FROM patients
WHERE patient_id = 101;

-- Start of a transaction to update patient age
BEGIN TRAN;

-- Step 1: Update a patient's age
UPDATE patients
SET age = age + 1
WHERE patient_id = 101;

-- Step 2: Check the updated data (optional, for verification)
SELECT patient_id, name, age
FROM patients
WHERE patient_id = 101;

-- If everything looks fine, commit the transaction
COMMIT;

-- If you found an issue and want to undo the update, use ROLLBACK instead of COMMIT
--ROLLBACK;

SELECT patient_id, name, age
FROM patients
WHERE patient_id = 101;