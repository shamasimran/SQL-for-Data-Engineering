use DataPur;
/*
	User Story: ST001
	Title: Patient Analytics & Grouping Insights
    As a healthcare data analyst, I want to create summary-level reports using aggregates and grouping 
	features so that I can present meaningful insights to my management team.

	Instructions: Write ONE SQL query for each of the following tasks.
	*/
--	1.	Write a query to get the total number of patients in the system.
	
	select count(*) as total_patients from dbo.patients;

--	2.	Find the average age of all patients.
	
	select avg(age) as Avg_age from patients;

	select SUM(age)/ count(*) as Avg_age from patients;
	
	
--	3.	Display the maximum and minimum heart rate from patient_vitals. 
	 select max(heart_rate) as max_heart_rate , min(heart_rate) as min_heart_rate from patient_vitals;
	
--	4.	Count the number of distinct diagnoses from the diagnoses table. 
	  /*Diagnosis And Count against each Diagnosis*/
	 select distinct diagnosis as Diagnosis_Name, count(*) as diagnosis_count from dbo.diagnoses group by diagnosis;
	 
	 /*Distinct Type of Diagnosis Count  */
	 select count(distinct diagnosis) as Distinct_Diagnosis from dbo.diagnoses;
--	5.	Show that NULL values are ignored in aggregate functions using SUM or AVG with a sample example. 

	 --Lets see that with an example, first we try to simulate sum part, as avg will ignore values
	 --after point(after decimal point) as our column is integer so total sum count will be different
	select avg(parent_id)* count(*) as avg_example from hierarchy
	union all
	select SUM(parent_id) as sum_example from hierarchy;

	/*This case we are deep diving the difference,
	we will check using 1. without floating point 2. with floating point to see real difference
	but as our parent id is integer
	so avg function will return answer in integer and answer will be not accurate */
	--1 without floating point difference
	select avg(parent_id) as avg_example from hierarchy
		union all
	select SUM(parent_id)/count(parent_id) as sum_example from hierarchy

	--2 with floating point numbers
	 select avg(parent_id) as avg_example from hierarchy
		union all
	select SUM(parent_id)* 1.0/count(parent_id) as sum_example from hierarchy

	--To fix that we simply first case the parent id as float, now both will have same answer
	SELECT AVG(CAST(parent_id AS FLOAT)) AS avg_result FROM hierarchy
	union all
	select SUM(parent_id) *  1.0/count(parent_id) as sum_example from hierarchy;


--	6.	Group patients by diagnosis and calculate the average age for each group. 

	 select avg(age) as Avg_age, d.diagnosis as Diagnosis_Type from patients p
	 inner join diagnoses d
	 on p.patient_id = d.patient_id
	 group by d.diagnosis;


--	7.	Group patients by diagnosis and hierarchy_id, and count how many patients are in each group.	 
	 SELECT COUNT(*) patient_count_per_Hierarchy_Diagnosis,d.diagnosis, p.hierarchy_id from patients p
	 inner join diagnoses d
	 on p.patient_id=d.patient_id
	 group by d.diagnosis,p.hierarchy_id
	 order by p.hierarchy_id;
	 --ordering data just to see more clear data

--	8.	Group patients into age buckets (<30, 30-60, >60) using a CASE expression and count the patients in each. 

	 select count(*) as Age_group_Count, e.age_group as AgeGroup from 
	( select name ,age,
	 CASE
	 WHEN age<30 THEN '<30'
	 WHEN age>=30 AND age <=60 THEN '30-60'
	 ELSE '>60'
	 END as age_group
	 from patients) as e
	 group by e.age_group;


--	9.	Use a ROLLUP to get a summary report showing patient counts per provider, including subtotals at practice and client level (join with hierarchy). 
	 select h.parent_id,  h.hierarchy_type, count(*) from patients p
	 inner join hierarchy h
	 on h.hierarchy_id = p.hierarchy_id
	 group by rollup(h.parent_id,h.hierarchy_type) 

/*	10.	Use a CUBE to get the total number of visits grouped by department and visit_type. */
	
	/*
	11.	Use GROUPING_ID() to determine which rows are actual data and which are subtotals from a ROLLUP or CUBE.
	 */
--12.	Write a query to find diagnoses that have been assigned to more than 10 patients using GROUP BY and HAVING. 
	 select diagnosis , count(*) as Total_Patients from diagnoses
	 group by diagnosis having count(*) >=10
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
	
	Instructions: Write ONE SQL query for each of the following tasks.

	1.	Use an INNER JOIN to display patient names, age, and department for patients who have at least one hospital visit.
	2.	Use a LEFT JOIN to show all patients along with their diagnosis (if any).
	3.	Use a RIGHT JOIN to show all diagnoses, including those that do not have a matching patient (use a temp table if necessary).
	4.	Use a FULL OUTER JOIN to compare hospital visits and patient vitals, showing all matches and non-matches.
	5.	Use a self join on the hierarchy table to list each provider and their practice name.
	6.	Use a CROSS JOIN to generate all combinations of department and visit_type from hospital_visits.
	7.	Use CROSS APPLY to find the latest vitals (by vitals_date) for each patient.

*/