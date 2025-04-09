-- Week 4 – Subqueries & CTEs
-- Challenge: Find patients with more than 3 emergency visits in the last 6 months
WITH recent_visits AS (
  SELECT *
  FROM hospital_visits
  WHERE visit_type = 'emergency'
    AND visit_date >= CURRENT_DATE - INTERVAL '6 months'
)
SELECT patient_id, COUNT(*) AS emergency_visits
FROM recent_visits
GROUP BY patient_id
HAVING COUNT(*) > 3;