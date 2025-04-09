-- Week 3 – Aggregations & Grouping
-- Challenge: Calculate the average length of stay per hospital department
SELECT department, 
       AVG(DATE_PART('day', discharge_date - admit_date)) AS avg_stay_days
FROM hospital_visits
GROUP BY department;