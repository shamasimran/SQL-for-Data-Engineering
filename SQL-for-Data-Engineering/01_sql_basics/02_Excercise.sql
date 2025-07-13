/*
*** Task 1: Segment Senior Patients at Risk

    The program director wants to reach out to senior citizens (age > 60) whose names start with "P" to 
	prioritize them for annual checkups. You need to create a list showing their:
    ID, Name, Age, Diagnosis
    Age group label ("Senior" or "Non-Senior")
    Risk level based on diagnosis:
        "High Risk" for Diabetes
        "Moderate Risk" for Hypertension
        "Low Risk" otherwise
 >> Query Requirements:
		Use column aliases for readability
		Use IIF for age group
		Use CASE for risk level
		Filter only patients:
			Whose name starts with "P"
			Are aged between 25–75
			Whose diagnosis is not null
		Sort by age (descending), then name (ascending)
*/

SELECT 
    patient_id AS ID,
    name AS PatientName,
    age,
    diagnosis,
    IIF(age > 60, 'Senior', 'Non-Senior') AS AgeGroup,
    CASE 
        WHEN diagnosis = 'Diabetes' THEN 'High Risk'
        WHEN diagnosis = 'Hypertension' THEN 'Moderate Risk'
        ELSE 'Low Risk'
    END AS RiskLevel
FROM patients
WHERE 
    name LIKE 'P%' 
    AND diagnosis IS NOT NULL 
    AND age BETWEEN 25 AND 75
ORDER BY age DESC, name ASC;


/*
*** Task 2: Analyze Younger Non-Hypertensive Population

    A clinical researcher is investigating trends among younger patients who are not diagnosed with 
	Hypertension. They are especially interested in those whose names have "a" as the second 
	character (e.g., "Sara", "Jamal", etc.). Your goal is to create a view that shows:

    Name, Age, Diagnosis
    Age Bracket:
        "Young" for <30
        "Middle Aged" for 30–59
        "Senior" for 60+
    Flag indicating if they are diabetic (True or False)
 >> Query Requirements:
		Use CASE for age bracket
		Use IIF to flag Diabetes
		Filter:
			Diagnosis is not 'Hypertension'
			Name pattern matches second character as 'a'
			Diagnosis must not be null
*/

SELECT 
    name,
    age,
    diagnosis,
    CASE 
        WHEN age < 30 THEN 'Young'
        WHEN age BETWEEN 30 AND 59 THEN 'Middle Aged'
        ELSE 'Senior'
    END AS AgeBracket,
    IIF(diagnosis = 'Diabetes', 'True', 'False') AS IsDiabetic
FROM patients
WHERE 
    NOT diagnosis = 'Hypertension'
    AND name LIKE '________1%' 
    AND diagnosis IS NOT NULL;