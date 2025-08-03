use DataPur;
/*
	User Story: ST001
	Title: Patient Analytics & Grouping Insights
    As a healthcare data analyst, I want to create summary-level reports using aggregates and grouping 
	features so that I can present meaningful insights to my management team.

	Instructions: Write ONE SQL query for each of the following tasks.
	*/
--	1.	Write a query to get the total number of patients in the system.
	

SELECT 
	COUNT(*) AS total_patients 
FROM dbo.patients;

--	2.	Find the average age of all patients.
	
SELECT
	AVG(age) AS Avg_age 
FROM patients;


SELECT 
	SUM(age)/ COUNT(*) AS Avg_age 
FROM patients;
	
	
--	3.	Display the maximum and minimum heart rate from patient_vitals. 

SELECT 
	MAX(heart_rate) AS max_heart_rate , MIN(heart_rate) AS min_heart_rate 
FROM patient_vitals;
	
--	4.	Count the number of distinct diagnoses from the diagnoses table. 
	  /*Diagnosis And Count against each Diagnosis*/
SELECT 
DISTINCT diagnosis AS Diagnosis_Name, 
COUNT(*) AS diagnosis_count 
FROM dbo.diagnoses GROUP BY diagnosis;
	 
	 /*Distinct Type of Diagnosis Count  */
SELECT 
	COUNT(DISTINCT diagnosis) as Distinct_Diagnosis
FROM dbo.diagnoses;
--	5.	Show that NULL values are ignored in aggregate functions using SUM or AVG with a sample example. 

 --Lets see that with an example, first we try to simulate sum part, as avg will ignore values
 --after point(after decimal point) as our column is integer so total sum count will be different
SELECT 
	AVG(parent_id) * COUNT(*) AS avg_example 
FROM hierarchy
UNION ALL
SELECT SUM(parent_id) AS sum_example
FROM hierarchy;

	/*This case we are deep diving the difference,
	we will check using 1. without floating point 2. with floating point to see real difference
	but as our parent id is integer
	so avg function will return answer in integer and answer will be not accurate */
	--1 without floating point difference
SELECT AVG(parent_id) AS avg_example
FROM hierarchy
	UNION ALL
SELECT SUM(parent_id)/COUNT(parent_id) AS sum_example
FROM hierarchy

--2 with floating point numbers
SELECT AVG(parent_id) AS avg_example
FROM hierarchy
UNION ALL
SELECT SUM(parent_id)* 1.0/count(parent_id) as sum_example 
FROM hierarchy

	--To fix that we simply first case the parent id as float, now both will have same answer
 SELECT AVG(CAST(parent_id AS FLOAT)) AS avg_result
 FROM hierarchy
 UNION ALL
 select SUM(parent_id) *  1.0/count(parent_id) as sum_example 
 FROM hierarchy;


--	6.	Group patients by diagnosis and calculate the average age for each group. 

 SELECT AVG(age) AS Avg_age, d.diagnosis AS Diagnosis_Type
 FROM patients p
 INNER JOIN diagnoses d
 ON p.patient_id = d.patient_id
 GROUP by d.diagnosis;


--	7.	Group patients by diagnosis and hierarchy_id, and count how many patients are in each group.	 
 SELECT COUNT(*) patient_count_per_Hierarchy_Diagnosis,d.diagnosis, p.hierarchy_id 
 FROM patients p
 INNER JOIN diagnoses d
 ON p.patient_id=d.patient_id
 GROUP BY d.diagnosis,p.hierarchy_id
 ORDER BY p.hierarchy_id;
	 --ordering data just to see more clear data

--	8.	Group patients into age buckets (<30, 30-60, >60) using a CASE expression and count the patients in each. 

 SELECT count(*) AS Age_group_Count, e.age_group AS AgeGroup FROM 
	( select name ,age,
		CASE
		WHEN age<30 THEN '<30'
		WHEN age>=30 AND age <=60 THEN '30-60'
		ELSE '>60'
		END as age_group
		from patients
	)as e
 GROUP BY e.age_group;



--	9.	Use a ROLLUP to get a summary report showing patient counts per provider, including subtotals at practice and client level (join with hierarchy). 
SELECT 
    client.hierarchy_name AS client_name,
    practice.hierarchy_name AS practice_name,
    provider.hierarchy_name AS provider_name,
    COUNT(p.patient_id) AS patient_count
