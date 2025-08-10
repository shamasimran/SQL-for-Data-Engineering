
USE [DataPurBatch01]
GO

----------------------------------------------
-- 1. READ UNCOMMITTED — Dirty Read Allowed
----------------------------------------------

BEGIN TRAN;
UPDATE patients
SET age = 99
WHERE patient_id = 101;

WAITFOR DELAY '00:00:30';

ROLLBACK;


----------------------------------------------
-- 2. READ COMMITTED — Dirty Read Prevented
----------------------------------------------

BEGIN TRAN;
UPDATE patients
SET age = 88
WHERE patient_id = 101;
-- ROLLBACK;

----------------------------------------------
-- 3. REPEATABLE READ — Locks Rows for Duration
----------------------------------------------

UPDATE patients
SET age = 78
WHERE patient_id = 101;
-- Blocks until Session 1 commits

----------------------------------------------
-- 4. SERIALIZABLE — Prevents Phantom Reads
----------------------------------------------
-- SELECT * FROM patients
INSERT INTO patients (patient_id, name, age, diagnosis, hierarchy_id)
VALUES (20006, 'New Patient 20006', 65, 'Checkup', 1);
-- Blocks until Session 1 completes


----------------------------------------------
-- 5. SNAPSHOT — Versioned, Non-Blocking Reads
----------------------------------------------
UPDATE patients
SET age = 55
WHERE patient_id = 101;
-- COMMIT;

-- Wait and re-read after Session 2
SELECT patient_id, age FROM patients WHERE patient_id = 101;



