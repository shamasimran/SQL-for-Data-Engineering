-- Uninstall Script for Patient Management Demo Schema
-- This script will remove the tables and all data created during the pilot

-- Drop dependent tables first to avoid FK constraint errors
IF OBJECT_ID('hospital_visits', 'U') IS NOT NULL
    DROP TABLE hospital_visits;

IF OBJECT_ID('patient_vitals', 'U') IS NOT NULL
    DROP TABLE patient_vitals;

IF OBJECT_ID('diagnoses', 'U') IS NOT NULL
    DROP TABLE diagnoses;

IF OBJECT_ID('raw_claims_data', 'U') IS NOT NULL
    DROP TABLE raw_claims_data;

-- Drop the base table last (patients is referenced by others)
IF OBJECT_ID('patients', 'U') IS NOT NULL
    DROP TABLE patients;
