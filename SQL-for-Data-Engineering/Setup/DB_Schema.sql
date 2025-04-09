-- Table: patients
CREATE TABLE patients (
  patient_id INT PRIMARY KEY,
  name VARCHAR(100),
  age INT,
  diagnosis VARCHAR(255)
);

-- Generate sample data
DECLARE @i INT = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO patients (patient_id, name, age, diagnosis)
    VALUES (@i, 'Patient ' + CAST(@i AS VARCHAR(10)), 
            FLOOR(RAND(CHECKSUM(NEWID())) * (90 - 18 + 1) + 18), -- Random age between 18 and 90
            CASE WHEN RAND(CHECKSUM(NEWID())) < 0.5 THEN 'Diabetes' ELSE 'Hypertension' END);
    SET @i = @i + 1;
END;

-- Table: diagnoses
CREATE TABLE diagnoses (
  diagnosis_id INT PRIMARY KEY,
  patient_id INT,
  diagnosis VARCHAR(255),
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- Generate sample data
DECLARE @j INT = 1;
WHILE @j <= 1000
BEGIN
    INSERT INTO diagnoses (diagnosis_id, patient_id, diagnosis)
    VALUES (@j, (SELECT patient_id FROM patients ORDER BY NEWID() OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY), -- Random patient_id
            CASE WHEN RAND(CHECKSUM(NEWID())) < 0.5 THEN 'Diabetes Type 2' ELSE 'Hypertension Stage 1' END);
    SET @j = @j + 1;
END;

-- Table: patient_vitals
CREATE TABLE patient_vitals (
  vitals_id INT PRIMARY KEY,
  patient_id INT,
  vitals_date DATE,
  heart_rate INT,
  blood_pressure VARCHAR(20),
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- Generate sample data
DECLARE @k INT = 1;
WHILE @k <= 5000
BEGIN
    INSERT INTO patient_vitals (vitals_id, patient_id, vitals_date, heart_rate, blood_pressure)
    VALUES (@k, 
            (SELECT patient_id FROM patients ORDER BY NEWID() OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY), -- Random patient_id
            DATEADD(DAY, -FLOOR(RAND(CHECKSUM(NEWID())) * 365), GETDATE()), -- Random date within the last year
            FLOOR(RAND(CHECKSUM(NEWID())) * (100 - 60 + 1) + 60), -- Random heart rate between 60 and 100
            FLOOR(RAND(CHECKSUM(NEWID())) * (180 - 90 + 1) + 90) + '/' + 
            FLOOR(RAND(CHECKSUM(NEWID())) * (120 - 60 + 1) + 60)); -- Random blood pressure
    SET @k = @k + 1;
END;

-- Table: hospital_visits
CREATE TABLE hospital_visits (
  visit_id INT PRIMARY KEY,
  patient_id INT,
  department VARCHAR(100),
  admit_date DATE,
  discharge_date DATE,
  visit_type VARCHAR(50),
  visit_date DATE,
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- Generate sample data
DECLARE @l INT = 1;
WHILE @l <= 5000
BEGIN
    INSERT INTO hospital_visits (visit_id, patient_id, department, admit_date, discharge_date, visit_type, visit_date)
    VALUES (@l,
            (SELECT patient_id FROM patients ORDER BY NEWID() OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY), -- Random patient_id
            CASE WHEN RAND(CHECKSUM(NEWID())) < 0.5 THEN 'Cardiology' ELSE 'Neurology' END,
            DATEADD(DAY, -FLOOR(RAND(CHECKSUM(NEWID())) * 365), GETDATE()), -- Random admit date within the last year
            DATEADD(DAY, -FLOOR(RAND(CHECKSUM(NEWID())) * 30), GETDATE()), -- Discharge date within 30 days of admit date
            CASE WHEN RAND(CHECKSUM(NEWID())) < 0.5 THEN 'emergency' ELSE 'routine' END,
            DATEADD(DAY, -FLOOR(RAND(CHECKSUM(NEWID())) * 365), GETDATE()) -- Random visit date within the last year
    );
    SET @l = @l + 1;
END;

-- Table: raw_claims_data
CREATE TABLE raw_claims_data (
  claim_id INT PRIMARY KEY,
  claim_status VARCHAR(50),
  claim_amount VARCHAR(20),
  submitted_date VARCHAR(20)
);

-- Generate sample data
DECLARE @m INT = 1;
WHILE @m <= 5000
BEGIN
    INSERT INTO raw_claims_data (claim_id, claim_status, claim_amount, submitted_date)
    VALUES (@m,
            CASE WHEN RAND(CHECKSUM(NEWID())) < 0.5 THEN 'Approved' ELSE 'Denied' END,
            CAST(ROUND(RAND(CHECKSUM(NEWID())) * (10000 - 1000) + 1000, 2) AS VARCHAR(20)),
            CONVERT(VARCHAR(10), DATEADD(DAY, -FLOOR(RAND(CHECKSUM(NEWID())) * 365), GETDATE()), 120) -- Random submission date
    );
    SET @m = @m + 1;
END;
