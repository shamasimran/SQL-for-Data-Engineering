
# SQL Healthcare Data Engineering Challenges

## Week 3

This folder contains the SQL challenge for Week 3. The challenge is designed to enhance your SQL skills and knowledge by working on healthcare-related datasets.

### Challenge:
SQL challenge for Week 3 aligned with healthcare data engineering.

### Instructions:
1. Set up your SQL environment and create the required tables.
2. Run the provided queries to solve the challenge.
3. Experiment with modifying the queries and optimizing them.
4. Test the queries using the sample data provided.

### SQL File:
The SQL code for this challenge is located in the `week_3_challenge.sql` file.


### SQL Query Explanation

### Explanation:
This query calculates the average length of stay for each hospital department.
- It calculates the difference between `discharge_date` and `admit_date` in days using the `DATE_PART` function.
- The `AVG()` function is used to calculate the average length of stay, grouped by department.
