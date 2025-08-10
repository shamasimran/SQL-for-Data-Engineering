USE [DataPurBatch01]
GO

SELECT patient_id, name, age
FROM patients
WHERE patient_id IN (101, 102)

-- Begin the transaction
BEGIN TRAN;

-- Step 1: Update Patient 101
UPDATE patients
SET age = age + 1
WHERE patient_id = 101;

-- Set a savepoint after first update
SAVE TRAN SavePoint_Patient101;

-- Step 2: Update Patient 102
UPDATE patients
SET age = age + 1
WHERE patient_id = 102;

-- Step 3: Decide to rollback only the second update
-- This will undo changes made after the savepoint
ROLLBACK TRAN SavePoint_Patient101;

-- Step 4: Commit the transaction
-- Only the update to Patient 101 will be saved
COMMIT;

SELECT patient_id, name, age
FROM patients
WHERE patient_id IN (101, 102)
