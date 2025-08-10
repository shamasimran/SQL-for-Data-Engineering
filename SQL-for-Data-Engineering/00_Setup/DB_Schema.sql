-- ==============================================
-- DataPur | Azure Data Engineering Training Demo
-- Deployment Script with Hierarchy Integration
-- ==============================================

-- ========= Drop Existing Tables if Exist =========
IF OBJECT_ID('hospital_visits', 'U') IS NOT NULL DROP TABLE hospital_visits;
IF OBJECT_ID('patient_vitals', 'U') IS NOT NULL DROP TABLE patient_vitals;
IF OBJECT_ID('diagnoses', 'U') IS NOT NULL DROP TABLE diagnoses;
IF OBJECT_ID('raw_claims_data', 'U') IS NOT NULL DROP TABLE raw_claims_data;
IF OBJECT_ID('patients', 'U') IS NOT NULL DROP TABLE patients;
IF OBJECT_ID('hierarchy', 'U') IS NOT NULL DROP TABLE hierarchy;

-- ========= Create Hierarchy Table =========
CREATE TABLE hierarchy (
    hierarchy_id INT IDENTITY(1,1) PRIMARY KEY,
    parent_id INT NULL,
    hierarchy_name VARCHAR(100),
    hierarchy_type VARCHAR(20) CHECK (hierarchy_type IN ('Client', 'Practice', 'Provider')),
    FOREIGN KEY (parent_id) REFERENCES hierarchy(hierarchy_id)
);

-- ========= Sample Hierarchy Data =========
-- Insert Clients
INSERT INTO hierarchy (parent_id, hierarchy_name, hierarchy_type) VALUES
(NULL, 'Client A', 'Client'),
(NULL, 'Client B', 'Client');

DECLARE @ClientA INT = (SELECT hierarchy_id FROM hierarchy WHERE hierarchy_name = 'Client A');
DECLARE @ClientB INT = (SELECT hierarchy_id FROM hierarchy WHERE hierarchy_name = 'Client B');

-- Insert Practices
INSERT INTO hierarchy (parent_id, hierarchy_name, hierarchy_type) VALUES
(@ClientA, 'Practice A1', 'Practice'),
(@ClientA, 'Practice A2', 'Practice'),
(@ClientB, 'Practice B1', 'Practice'),
(@ClientB, 'Practice B2', 'Practice');

DECLARE @PracticeA1 INT = (SELECT hierarchy_id FROM hierarchy WHERE hierarchy_name = 'Practice A1');
DECLARE @PracticeA2 INT = (SELECT hierarchy_id FROM hierarchy WHERE hierarchy_name = 'Practice A2');
DECLARE @PracticeB1 INT = (SELECT hierarchy_id FROM hierarchy WHERE hierarchy_name = 'Practice B1');
DECLARE @PracticeB2 INT = (SELECT hierarchy_id FROM hierarchy WHERE hierarchy_name = 'Practice B2');

-- Insert Providers (3 per practice)
INSERT INTO hierarchy (parent_id, hierarchy_name, hierarchy_type)
VALUES
(@PracticeA1, 'Provider A1-1', 'Provider'),
(@PracticeA1, 'Provider A1-2', 'Provider'),
(@PracticeA1, 'Provider A1-3', 'Provider'),
(@PracticeA2, 'Provider A2-1', 'Provider'),
(@PracticeA2, 'Provider A2-2', 'Provider'),
(@PracticeA2, 'Provider A2-3', 'Provider'),
(@PracticeB1, 'Provider B1-1', 'Provider'),
(@PracticeB1, 'Provider B1-2', 'Provider'),
(@PracticeB1, 'Provider B1-3', 'Provider'),
(@PracticeB2, 'Provider B2-1', 'Provider'),
(@PracticeB2, 'Provider B2-2', 'Provider'),
(@PracticeB2, 'Provider B2-3', 'Provider');

-- ========= Create Patients Table =========
CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    diagnosis VARCHAR(255),
    hierarchy_id INT,
    FOREIGN KEY (hierarchy_id) REFERENCES hierarchy(hierarchy_id)
);

