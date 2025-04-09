# Database Schema and Sample Data Generator

This repository contains a SQL script that defines a simple healthcare database schema and populates it with sample data. The purpose is to simulate a dataset for testing or development purposes.

## 📁 Schema Overview

The script creates the following tables:

### 🧑‍⚕️ `patients`
Stores basic patient information.

- `patient_id` (INT, Primary Key)
- `name` (VARCHAR)
- `age` (INT)
- `diagnosis` (VARCHAR)

### 📋 `diagnoses`
Tracks detailed diagnosis records for patients.

- `diagnosis_id` (INT, Primary Key)
- `patient_id` (INT, Foreign Key to `patients`)
- `diagnosis` (VARCHAR)

### 💓 `patient_vitals`
Records patients’ vital signs over time.

- `vitals_id` (INT, Primary Key)
- `patient_id` (INT, Foreign Key to `patients`)
- `vitals_date` (DATE)
- `heart_rate` (INT)
- `blood_pressure` (VARCHAR)

## 🔄 Sample Data Generation

The script includes T-SQL loops to insert randomized sample data into each table:

- 1000 patients
- 1000 diagnoses
- 5000 vitals records

Random values include:
- Patient age (between 18 and 90)
- Diagnoses (`Diabetes`, `Hypertension`)
- Vitals data (randomized within typical human ranges)

## ▶️ How to Use

1. Open Microsoft SQL Server Management Studio (SSMS).
2. Connect to your SQL Server instance.
3. Open the `DB_Schema.sql` file.
4. Execute the script to create the tables and populate them with sample data.

## 📌 Notes

- Ensure appropriate permissions to create tables and insert data.
- Ideal for learning, development, or testing small-scale health data simulations.

## ✍️ Author

Script designed by Shamas Imran.
