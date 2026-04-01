CREATE Database SQL_Functions_Assignment;

USE SQL_Functions_Assignment;

-- Create the tables
CREATE TABLE Student_Performance (
	student_id INT PRIMARY KEY,
    name VARCHAR(50),
    course VARCHAR(50),
    score INT,
    attendance INT,
    mentor VARCHAR(50),
    join_date DATE,
    city VARCHAR(50)
);

-- Insert the values
INSERT INTO Student_Performance
(student_id, name, course, score, attendance, mentor, join_date, city)
VALUES
(101, 'Aarav Mehta', 'Data Science', 88, 92, 'Dr. Sharma', '2023-06-12', 'Mumbai'),
(102, 'Riya Singh', 'Data Science', 76, 85, 'Dr. Sharma', '2023-07-01', 'Delhi'),
(103, 'Kabir Khanna', 'Python', 91, 96, 'Ms. Nair', '2023-06-20', 'Mumbai'),
(104, 'Tanvi Patel', 'SQL', 84, 89, 'Mr. Iyer', '2023-05-30', 'Bengaluru'),
(105, 'Ayesha Khan', 'Python', 67, 81, 'Ms. Nair', '2023-07-10', 'Hyderabad'),
(106, 'Dev Sharma', 'SQL', 73, 78, 'Mr. Iyer', '2023-05-28', 'Pune'),
(107, 'Arjun Verma', 'Tableau', 95, 98, 'Ms. Kapoor', '2023-06-15', 'Delhi'),
(108, 'Meera Pillai', 'Tableau', 82, 87, 'Ms. Kapoor', '2023-06-18', 'Kochi'),
(109, 'Nikhil Rao', 'Data Science', 79, 82, 'Dr. Sharma', '2023-07-05', 'Chennai'),
(110, 'Priya Desai', 'SQL', 92, 94, 'Mr. Iyer', '2023-05-27', 'Bengaluru'),
(111, 'Siddharth Jain', 'Python', 85, 90, 'Ms. Nair', '2023-07-02', 'Mumbai'),
(112, 'Sneha Kulkarni', 'Tableau', 74, 83, 'Ms. Kapoor', '2023-06-10', 'Pune'),
(113, 'Rohan Gupta', 'SQL', 89, 91, 'Mr. Iyer', '2023-05-25', 'Delhi'),
(114, 'Ishita Joshi', 'Data Science', 93, 97, 'Dr. Sharma', '2023-06-25', 'Bengaluru'),
(115, 'Yuvraj Rao', 'Python', 71, 84, 'Ms. Nair', '2023-07-12', 'Hyderabad');


-- Question 1: Create a ranking of students based on score (highest first)

SELECT 
    student_id,
    name,
    course,
    score,
    RANK() OVER (ORDER BY score DESC) AS score_rank,
    DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rnk,
    ROW_NUMBER() OVER (ORDER BY score DESC) AS row_num
FROM Student_Performance
ORDER BY score DESC;


-- Question 2: Show each student's score and the previous student's score (based on score order)

SELECT 
    student_id,
    name,
    course,
    score,
    LAG(score) OVER (ORDER BY score DESC) AS previous_score,
    LAG(name) OVER (ORDER BY score DESC) AS previous_student_name
FROM Student_Performance
ORDER BY score DESC;


-- Question 3: Convert all student names to uppercase and extract the month name from join_date

SELECT 
    student_id,
    UPPER(name) AS name_uppercase,
    course,
    join_date,
    MONTHNAME(join_date) AS join_month
FROM Student_Performance
ORDER BY student_id;


-- Question 4: Show each student's name and the next student's attendance (ordered by attendance)

SELECT 
    student_id,
    name,
    attendance,
    LEAD(attendance) OVER (ORDER BY attendance) AS next_student_attendance,
    LEAD(name) OVER (ORDER BY attendance) AS next_student_name
FROM Student_Performance
ORDER BY attendance;


-- Question 5: Assign students into 4 performance groups using NTILE()

SELECT 
    student_id,
    name,
    course,
    score,
    NTILE(4) OVER (ORDER BY score DESC) AS performance_group
FROM Student_Performance
ORDER BY performance_group, score DESC;


-- Question 6: For each course, assign a row number based on attendance (highest first)

SELECT 
    student_id,
    name,
    course,
    attendance,
    ROW_NUMBER() OVER (PARTITION BY course ORDER BY attendance DESC) AS attendance_rank
FROM Student_Performance
ORDER BY course, attendance DESC;


-- Question 7: Calculate the number of days each student has been enrolled (from join_date to today) - Assume current date = '2025-01-01'

SELECT 
    student_id,
    name,
    join_date,
    DATEDIFF('2025-01-01', join_date) AS days_enrolled
FROM Student_Performance
ORDER BY days_enrolled DESC;


-- Question 8: Format join_date as "Month Year" (e.g., "June 2023")

SELECT 
    student_id,
    name,
    join_date,
    DATE_FORMAT(join_date, '%M %Y') AS formatted_date
FROM Student_Performance
ORDER BY student_id;


-- Question 9: Replace the city 'Mumbai' with 'MUM' for display purposes

SELECT 
    student_id,
    name,
    city AS original_city,
    REPLACE(city, 'Mumbai', 'MUM') AS display_city
FROM Student_Performance
ORDER BY student_id;


-- Question 10: For each course, find the highest score using FIRST_VALUE()

SELECT 
    student_id,
    name,
    course,
    score,
    FIRST_VALUE(score) OVER (PARTITION BY course ORDER BY score DESC) AS highest_score_in_course,
    FIRST_VALUE(name) OVER (PARTITION BY course ORDER BY score DESC) AS top_student_in_course
FROM Student_Performance
ORDER BY course, score DESC;
