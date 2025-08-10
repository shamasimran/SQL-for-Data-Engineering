USE [DataPurBatch01]
GO

/* =========================================================
   Step 1: Enable Deadlock Detection via Extended Events
   ========================================================= */
-- system_health session is usually on by default; this captures deadlocks
SELECT * 
FROM sys.dm_xe_sessions 
WHERE name = 'system_health';

-- Query to check captured deadlocks after simulation
-- SELECT XEventData.value('(event/data/value)[1]', 'varchar(max)') AS DeadlockGraph
-- FROM (
--     SELECT CAST(event_data AS XML) AS XEventData
--     FROM sys.fn_xe_file_target_read_file(
--         'system_health*.xel', NULL, NULL, NULL
--     )
--     WHERE CAST(event_data AS XML).value('(/event/@name)[1]', 'varchar(50)') = 'xml_deadlock_report'
-- ) AS Deadlocks;


/* =========================================================
   Step 2: Run these in TWO separate sessions to cause a deadlock
   ========================================================= */

-- SESSION 1
/*
BEGIN TRAN;
UPDATE patients
SET age = age + 1
WHERE patient_id = 101;  -- Use an existing patient_id in your table

WAITFOR DELAY '00:00:05'; -- pause so Session 2 can execute

UPDATE diagnoses
SET diagnosis = 'Updated Diagnosis - Session1'
WHERE diagnosis_id = 201; -- Use an existing diagnosis_id in your table
COMMIT;
*/

-- SESSION 2
/*
BEGIN TRAN;
UPDATE diagnoses
SET diagnosis = 'Updated Diagnosis - Session2'
WHERE diagnosis_id = 201; -- Same ID as in Session 1

WAITFOR DELAY '00:00:05'; -- pause so Session 1 can execute

UPDATE patients
SET age = age + 1
WHERE patient_id = 101; -- Same ID as in Session 1
COMMIT;
*/


/* =========================================================
   Step 3: After deadlock occurs, check captured deadlock graph
   ========================================================= */
WITH Deadlocks AS (
    SELECT CAST(event_data AS XML) AS DeadlockXML
    FROM sys.fn_xe_file_target_read_file(
        'system_health*.xel', NULL, NULL, NULL
    )
    WHERE CAST(event_data AS XML).value('(/event/@name)[1]', 'varchar(50)') = 'xml_deadlock_report'
)
SELECT
    DeadlockXML.value('(//victim-list/victimProcess/@id)[1]', 'varchar(50)') AS VictimProcessID,
    DeadlockXML.value('(//process-list/process/inputbuf/text())[1]', 'varchar(max)') AS Process1SQL,
    DeadlockXML.value('(//process-list/process/inputbuf/text())[2]', 'varchar(max)') AS Process2SQL
FROM Deadlocks;