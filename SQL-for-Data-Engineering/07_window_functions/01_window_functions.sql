
USE [DataPurBatch01]
GO
-- =====================================================
-- WINDOW FUNCTIONS DEMONSTRATION SCRIPT
-- All Ranking, Aggregate, and Value Window Functions
-- Using Data from DB_Schema.sql
-- =====================================================

/* 
1. Ranking Window Functions Syntax:
ROW_NUMBER()    -> ROW_NUMBER() OVER ( [PARTITION BY col] ORDER BY col )
                   Assigns a unique sequential number to rows within each partition based on the ORDER BY clause.
RANK()          -> RANK() OVER ( [PARTITION BY col] ORDER BY col )
                   Assigns a rank to rows with gaps for ties.
DENSE_RANK()    -> DENSE_RANK() OVER ( [PARTITION BY col] ORDER BY col )
                   Assigns a rank to rows without gaps for ties.
PERCENT_RANK()  -> PERCENT_RANK() OVER ( [PARTITION BY col] ORDER BY col )
                   Calculates the relative rank of a row as a percentage between 0 and 1.
				   PERCENT_RANK=  Rank−1 / Total Rows in Partition−1​
NTILE(n)        -> NTILE(n) OVER ( [PARTITION BY col] ORDER BY col )
                   Divides rows into n groups and assigns a group number to each row.

2. Aggregate Window Functions Syntax:
SUM()           -> SUM(expr) OVER ( [PARTITION BY col] [ORDER BY col] )
                   Returns the total of the expression over the window frame.
AVG()           -> AVG(expr) OVER ( [PARTITION BY col] [ORDER BY col] )
                   Returns the average of the expression over the window frame.
COUNT()         -> COUNT(expr) OVER ( [PARTITION BY col] [ORDER BY col] )
                   Returns the number of rows or non-null values over the window frame.
MIN()           -> MIN(expr) OVER ( [PARTITION BY col] [ORDER BY col] )
                   Returns the smallest value over the window frame.
MAX()           -> MAX(expr) OVER ( [PARTITION BY col] [ORDER BY col] )
                   Returns the largest value over the window frame.

3. Value Window Functions Syntax:
LAG()           -> LAG(expr [, offset] [, default]) OVER ( [PARTITION BY col] ORDER BY col )
                   Returns the value from a preceding row at a given offset.
LEAD()          -> LEAD(expr [, offset] [, default]) OVER ( [PARTITION BY col] ORDER BY col )
                   Returns the value from a following row at a given offset.
FIRST_VALUE()   -> FIRST_VALUE(expr) OVER ( [PARTITION BY col] ORDER BY col )
                   Returns the first value in the window frame.
LAST_VALUE()    -> LAST_VALUE(expr) OVER ( [PARTITION BY col] ORDER BY col ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
                   Returns the last value in the window frame.
*/

SELECT 
	hv.department,
    hv.visit_date,
    hv.patient_id,
    p.name,
    DATEDIFF(DAY, hv.admit_date, hv.discharge_date) AS days_in_hospital,

    ROW_NUMBER() OVER (ORDER BY hv.patient_id ASC, hv.visit_date DESC) AS flat_row_num,

    -- Ranking Window Functions
    ROW_NUMBER() OVER (PARTITION BY hv.department ORDER BY hv.patient_id ASC, hv.visit_date DESC ) AS row_num,
	--check for patient_id: 161
	RANK() OVER (PARTITION BY hv.department ORDER BY hv.patient_id ASC, hv.visit_date DESC) AS rank_num,
    DENSE_RANK() OVER (PARTITION BY hv.department ORDER BY hv.patient_id ASC, hv.visit_date DESC) AS dense_rank_num,
    PERCENT_RANK() OVER (PARTITION BY hv.department ORDER BY hv.patient_id ASC, hv.visit_date DESC) AS percent_rank_num,
    NTILE(4) OVER (PARTITION BY hv.department ORDER BY hv.patient_id ASC, hv.visit_date DESC) AS quartile,

    -- Aggregate Window Functions
    SUM(DATEDIFF(DAY, hv.admit_date, hv.discharge_date)) OVER (PARTITION BY hv.department) AS total_days_in_dept,
	-- Running total of hospital days within each department
    SUM(DATEDIFF(DAY, hv.admit_date, hv.discharge_date)) OVER (
        PARTITION BY hv.department
        ORDER BY hv.patient_id ASC, hv.visit_date DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_days,


    AVG(DATEDIFF(DAY, hv.admit_date, hv.discharge_date)) OVER (PARTITION BY hv.department) AS avg_days_in_dept,
    COUNT(*) OVER (PARTITION BY hv.department) AS visit_count_in_dept,
    MIN(hv.admit_date) OVER (PARTITION BY hv.department) AS first_admit_in_dept,
    MAX(hv.discharge_date) OVER (PARTITION BY hv.department) AS last_discharge_in_dept,

    -- Value Window Functions
    LAG(hv.visit_date) OVER (PARTITION BY hv.patient_id ORDER BY hv.patient_id ASC, hv.visit_date DESC) AS prev_visit,
    LEAD(hv.visit_date) OVER (PARTITION BY hv.patient_id ORDER BY hv.patient_id ASC, hv.visit_date DESC) AS next_visit,
    FIRST_VALUE(hv.visit_date) OVER (PARTITION BY hv.patient_id ORDER BY hv.patient_id ASC, hv.visit_date DESC) AS first_visit,
    LAST_VALUE(hv.visit_date) OVER (
        PARTITION BY hv.patient_id 
        ORDER BY hv.patient_id ASC, hv.visit_date DESC 
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
		-- window frame specification
		--UNBOUNDED PRECEDING: start from the very first row in the partition.
		--UNBOUNDED FOLLOWING: end at the very last row in the partition.
    ) AS last_visit

FROM hospital_visits hv
JOIN patients p ON hv.patient_id = p.patient_id
ORDER BY hv.department, hv.patient_id ASC, hv.visit_date DESC