FROM patients p
JOIN hierarchy provider ON provider.hierarchy_id = p.hierarchy_id
JOIN hierarchy practice ON practice.hierarchy_id = provider.parent_id
JOIN hierarchy client ON client.hierarchy_id = practice.parent_id
GROUP BY ROLLUP (
    client.hierarchy_name, 
    practice.hierarchy_name, 
    provider.hierarchy_name

)
/*	10.	Use a CUBE to get the total number of visits grouped by department and visit_type. */
SELECT 
    department,
    visit_type,
    COUNT(*) AS total_visits
FROM hospital_visits 
GROUP BY CUBE (department, visit_type)
	
	/*
	11.	Use GROUPING_ID() to determine which rows are actual data and which are subtotals from a ROLLUP or CUBE.
*/
SELECT 
    department,
    visit_type,
    COUNT(*) AS total_visits,
    GROUPING_ID(department, visit_type) AS grp_id
FROM hospital_visits
GROUP BY CUBE (department, visit_type)


--12.	Write a query to find diagnoses that have been assigned to more than 10 patients using GROUP BY and HAVING. 
SELECT 
	diagnosis , COUNT(*) AS Total_Patients 
FROM diagnoses
GROUP BY diagnosis HAVING COUNT(*) >=10
	/*
	13.	Write a query to find average age of patients grouped by hierarchy_id where the average is greater than 60 using HAVING.
	 */
	 Select avg(age) as Average_Age, hierarchy_id from patients group by hierarchy_id 
	 having avg(age)>60
	/*

*/

/*
	User Story: ST002
	Title: Join-Based Exploration Across Healthcare Entities
	As a data integration engineer, I need to join and analyze records across multiple healthcare tables so that I can prepare 
	combined views for clinical and operational reporting.
	
	Instructions: Write ONE SQL query for each of the following tasks.*/

--1.	Use an INNER JOIN to display patient names, age, and department for patients who have at least one hospital visit.

SELECT 
distinct p.name,p.age, hv.department
FROM patients p
INNER JOIN hospital_visits hv
ON p.patient_id=hv.patient_id
order by p.name;

--2.	Use a LEFT JOIN to show all patients along with their diagnosis (if any).
SELECT * 
FROM patients p
LEFT JOIN diagnoses d
ON p.patient_id= d.patient_id

--3.	Use a RIGHT JOIN to show all diagnoses, including those that do not have a matching patient (use a temp table if necessary).
--Creating Temp tables
SELECT * INTO #TempPatients
FROM Patients;
--Deleting patients with even ids to create a scenario where we can run our right join query.
DELETE 
FROM #TempPatients 
WHERE patient_id % 2 = 0;


SELECT *
FROM #TempPatients p
RIGHT JOIN diagnoses d
ON p.patient_id= d.patient_id

--4.	Use a FULL OUTER JOIN to compare hospital visits and patient vitals, showing all matches and non-matches

SELECT * 
FROM hospital_visits hv
FULL OUTER JOIN patient_vitals pv
ON  hv.patient_id= pv.patient_id;
--5.	Use a self join on the hierarchy table to list each provider and their practice name.

SELECT c.hierarchy_name AS Provider, p.hierarchy_name AS Practice_Name 
FROM hierarchy c
INNER JOIN hierarchy p
on p.hierarchy_id=c.parent_id
where p.parent_id is not NULL



--6.	Use a CROSS JOIN to generate all combinations of department and visit_type from hospital_visits.

SELECT distinct hv1.department,hv2.visit_type FROM hospital_visits hv1
CROSS JOIN hospital_visits hv2

--optimized way
SELECT 
    d.department, 
    v.visit_type
FROM 
    (SELECT DISTINCT department FROM hospital_visits) d
CROSS JOIN 
    (SELECT DISTINCT visit_type FROM hospital_visits) v;


--7.	Use CROSS APPLY to find the latest vitals (by vitals_date) for each patient.

SELECT * 
FROM patients
CROSS APPLY	(
			SELECT TOP 1 *
			FROM patient_vitals pv
			ORDER by pv.vitals_date DESC
			) pv;
