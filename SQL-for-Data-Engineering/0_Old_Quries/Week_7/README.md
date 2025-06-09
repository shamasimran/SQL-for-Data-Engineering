
# SQL Healthcare Data Engineering Challenges

## Week 7

This folder contains the SQL challenge for Week 7. The challenge is designed to enhance your SQL skills and knowledge by working on healthcare-related datasets.

### Challenge:
SQL challenge for Week 7 aligned with healthcare data engineering.

### Instructions:
1. Set up your SQL environment and create the required tables.
2. Run the provided queries to solve the challenge.
3. Experiment with modifying the queries and optimizing them.
4. Test the queries using the sample data provided.

### SQL File:
The SQL code for this challenge is located in the `week_7_challenge.sql` file.


### SQL Query Explanation

### Explanation:
This query builds a summary table (`monthly_claim_summary`) that aggregates claims data by month.
- The `DATE_TRUNC()` function is used to extract the month from `claim_date`.
- It calculates the total and average claim amount, as well as counts of 'approved' and 'denied' claim statuses.
