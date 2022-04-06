SET SQL_SAFE_UPDATES = 0;

-- Create a file named temporary_tables.sql to do your work for this exercise.

-- 1. Using the example from the lesson, create a temporary table called employees_with_departments that contains 
-- 		first_name, last_name, and dept_name for employees currently with that department. 
-- 		Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", 
-- 		it means that the query was attempting to write a new table to a database that you can only read.

USE employees;
CREATE TEMPORARY TABLE jemison_1742.employees_with_departments as
SELECT first_name, last_name, dept_name
from employees
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
limit 100;


select *
from jemison_1742.employees_with_departments;

show tables;

describe employees;



-- a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths 
-- 		of the first name and last name columns

ALTER TABLE jemison_1742.employees_with_departments 
ADD full_name VARCHAR (31);

select *
from jemison_1742.employees_with_departments;

-- b. Update the table so that full name column contains the correct data

UPDATE jemison_1742.employees_with_departments
SET full_name= CONCAT(first_name," ",last_name);

select *
from jemison_1742.employees_with_departments;

-- c. Remove the first_name and last_name columns from the table.

ALTER TABLE jemison_1742.employees_with_departments 
DROP COLUMN first_name, 
DROP COLUMN last_name;

select *
from jemison_1742.employees_with_departments;

select dept_name, full_name
from jemison_1742.employees_with_departments;

-- d. What is another way you could have ended up with this same table?

select dept_name, full_name
from jemison_1742.employees_with_departments;

describe employees_with_departments;

-- 2. Create a temporary table based on the payment table from the sakila database.
-- 		Write the SQL necessary to transform the amount column such that it is stored as an integer 
-- 		representing the number of cents of the payment. For example, 1.99 should become 199.

USE sakila;
show tables;

CREATE TEMPORARY TABLE jemison_1742.payment_adj AS
SELECT payment_id, customer_id,staff_id,rental_id,amount,payment_date,last_update
FROM payment;

select * from jemison_1742.payment_adj;

ALTER TABLE jemison_1742.payment_adj
ADD amount_int INT(4);

UPDATE jemison_1742.payment_adj
SET amount_int=amount*100;

select * from jemison_1742.payment_adj;

ALTER TABLE jemison_1742.payment_adj
DROP COLUMN amount;
select * from jemison_1742.payment_adj;

-- 3. Find out how the current average pay in each department compares to the overall, 
-- 		historical average pay.
-- 		In order to make the comparison easier, you should use the Z-score for salaries. 
-- 		In terms of salary, what is the best department right now to work for? The worst?

select avg(salary), std(salary) from employees.salaries; ##determine the average and stddev

create temporary table jemison_1742.historic_aggregates as (
select avg(salary) as avg_salary, std(salary) as std_salary
from employees.salaries;

-- Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 3


USE employees;
show tables;
select salary
from salaries
where to_date > now()
limit 10;

-- 72012
select avg(salary)
from salaries
where to_date > now()
limit 10;

SELECT b.dept_name,
	AVG(b.salary_z_score)
FROM(SELECT d.dept_name,
	((SELECT AVG(salary) FROM salaries)-a.average_salary)
    /
    (SELECT STDDEV(salary) from salaries) AS salary_z_score
FROM dept_emp AS de
	JOIN departments AS d ON (de.dept_no=d.dept_no) AND de.to_date > now()
	JOIN salaries as s ON (de.emp_no=s.emp_no) AND s.to_date > now()
	JOIN (
SELECT d.dept_name, 
	AVG(s.salary) AS average_salary
	FROM departments as d
		JOIN dept_emp AS de ON (d.dept_no=de.dept_no)
		JOIN employees AS e ON (de.emp_no=e.emp_no)
		JOIN salaries AS s ON (e.emp_no=s.emp_no)
		WHERE de.to_date > now() AND s.to_date > now()
GROUP BY d.dept_name) AS a ON (a.dept_name=d.dept_name)) AS b
GROUP BY b.dept_name
ORDER BY b.dept_name; 

SELECT b.dept_name,
	AVG(b.salary_z_score)
FROM(SELECT d.dept_name,
	((SELECT AVG(salary) FROM salaries)-a.average_salary)
    /
    (SELECT STDDEV(salary) from salaries) AS salary_z_score
FROM dept_emp AS de
	JOIN departments AS d ON (de.dept_no=d.dept_no) AND de.to_date > now()
	JOIN salaries as s ON (de.emp_no=s.emp_no) AND s.to_date > now()
	JOIN (
SELECT d.dept_name, 
	AVG(s.salary) AS average_salary
	FROM departments as d
		JOIN dept_emp AS de ON (d.dept_no=de.dept_no)
		JOIN employees AS e ON (de.emp_no=e.emp_no)
		JOIN salaries AS s ON (e.emp_no=s.emp_no)
		WHERE de.to_date > now() AND s.to_date > now()
GROUP BY d.dept_name) AS a ON (a.dept_name=d.dept_name)) AS b
GROUP BY b.dept_name
ORDER BY b.dept_name; 

##'Customer Service', '-0.20553212991356754'
## 'Development', '-0.22757845855098355'
## 'Finance', '-0.8724839976238886'
## 'Human Resources', '-0.00657533823847732'
## 'Marketing', '-0.9611516714067226'
## 'Production', '-0.23854469830483618'
## 'Quality Management', '-0.09649601498852114'
## 'Research', '-0.2426898454076678'
## 'Sales', '-1.4813652192876998'

##best is Sales; worst is Customer Service

USE employees;
CREATE TEMPORARY TABLE jemison_1742.z_scores AS
SELECT d.dept_name,
((SELECT AVG(salary) FROM salaries)-a.average_salary_dept)/(SELECT STDDEV(salary) FROM salaries) AS salary_z_score
FROM dept_emp AS de
JOIN departments AS d ON (de.dept_no=d.dept_no) -- AND de.to_date > now()
JOIN salaries as s ON (de.emp_no=s.emp_no) -- AND s.to_date > now()
JOIN (
SELECT d.dept_name, 
AVG(s.salary) AS average_salary_dept,
STDDEV(s.salary) AS salary_stdev_dept
FROM departments as d
JOIN dept_emp AS de ON (d.dept_no=de.dept_no)
JOIN employees AS e ON (de.emp_no=e.emp_no)
JOIN salaries AS s ON (e.emp_no=s.emp_no)
WHERE de.to_date > now() AND s.to_date > now()
GROUP BY d.dept_name) AS a ON (a.dept_name=d.dept_name);

SELECT dept_name -- AVG(salary_z_score)
FROM jemison_1742.z_scores
GROUP BY dept_name;

select dept_name, AVG(salary_z_score)
from jemison_1742.z_scores
group by dept_name;



    
