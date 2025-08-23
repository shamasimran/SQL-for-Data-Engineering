USE [DataPurBatch01]
GO

-- Example: CTE to find patients with above-average hospital stay per department

-- First CTE: calculate days in hospital per visit
WITH PatientStay AS (
    SELECT 
        hv.patient_id,
        p.name,
        hv.department,
        DATEDIFF(DAY, hv.admit_date, hv.discharge_date) AS stay_days
    FROM hospital_visits hv
    JOIN patients p 
        ON hv.patient_id = p.patient_id
),

-- Second CTE: aggregate total days per patient
TotalStay AS (
    SELECT 
        patient_id,
        name,
        department,
        SUM(stay_days) AS total_stay_days
    FROM PatientStay
    GROUP BY patient_id, name, department
),

-- Third CTE: calculate department averages
DeptAverage AS (
    SELECT 
        department,
        AVG(total_stay_days) AS avg_stay_days
    FROM TotalStay
    GROUP BY department
)

-- Final query: get patients above department average
SELECT 
    ts.patient_id,
    ts.name,
    ts.department,
    ts.total_stay_days,
    da.avg_stay_days
FROM TotalStay ts
JOIN DeptAverage da 
    ON ts.department = da.department
WHERE ts.total_stay_days > da.avg_stay_days
ORDER BY ts.department, ts.total_stay_days DESC;


-- Recursive CTE to traverse the hierarchy from Client to Provider
WITH HierarchyCTE AS (
    -- Anchor member: start with top-level Clients
    SELECT 
        hierarchy_id,
        parent_id,
        hierarchy_name,
        hierarchy_type,
        0 AS level
    FROM hierarchy
    WHERE parent_id IS NULL

    UNION ALL

    -- Recursive member: get children of the current level
    SELECT 
        h.hierarchy_id,
        h.parent_id,
        h.hierarchy_name,
        h.hierarchy_type,
        c.level + 1
    FROM hierarchy h
    INNER JOIN HierarchyCTE c
        ON h.parent_id = c.hierarchy_id
)
SELECT 
    REPLICATE('    ', level) + hierarchy_name AS hierarchy_path,
    hierarchy_type,
    level
FROM HierarchyCTE
ORDER BY hierarchy_path;

--SELECT REPLICATE('s', 0) AS zero, REPLICATE('s', 1) AS one, REPLICATE('s', 2) AS two