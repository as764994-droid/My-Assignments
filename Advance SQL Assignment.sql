CREATE DATABASE ADVANCE_SQL_ASSIGNMENT;
USE ADVANCE_SQL_ASSIGNMENT;


/*
Q1. What is a Common Table Expression (CTE), and how does it improve SQL query readability?
Answer 1:
A temporary named result set created with the WITH keyword is known as a Common Table Expression (CTE), and it is only valid within the parameters of the query that 
comes after it.
How it makes reading easier:
* Rather than using deeply nested subqueries, it divides complex queries into named, logical steps.
* Avoids repetition by being able to be referred to more than once in a single query.
* Clearly states the purpose—each CTE block has a name that describes it.* Recursive queries are supported (e.g., hierarchical data like org charts).
*/

/*
Q2. Why are some views updatable while others are read-only? Explain with an example.
Answer 2:
When a view maps directly and unambiguously to a single base table, it is said to be updatable because the database engine can translate the view's UPDATE, 
INSERT, and DELETE operations back to the underlying table.
When a view has any of the following, it becomes read-only:
* JOIN across multiple tables
* Aggregate functions (SUM, COUNT, AVG, etc.)
* GROUP BY, HAVING, DISTINCT
* Subqueries in the SELECT list
* UNION or set operations
*/

/*
Q3. What advantages do stored procedures offer compared to writing raw SQL queries repeatedly?
Answer 3:
Stored procedures are precompiled SQL routines stored in the database. Key advantages:
1. Reusability — Write once, call from anywhere (application, scripts, other procedures)
2. Performance — Precompiled and cached execution plans reduce overhead
3. Security — Grant EXECUTE permission without exposing underlying table structure
4. Reduced network traffic — Send one CALL proc_name() instead of multiple SQL statements
5. Maintainability — Business logic lives in one place; change it once, reflected everywhere
6. Parameterization — Accepts inputs, making it flexible and preventing SQL injection
*/

/*
Q4. What is the purpose of triggers in a database? Mention one use case where a trigger is essential.
Answer 4:
A trigger is a database object that, when a particular event (INSERT, UPDATE, DELETE) occurs on a table, automatically runs a block of SQL code.
Goal: Without the need for application-level code, automate the implementation of business rules, keep audit logs, synchronize tables, or cascade operations.
Audit logging is a crucial use case.
You need an automated, impenetrable record of who made changes and when when a bank employee adjusts an account balance. Application code is insufficient on its 
own (it can be circumvented). Every UPDATE sets off a trigger on the Accounts table that automatically writes to an AuditLog table, which is crucial for fraud detection 
and compliance.
*/

/*
Q5. Explain the need for data modelling and normalization when designing a database.
Answer 5:
Data Modelling is the process of defining the structure, relationships, and constraints of data before building a database. It ensures the database accurately represents real-world entities and their interactions.
Normalization is the process of organizing tables to reduce redundancy and dependency by following normal forms (1NF, 2NF, 3NF, BCNF).
Why they are needed:
* Eliminate redundancy — Same data stored in multiple places leads to inconsistency (update anomalies)
* Prevent anomalies — Insert, update, and delete anomalies corrupt data integrity
* Improve query performance — Proper indexing and structure enable efficient queries
* Scalability — A well-modelled schema grows cleanly without breaking changes
* Data integrity — Foreign keys and constraints enforced at the design stage prevent bad data

Without normalization, a table storing customer orders might repeat the customer's address in every row — one address change requires updating hundreds of records, 
and a missed update creates inconsistent data.
*/

CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
Category VARCHAR(50),
Price DECIMAL(10,2)
);

INSERT INTO Products VALUES
(1, 'Keyboard', 'Electronics', 1200),
(2, 'Mouse', 'Electronics', 800),
(3, 'Chair', 'Furniture', 2500),
(4, 'Desk', 'Furniture', 5500);

CREATE TABLE Sales (
SaleID INT PRIMARY KEY,
ProductID INT,
Quantity INT,
SaleDate DATE,
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Sales VALUES
(1, 1, 4, '2024-01-05'),
(2, 2, 10, '2024-01-06'),
(3, 3, 2, '2024-01-10'),
(4, 4, 1, '2024-01-11');

/*
Q6. Write a CTE to calculate the total revenue for each product
 (Revenues = Price × Quantity), and return only products where  revenue > 3000.
*/

with ProductRevenue  as (
	select 
		p.ProductID,
		p.ProductName,
        p.Price,
        s.Quantity,
        (p.Price * s.Quantity) as Revenue
	from products p
    join sales s
    on p.ProductID = s.ProductID
)
select 
	ProductID,
	ProductName,
	Price,
    Quantity,
    Revenue
from ProductRevenue
where Revenue > 3000;

/*
Q7. Create a view named that shows:
Category, TotalProducts, AveragePrice.
*/

create view vw_CategorySummary as
select 
    Category,
    count(ProductID) as TotalProducts,
    avg(Price) as AveragePrice
from products
group by category;

select * from vw_CategorySummary;

/*
Q8. Create an updatable view containing ProductID, ProductName, and Price.
 Then update the price of ProductID = 1 using the view
*/

-- Step 1: Create the updatable view
create view vw_ProductPrices as
select ProductID, ProductName, Price
from Products;

-- Step 2: Update price of ProductID = 1 via the view
update vw_ProductPrices
set Price = 1350.00
where ProductID = 1;

-- Step 3: Verify the change
select * 
from vw_ProductPrices 
where ProductID = 1;

/*
Q9. Create a stored procedure that accepts a category name and returns all products belonging to that category.
*/

DELIMITER $$

create procedure GetProductsByCategory(in p_Category varchar(50))
begin
    select 
        ProductID,
        ProductName,
        Category,
        Price
	from Products
    where Category = p_Category;
end$$

DELIMITER ;

-- Usage
call GetProductsByCategory('Electronics');
call GetProductsByCategory('Furniture');

/*
Q10. Create an AFTER DELETE trigger on the table that archives deleted product rows into a new
table ProductArchive . The archive should store ProductID, ProductName, Category, Price, and DeletedAttimestamp.
*/

-- Step 1: Create the archive table
CREATE TABLE ProductArchive (
    ProductID     INT,
    ProductName   VARCHAR(100),
    Category      VARCHAR(50),
    Price         DECIMAL(10,2),
    DeletedAt     DATETIME
);

-- Step 2: Create the AFTER DELETE trigger
DELIMITER $$

CREATE TRIGGER trg_ArchiveDeletedProduct
AFTER DELETE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO ProductArchive (ProductID, ProductName, Category, Price, DeletedAt)
    VALUES (OLD.ProductID, OLD.ProductName, OLD.Category, OLD.Price, NOW());
END$$

DELIMITER ;

-- Step 3: Test it
DELETE FROM Products WHERE ProductID = 4;

-- Step 4: Verify archive
SELECT * FROM ProductArchive;







