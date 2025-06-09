
# SQL Healthcare Data Engineering Challenges

## Week 6

This folder contains the SQL challenge for Week 6. The challenge is designed to enhance your SQL skills and knowledge by working on healthcare-related datasets.

### Challenge:
SQL challenge for Week 6 aligned with healthcare data engineering.

### Instructions:
1. Set up your SQL environment and create the required tables.
2. Run the provided queries to solve the challenge.
3. Experiment with modifying the queries and optimizing them.
4. Test the queries using the sample data provided.

### SQL File:
The SQL code for this challenge is located in the `week_6_challenge.sql` file.


### SQL Query Explanation

### Explanation:
This query cleans the raw insurance claims data by:
- Trimming extra spaces from `claim_status`.
- Converting `claim_amount` to a `DECIMAL(10,2)` for proper numeric formatting.
- Converting the `submitted_date` to a `DATE` format.
- The cleaned data is inserted into the `stage_claims` table for further processing.
