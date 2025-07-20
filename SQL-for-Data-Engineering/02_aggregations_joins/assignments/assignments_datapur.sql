
/*
	User Story: ST001
	Title: Patient Analytics & Grouping Insights
    As a healthcare data analyst, I want to create summary-level reports using aggregates and grouping 
	features so that I can present meaningful insights to my management team.

	Instructions: Write ONE SQL query for each of the following tasks.

	1.	Write a query to get the total number of patients in the system.
	2.	Find the average age of all patients.
	3.	Display the maximum and minimum heart rate from patient_vitals.
	4.	Count the number of distinct diagnoses from the diagnoses table.
	5.	Show that NULL values are ignored in aggregate functions using SUM or AVG with a sample example.
	6.	Group patients by diagnosis and calculate the average age for each group.
	7.	Group patients by diagnosis and hierarchy_id, and count how many patients are in each group.
	8.	Group patients into age buckets (<30, 30-60, >60) using a CASE expression and count the patients in each.
	9.	Use a ROLLUP to get a summary report showing patient counts per provider, including subtotals at practice and client level (join with hierarchy).
	10.	Use a CUBE to get the total number of visits grouped by department and visit_type.
	11.	Use GROUPING_ID() to determine which rows are actual data and which are subtotals from a ROLLUP or CUBE.
	12.	Write a query to find diagnoses that have been assigned to more than 10 patients using GROUP BY and HAVING.
	13.	Write a query to find average age of patients grouped by hierarchy_id where the average is greater than 60 using HAVING.

*/

/*
	User Story: ST002
	Title: Join-Based Exploration Across Healthcare Entities
	As a data integration engineer, I need to join and analyze records across multiple healthcare tables so that I can prepare 
	combined views for clinical and operational reporting.
	
	Instructions: Write ONE SQL query for each of the following tasks.

	1.	Use an INNER JOIN to display patient names, age, and department for patients who have at least one hospital visit.
	2.	Use a LEFT JOIN to show all patients along with their diagnosis (if any).
	3.	Use a RIGHT JOIN to show all diagnoses, including those that do not have a matching patient (use a temp table if necessary).
	4.	Use a FULL OUTER JOIN to compare hospital visits and patient vitals, showing all matches and non-matches.
	5.	Use a self join on the hierarchy table to list each provider and their practice name.
	6.	Use a CROSS JOIN to generate all combinations of department and visit_type from hospital_visits.
	7.	Use CROSS APPLY to find the latest vitals (by vitals_date) for each patient.

*/