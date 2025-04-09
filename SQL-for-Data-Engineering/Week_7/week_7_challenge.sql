-- Week 7 – Data Modeling with SQL
-- Challenge: Build a monthly claim summary table with total/avg amounts and status counts
CREATE TABLE monthly_claim_summary AS
SELECT 
  DATE_TRUNC('month', claim_date) AS claim_month,
  COUNT(*) AS total_claims,
  SUM(amount) AS total_amount,
  AVG(amount) AS avg_amount,
  COUNT(CASE WHEN claim_status = 'approved' THEN 1 END) AS approved_count,
  COUNT(CASE WHEN claim_status = 'denied' THEN 1 END) AS denied_count
FROM stage_claims
GROUP BY DATE_TRUNC('month', claim_date);