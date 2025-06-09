
# SQL Healthcare Data Engineering Challenges

## Week 5

This folder contains the SQL challenge for Week 5. The challenge is designed to enhance your SQL skills and knowledge by working on healthcare-related datasets.

### Challenge:
SQL challenge for Week 5 aligned with healthcare data engineering.

### Instructions:
1. Set up your SQL environment and create the required tables.
2. Run the provided queries to solve the challenge.
3. Experiment with modifying the queries and optimizing them.
4. Test the queries using the sample data provided.

### SQL File:
The SQL code for this challenge is located in the `week_5_challenge.sql` file.


### SQL Query Explanation

### Explanation:
This query calculates the 7-day moving average of heart rate for each patient.
- The `AVG()` window function is used to calculate the average heart rate over a rolling 7-day window.
- The `PARTITION BY` clause ensures the moving average is calculated for each patient separately.
