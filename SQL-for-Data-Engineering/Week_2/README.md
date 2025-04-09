
# SQL Healthcare Data Engineering Challenges

## Week 2

This folder contains the SQL challenge for Week 2. The challenge is designed to enhance your SQL skills and knowledge by working on healthcare-related datasets.

### Challenge:
SQL challenge for Week 2 aligned with healthcare data engineering.

### Instructions:
1. Set up your SQL environment and create the required tables.
2. Run the provided queries to solve the challenge.
3. Experiment with modifying the queries and optimizing them.
4. Test the queries using the sample data provided.

### SQL File:
The SQL code for this challenge is located in the `week_2_challenge.sql` file.


### SQL Query Explanation

### Explanation:
This query joins multiple tables (`patients`, `diagnoses`, and `patient_vitals`) to get the latest blood pressure reading for each patient along with their diagnosis.
- A `ROW_NUMBER()` function is used to assign a rank to each patient's vital readings, ordered by `vitals_date` in descending order.
- The latest reading (with rank 1) is selected for each patient.
