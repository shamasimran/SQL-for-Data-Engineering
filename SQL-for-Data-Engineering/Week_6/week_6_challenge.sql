-- Week 6 – Data Cleaning & Transformation
-- Challenge: Clean raw insurance claims and convert to a clean staging table
CREATE TABLE stage_claims AS
SELECT 
  claim_id,
  LOWER(TRIM(claim_status)) AS claim_status,
  CAST(claim_amount AS DECIMAL(10,2)) AS amount,
  TO_DATE(submitted_date, 'YYYY-MM-DD') AS claim_date
FROM raw_claims_data;