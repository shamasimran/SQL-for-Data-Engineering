
USE [DataPurBatch01]
GO

----------------------------------------------
-- 1. READ UNCOMMITTED — Dirty Read Allowed
----------------------------------------------

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
BEGIN TRAN;

SELECT patient_id, age
FROM patients
WHERE patient_id = 101;

-- Leave transaction open...
-- COMMIT;

						--Result:
						--Session 1 sees uncommitted changes — a dirty read.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------
-- 2. READ COMMITTED — Dirty Read Prevented
----------------------------------------------

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRAN;

SELECT patient_id, age
FROM patients
WHERE patient_id = 101;

-- COMMIT;
			--Result:
			--Session 1 waits if Session 2 hasn’t committed. No dirty reads.


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------
-- 3. REPEATABLE READ — Locks Rows for Duration
----------------------------------------------

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRAN;

-- First read
SELECT age FROM patients WHERE patient_id = 101;

WAITFOR DELAY '00:00:30';

-- Do not commit yet — repeat this after Session 2
SELECT age FROM patients WHERE patient_id = 101;

COMMIT;

				--Result:
				--Session 1 gets same data both times. Session 2 is blocked. Prevents non-repeatable reads.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------
-- 4. SERIALIZABLE — Prevents Phantom Reads
----------------------------------------------

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRAN;

-- First read: count patients > 60
SELECT COUNT(*) FROM patients WHERE age > 60;

WAITFOR DELAY '00:00:30';

-- Re-run after Session 2
SELECT COUNT(*) FROM patients WHERE age > 60;

COMMIT;

			--Result:
			--Insert is blocked. Session 1 gets same row count both times — no phantom rows.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------
-- 5. SNAPSHOT — Versioned, Non-Blocking Reads
----------------------------------------------
ALTER DATABASE DataPurBatch01
SET ALLOW_SNAPSHOT_ISOLATION ON;

SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
BEGIN TRAN;

SELECT patient_id, age FROM patients WHERE patient_id = 101;

WAITFOR DELAY '00:00:30';

-- Wait and re-read after Session 2
SELECT patient_id, age FROM patients WHERE patient_id = 101;

COMMIT;

			--Result:
			--Session 1 sees the same value both times, unaffected by Session 2. No locks or blocking.
