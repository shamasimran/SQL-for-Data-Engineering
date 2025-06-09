
# SQL Healthcare Data Engineering Challenges

## Week 4

This folder contains the SQL challenge for Week 4. The challenge is designed to enhance your SQL skills and knowledge by working on healthcare-related datasets.

### Challenge:
SQL challenge for Week 4 aligned with healthcare data engineering.

### Instructions:
1. Set up your SQL environment and create the required tables.
2. Run the provided queries to solve the challenge.
3. Experiment with modifying the queries and optimizing them.
4. Test the queries using the sample data provided.

### SQL File:
The SQL code for this challenge is located in the `week_4_challenge.sql` file.


### SQL Query Explanation

### Explanation:
This query finds patients who have had more than 3 emergency visits in the last 6 months.
- The `WITH` clause creates a CTE (`recent_visits`) that filters for emergency visits within the last 6 months.
- The main query counts the number of emergency visits per patient, returning those with more than 3 visits.
