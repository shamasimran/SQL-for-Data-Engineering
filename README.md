# SQL for Data Engineering 🚀

This repository is part of the **8-Week Data Engineering Journey** focused on SQL skills using healthcare datasets. Each week's folder contains challenges, explanations, and SQL scripts for solving real-world data engineering problems.

---

## 🧠 Learning Objectives

- Master SQL for Data Engineering
- Practice with realistic healthcare datasets
- Understand complex querying, transformations, and optimization
- Learn how to clean and normalize raw healthcare data
- Apply SQL to power analytics and ETL workflows

---

## 🗂️ Project Structure

```
SQL-for-Data-Engineering/
├── 01_sql_basics/
│   ├── README.md
│   └── week1_challenges.sql
├── 02_joins_and_aggregations/
│   ├── README.md
│   └── week2_challenges.sql
├── 03_window_functions/
│   ├── README.md
│   └── week3_challenges.sql
├── 04_ctes_and_subqueries/
│   ├── README.md
│   └── week4_challenges.sql
├── 05_data_cleaning_and_normalization/
│   ├── README.md
│   └── week5_challenges.sql
├── 06_data_transformation/
│   ├── README.md
│   └── week6_challenges.sql
├── 07_performance_tuning/
│   ├── README.md
│   └── week7_challenges.sql
├── 08_project_case_study/
│   ├── README.md
│   └── week8_final_project.sql
└── mock_data/
    ├── healthcare_schema.sql
    └── healthcare_data_inserts.sql
```

---

## 🏥 Healthcare Dataset

Tables used across all challenges:

- `patients`: Basic patient info
- `diagnoses`: Linked diagnoses for patients
- `patient_vitals`: Heart rate, blood pressure, etc.
- `hospital_visits`: Hospital admission and discharge records
- `raw_claims_data`: Messy claims data requiring cleaning and transformation

> Sample mock data is located in the `mock_data/` folder. Use this to populate your SQL Server instance before running the weekly challenge scripts.

---

## 🚀 How to Use

1. Clone the repo  
   ```bash
   git clone https://github.com/shamasimran/SQL-for-Data-Engineering.git
   cd SQL-for-Data-Engineering
   ```

2. Run the schema and mock data insert scripts from `mock_data/` in your SQL Server environment

3. Go into each week's folder, read the README, and run the SQL script to practice challenges

4. Tweak the queries, optimize them, and try advanced versions

---

## 📅 Weekly Breakdown

| Week | Topic                               | Key Focus                          |
|------|-------------------------------------|------------------------------------|
| 1    | SQL Basics                          | SELECT, WHERE, GROUP BY            |
| 2    | Joins & Aggregations                | INNER, LEFT, GROUPED queries       |
| 3    | Window Functions                    | Ranking, rolling averages          |
| 4    | CTEs & Subqueries                   | Modular SQL and nested logic       |
| 5    | Data Cleaning & Normalization       | Handling messy data, formatting    |
| 6    | Data Transformation                 | Deriving metrics from raw data     |
| 7    | Performance Tuning                  | Indexing, query optimization       |
| 8    | Final Project                       | Capstone case study                |

---

## 🛠️ Prerequisites

- SQL Server (or any SQL-compatible DB)
- Basic SQL knowledge
- Python (optional for automating scripts)

---

## 📬 Feedback & Contributions

Feel free to fork the repo, suggest improvements, or raise issues if something doesn't work.

---

## 📝 License

This repository is under the [MIT License](LICENSE).

---

Happy Querying! 🧠💉