-- ========= Insert Patients =========
DECLARE @i INT = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO patients (patient_id, name, age, diagnosis, hierarchy_id)
    VALUES (
        @i,
        'Patient ' + CAST(@i AS VARCHAR(10)),
        FLOOR(RAND(CHECKSUM(NEWID())) * (90 - 18 + 1) + 18),
        CASE WHEN RAND(CHECKSUM(NEWID())) < 0.5 THEN 'Diabetes' ELSE 'Hypertension' END,
        (SELECT TOP 1 hierarchy_id FROM hierarchy WHERE hierarchy_type = 'Provider' ORDER BY NEWID())
    );
    SET @i += 1;
END;

-- ========= Create Diagnoses Table =========
CREATE TABLE diagnoses (
    diagnosis_id INT PRIMARY KEY,
    patient_id INT,
    diagnosis VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- ========= Insert Diagnoses =========
DECLARE @j INT = 1;
WHILE @j <= 1000
BEGIN
    INSERT INTO diagnoses (diagnosis_id, patient_id, diagnosis)
    VALUES (
        @j,
        (SELECT TOP 1 patient_id FROM patients ORDER BY NEWID()),
        CASE WHEN RAND(CHECKSUM(NEWID())) < 0.5 THEN 'Diabetes Type 2' ELSE 'Hypertension Stage 1' END
    );
    SET @j += 1;
END;

-- ========= Create Patient Vitals =========
CREATE TABLE patient_vitals (
    vitals_id INT PRIMARY KEY,
    patient_id INT,
    vitals_date DATE,
    heart_rate INT,
    blood_pressure VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- ========= Insert Patient Vitals =========
DECLARE @k INT = 1;
WHILE @k <= 5000
BEGIN
    INSERT INTO patient_vitals (vitals_id, patient_id, vitals_date, heart_rate, blood_pressure)
    VALUES (
        @k,
        (SELECT TOP 1 patient_id FROM patients ORDER BY NEWID()),
        DATEADD(DAY, -FLOOR(RAND(CHECKSUM(NEWID())) * 365), GETDATE()),
        FLOOR(RAND(CHECKSUM(NEWID())) * (100 - 60 + 1) + 60),
        CAST(FLOOR(RAND(CHECKSUM(NEWID())) * (180 - 90 + 1) + 90) AS VARCHAR) + '/' +
        CAST(FLOOR(RAND(CHECKSUM(NEWID())) * (120 - 60 + 1) + 60) AS VARCHAR)
    );
    SET @k += 1;
END;

-- ========= Create Hospital Visits =========
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

-- ========= Insert Hospital Visits =========
DECLARE @l INT = 1;
WHILE @l <= 5000
BEGIN
    DECLARE @admitDate DATE = DATEADD(DAY, -FLOOR(RAND(CHECKSUM(NEWID())) * 365), GETDATE());
    INSERT INTO hospital_visits (visit_id, patient_id, department, admit_date, discharge_date, visit_type, visit_date)
    VALUES (
        @l,
        (SELECT TOP 1 patient_id FROM patients ORDER BY NEWID()),
        CASE WHEN RAND(CHECKSUM(NEWID())) < 0.5 THEN 'Cardiology' ELSE 'Neurology' END,
        @admitDate,
        DATEADD(DAY, FLOOR(RAND(CHECKSUM(NEWID())) * 10 + 1), @admitDate),
        CASE WHEN RAND(CHECKSUM(NEWID())) < 0.5 THEN 'emergency' ELSE 'routine' END,
        @admitDate
    );
    SET @l += 1;
END;

-- ========= Create Raw Claims Data =========
CREATE TABLE raw_claims_data (
    claim_id INT PRIMARY KEY,
    claim_status VARCHAR(50),
    claim_amount DECIMAL(10,2),
    submitted_date DATE
);

-- ========= Insert Raw Claims =========
DECLARE @m INT = 1;
WHILE @m <= 5000
BEGIN
    INSERT INTO raw_claims_data (claim_id, claim_status, claim_amount, submitted_date)
    VALUES (
        @m,
        CASE WHEN RAND(CHECKSUM(NEWID())) < 0.5 THEN 'Approved' ELSE 'Denied' END,
        ROUND(RAND(CHECKSUM(NEWID())) * (10000 - 1000) + 1000, 2),
        DATEADD(DAY, -FLOOR(RAND(CHECKSUM(NEWID())) * 365), GETDATE())
    );
    SET @m += 1;
END;

-- ========= End of Script =========
PRINT '✅ Deployment completed successfully.';