-- FILTERING AND SORTING - PWSKILLS ASSIGNMENT

-- Create the database
CREATE DATABASE employee_db;

-- Use the database
USE employee_db;

-- CREATE THE EMPLOYEES TABLE
create table employees (
EmpID INT PRIMARY KEY,
EmpName VARCHAR(50),
Department VARCHAR(50),
City VARCHAR(50),
Salary INT,
HireDate DATE);

-- INSERT SAMPLE DATA
insert into employees ( EmpID, EmpName, Department,City, Salary, HireDate )
values
(101, 'Rahul Mehta', 'Sales', 'Delhi', 55000, '2020-04-12'),
(102, 'Priya Sharma', 'HR', 'Mumbai', 62000, '2019-09-25'),
(103, 'Aman Singh', 'IT', 'Bengaluru', 72000, '2021-03-10'),
(104, 'Neha Patel', 'Sales', 'Delhi', 48000, '2022-01-14'),
(105, 'Karan Joshi', 'Marketing', 'Pune', 45000, '2018-07-22'),
(106, 'Divya Nair', 'IT', 'Chennai', 81000, '2019-12-11'),
(107, 'Raj Kumar', 'HR', 'Delhi', 60000, '2020-05-28'),
(108, 'Simran Kaur', 'Finance', 'Mumbai', 58000, '2021-08-03'),
(109, 'Arjun Reddy', 'IT', 'Hyderabad', 70000, '2022-02-18'),
(110, 'Anjali Das', 'Sales', 'Kolkata', 51000, '2023-01-15');


-- QUESTION 1: Show employees working in either the 'IT' or 'HR' departments

select * from employees
where Department = 'IT' or Department = 'HR';

-- Alternative using IN clause
select * from employees
where Department in ('IT' , 'HR');


-- QUESTION 2: Retrieve employees whose department is in 'Sales', 'IT', or 'Finance'

select * from employees
where Department in ('Sales' , 'IT' , 'Finance');


-- QUESTION 3: Display employees whose salary is between ₹50,000 and ₹70,000

select * from employees
where Salary >= 50000 and Salary <= 70000;


-- QUESTION 4: List employees whose names start with the letter 'A'

select * from employees  
where EmpName like 'A%';


-- QUESTION 5: Find employees whose names contain the substring 'an'

select * from employees  
where EmpName like '%an%';


-- QUESTION 6: Show employees who are from 'Delhi' or 'Mumbai' and earn more than ₹55,000

select * from employees 
where City in ( 'Delhi' , 'Mumbai' ) 
and Salary > 55000;


-- QUESTION 7: Display all employees except those from the 'HR' department

select * from employees
where Department <> 'HR';


-- QUESTION 8: Get all employees hired between 2019 and 2022, ordered by HireDate (oldest first)

select * from employees
where HireDate between '2019-01-01' AND '2022-12-31'
order by HireDate asc;

