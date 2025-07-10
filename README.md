# College Management System (SQL + Tableau)

This project simulates a full college/university database system using SQL and builds advanced Tableau dashboards for real-world insights. The data used is fully synthetic, created using Python and the Faker library, and includes over 3300+ rows across 6 relational tables.

## Project Overview

The goal was to design and analyze a college environment where students enroll in courses taught by professors across various departments. Used MySQL for schema creation and querying, and Tableau for visualization.

## Tech Stack

- SQL (MySQL Workbench)
- Python (Faker, Pandas) for data generation
- Tableau Public / Tableau Desktop for dashboarding

## Dataset

Used Python scripts to generate the following datasets:

- `departments.csv` – 7 departments
- `professors.csv` – 77 professors
- `students.csv` – 840 students
- `courses.csv` – 140 courses (20 per department)
- `course_professor.csv` – maps courses to professors
- `enrollments.csv` – 3372 course enrollments with grades

## SQL Features Used

- Multiple table joins (INNER, LEFT)
- Subqueries and aggregations
- Filtering, grouping, and sorting
- KPIs and performance analysis using raw SQL

## Sample SQL Insights

- Students with 3 or more A grades
- Students who received 2 or more F grades
- Average GPA per department
- Courses with the highest failure rate
- Number of unique students taught by each professor

These queries were later used to design the Tableau dashboards.

## Tableau Dashboards

The final dashboards include:

- KPI Summary (students, professors, avg courses/prof)
- Grade distribution across departments
- Professor teaching load
- Course difficulty based on grades
- Enrollments by department and course
- Filterable student performance views

Dashboards are interactive, include filters, tooltips, and were styled for clean readability.


