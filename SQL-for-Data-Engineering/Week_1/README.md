
# SQL Healthcare Data Engineering Challenges

## Week 1

This folder contains the SQL challenge for Week 1. The challenge is designed to enhance your SQL skills and knowledge by working on healthcare-related datasets.

### Challenge:
SQL challenge for Week 1 aligned with healthcare data engineering.

### Instructions:
1. Set up your SQL environment and create the required tables.
2. Run the provided queries to solve the challenge.
3. Experiment with modifying the queries and optimizing them.
4. Test the queries using the sample data provided.

### SQL File:
The SQL code for this challenge is located in the `week_1_challenge.sql` file.


### SQL Query Explanation

### Explanation:
This query retrieves the top 10 oldest patients diagnosed with diabetes from the `patients` table.
- The `ILIKE` operator is used to perform a case-insensitive search for any diagnosis containing the word 'diabetes'.
- The results are ordered by age in descending order to list the oldest patients first.
