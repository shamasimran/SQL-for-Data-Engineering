-- Week 5 – Window Functions
-- Challenge: Calculate a 7-day moving average of heart rate per patient
SELECT patient_id, vitals_date, heart_rate,
       AVG(heart_rate) OVER (
         PARTITION BY patient_id 
         ORDER BY vitals_date 
         ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
       ) AS moving_avg_hr
FROM patient_vitals;