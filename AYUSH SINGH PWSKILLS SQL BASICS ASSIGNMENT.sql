-- SQL BASICS - PWSKILLS ASSIGNMENT

-- Q1. Create a New Database and Table for Employees
-- Create the database
create database company_db;

-- Use the database
use company_db;

-- Create the employees table
create table employees (
employee_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
department VARCHAR(50),
salary INT,
hire_date DATE);


-- Q2. Insert Data into Employees Table
insert into employees (employee_id, first_name, last_name, department, salary, hire_date)
values
(101, 'Amit', 'Sharma', 'HR', 50000, '2020-01-15'),
(102, 'Riya', 'Kapoor', 'Sales', 75000, '2019-03-22'),
(103, 'Raj', 'Mehta', 'IT', 90000, '2018-07-11'),
(104, 'Neha', 'Verma', 'IT', 85000, '2021-09-01'),
(105, 'Arjun', 'Singh', 'Finance', 60000, '2022-02-10');


-- Q3. Display All Employee Records Sorted by Salary (Lowest to Highest)
select * from employees
order by salary asc;


-- Q4. Show Employees Sorted by Department (A–Z) and Salary (High → Low)
select * from employees
order by department asc , salary desc;


-- Q5. List All Employees in the IT Department, Ordered by Hire Date (Newest First)
select * from employees
where department = 'IT'
order by hire_date desc;


-- Q6. Create and Populate a Sales Table
-- Create the sales table
create table sales (
sale_id INT PRIMARY KEY,
customer_name VARCHAR(50),
amount INT,
sale_date DATE);

-- Insert data into sales table
insert into sales ( sale_id, customer_name, amount, sale_date)
values
(1, 'Aditi', 1500, '2024-08-01'),
(2, 'Rohan', 2200, '2024-08-03'),
(3, 'Aditi', 3500, '2024-09-05'),
(4, 'Meena', 2700, '2024-09-15'),
(5, 'Rohan', 4500, '2024-09-25');


-- Q7. Display All Sales Records Sorted by Amount (Highest → Lowest)
select * from sales
order by amount desc;


-- Q8. Show All Sales Made by Customer "Aditi"
select * from sales
where customer_name = 'Aditi';




-- THEORY QUESTIONS

-- Q9. What is the Difference Between a Primary Key and a Foreign Key?

/*
PRIMARY KEY:
- Uniquely identifies each record in a table
- Cannot contain NULL values
- Each table can have only ONE primary key
- Automatically creates a unique index
- Example: employee_id in employees table

FOREIGN KEY:
- Creates a link between two tables
- References the primary key of another table
- Can contain NULL values (unless NOT NULL constraint is specified)
- A table can have multiple foreign keys
- Enforces referential integrity
- Example: If we had a 'projects' table with employee_id as foreign key,
  it would reference employees.employee_id

Key Difference: 
Primary Key = Unique identifier within a table
Foreign Key = Reference to a Primary Key in another table (creates relationships)
*/


-- Q10. What Are Constraints in SQL and Why Are They Used?

/*
CONSTRAINTS in SQL are rules applied to columns to enforce data integrity and accuracy.

COMMON CONSTRAINTS:

1. PRIMARY KEY: Uniquely identifies each record, no duplicates, no NULLs

2. FOREIGN KEY: Ensures referential integrity between tables

3. NOT NULL: Column cannot have NULL values

4. UNIQUE: All values in column must be different

5. CHECK: Ensures values meet a specific condition
   Example: CHECK (salary > 0)

6. DEFAULT: Sets a default value if none is provided
   Example: DEFAULT 'Active'

7. AUTO_INCREMENT: Automatically generates unique numbers

WHY USE CONSTRAINTS?
- Data Integrity: Prevents invalid data from entering the database
- Data Accuracy: Ensures data follows business rules
- Consistency: Maintains relationships between tables
- Error Prevention: Catches mistakes at database level
- Documentation: Makes database structure self-documenting

Example with constraints:
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 18),
    status VARCHAR(20) DEFAULT 'Active'
);
*/










