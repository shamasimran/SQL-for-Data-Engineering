-- Week 8 – Performance & Optimization
-- Challenge: Optimize a slow-running query joining multiple healthcare tables
-- Sample optimized version with indexed fields
SELECT v.visit_id, p.name, d.diagnosis, v.visit_date
FROM hospital_visits v
JOIN patients p ON v.patient_id = p.patient_id
JOIN diagnoses d ON d.patient_id = p.patient_id
WHERE v.visit_date >= CURRENT_DATE - INTERVAL '1 year'
  AND d.diagnosis IS NOT NULL
ORDER BY v.visit_date DESC;