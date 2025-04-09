
# SQL Healthcare Data Engineering Challenges

## Week 8

This folder contains the SQL challenge for Week 8. The challenge is designed to enhance your SQL skills and knowledge by working on healthcare-related datasets.

### Challenge:
SQL challenge for Week 8 aligned with healthcare data engineering.

### Instructions:
1. Set up your SQL environment and create the required tables.
2. Run the provided queries to solve the challenge.
3. Experiment with modifying the queries and optimizing them.
4. Test the queries using the sample data provided.

### SQL File:
The SQL code for this challenge is located in the `week_8_challenge.sql` file.


### SQL Query Explanation

### Explanation:
This query optimizes a slow-running query by:
- Joining multiple healthcare tables (`hospital_visits`, `patients`, `diagnoses`).
- Using indexed fields like `patient_id` and `visit_date` to speed up the query execution.
- The query selects visits from the last year and orders them by `visit_date` in descending order.
