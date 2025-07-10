CREATE DATABASE clg_mgmt;
USE clg_mgmt;

-- 1. Departments Table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    hod VARCHAR(100)
);

-- 2. Professors Table
CREATE TABLE professors (
    professor_id INT PRIMARY KEY,
    prof_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- 3. Students Table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    dob DATE,
    gender VARCHAR(10),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- 4. Courses Table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- 5. Course-Professor Mapping Table
CREATE TABLE course_professor (
    course_id INT,
    professor_id INT,
    PRIMARY KEY (course_id, professor_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (professor_id) REFERENCES professors(professor_id)
);

-- 6. Enrollments Table
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    semester VARCHAR(10),
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

SHOW TABLES;

-- Total number of professors in each department
SELECT d.department_name, COUNT(p.professor_id) AS total_professors
FROM professors p
JOIN departments d ON p.department_id = d.department_id
GROUP BY d.department_name;

-- Number of courses assigned to each professor
SELECT 
    p.professor_id,
    p.prof_name,
    COUNT(cp.course_id) AS total_courses
FROM course_professor cp
JOIN professors p ON cp.professor_id = p.professor_id
GROUP BY p.professor_id, p.prof_name
ORDER BY total_courses DESC;

-- Top 10 most enrolled courses across the college
SELECT 
    c.course_id,
    c.course_name,
    COUNT(e.student_id) AS total_enrollments
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
GROUP BY c.course_id, c.course_name
ORDER BY total_enrollments DESC
LIMIT 10;

-- Number of students in each department
SELECT 
    d.department_name,
    COUNT(s.student_id) AS total_students
FROM students s
JOIN departments d ON s.department_id = d.department_id
GROUP BY d.department_name;

-- Total number of courses offered in each department
SELECT 
    d.department_name,
    COUNT(c.course_id) AS total_courses
FROM courses c
JOIN departments d ON c.department_id = d.department_id
GROUP BY d.department_name;

-- Professors with more than 2 courses assigned
SELECT 
    p.professor_id,
    p.prof_name,
    COUNT(cp.course_id) AS total_courses
FROM professors p
JOIN course_professor cp ON p.professor_id = cp.professor_id
GROUP BY p.professor_id, p.prof_name
HAVING COUNT(cp.course_id) > 2;

-- Students enrolled in more than 4 different courses
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    COUNT(e.course_id) AS enrolled_courses
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING enrolled_courses > 4
ORDER BY enrolled_courses DESC;

-- How many unique students each professor has taught
SELECT p.prof_name, COUNT(DISTINCT e.student_id) AS students_taught
FROM professors p
JOIN course_professor cp ON p.professor_id = cp.professor_id
JOIN enrollments e ON cp.course_id = e.course_id
GROUP BY p.prof_name
ORDER BY students_taught DESC;

-- Students who received 2 or more F grades
SELECT s.student_id, s.first_name, s.last_name, COUNT(*) AS f_count
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
WHERE e.grade = 'F'
GROUP BY s.student_id, s.first_name, s.last_name
HAVING f_count >= 2
ORDER BY f_count DESC;

--  Students with 3 or more A grades
SELECT s.student_id, s.first_name, s.last_name, COUNT(*) AS a_count
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
WHERE e.grade = 'A'
GROUP BY s.student_id, s.first_name, s.last_name
HAVING a_count >= 3
ORDER BY a_count DESC;

-- Courses with high ratio of A grades
SELECT 
    c.course_name,
    ROUND(SUM(CASE WHEN e.grade = 'A' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS a_grade_percent
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY a_grade_percent DESC
LIMIT 10;

-- Avg students per course per department
SELECT 
    d.department_name,
    ROUND(COUNT(e.student_id) / COUNT(DISTINCT c.course_id), 2) AS avg_students_per_course
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
JOIN departments d ON c.department_id = d.department_id
GROUP BY d.department_name
ORDER BY avg_students_per_course DESC;

--  Courses with no assigned professor
SELECT c.course_id, c.course_name
FROM courses c
LEFT JOIN course_professor cp ON c.course_id = cp.course_id
WHERE cp.professor_id IS NULL;


-- students peformance summary
CREATE VIEW student_performance AS
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    d.department_name,
    COUNT(e.course_id) AS total_courses,
    SUM(CASE WHEN e.grade = 'A' THEN 1 ELSE 0 END) AS a_grades,
    SUM(CASE WHEN e.grade = 'F' THEN 1 ELSE 0 END) AS f_grades
FROM students s
JOIN departments d ON s.department_id = d.department_id
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, student_name, d.department_name;
