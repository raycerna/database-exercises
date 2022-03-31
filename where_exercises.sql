#1
USE employees;

#2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. 
#Enter a comment with the number of records returned. 477
SELECT COUNT(DISTINCT first_name, last_name, birth_date)
FROM employees
where first_name in ('Irena','Vidaya','Maya');

SELECT *
FROM employees
WHERE first_name IN ('Irena','Vidaya','Maya');


#3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', 
#as in Q2, but use OR instead of IN. 
#Enter a comment with the number of records returned. 
#Does it match number of rows from Q2?
SELECT COUNT(DISTINCT first_name, last_name, birth_date)
FROM employees
where first_name = ('Irena')
OR first_name = ('Vidya')
OR first_name = ('Maya');
#709, not it does not match
SELECT *
FROM employees
WHERE first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya';

#4. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya',
#using OR, and who is male. Enter a comment with the number of records returned.
SELECT DISTINCT first_name, gender
FROM employees
WHERE gender = 'M'
AND first_name = ('Irena') 
OR first_name = ('Vidya')
AND gender = 'M'
OR first_name = ('Maya')
AND gender = 'M';

SELECT *
FROM employees
WHERE gender = 'M'
AND
(first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya');


SELECT COUNT(DISTINCT first_name, gender)
FROM employees
WHERE first_name = ('Irena') 
AND gender = 'm'
OR first_name = ('Vidya')
AND gender = 'm'
OR first_name = ('Maya')
AND gender = ('M');
#3

#5. Find all current or previous employees whose last name starts with 'E'. 
#Enter a comment with the number of employees whose last name starts with E.
SELECT DISTINCT last_name
FROM employees
WHERE last_name
LIKE 'E%';

SELECT *
FROM employees
WHERE last_name like 'E%';

SELECT COUNT(DISTINCT last_name)
FROM employees
WHERE last_name
LIKE 'E%';
#40

#6. Find all current or previous employees whose last name starts or ends with 'E'. 
#Enter a comment with the number of employees whose last name starts or ends with E.
#How many employees have a last name that ends with E, but does not start with E?
SELECT DISTINCT last_name
FROM employees
WHERE last_name
LIKE 'E%'
OR last_name
LIKE '%E';

SELECT *
FROM employees
WHERE last_name LIKE 'E%'
OR last_name LIKE '%E';

SELECT COUNT(DISTINCT last_name)
FROM employees
WHERE last_name
LIKE 'E%'
OR last_name
LIKE '%E';
#167

SELECT *
FROM employees
WHERE last_name LIKE '%E'
AND NOT last_name LIKE 'E%';

SELECT COUNT(DISTINCT last_name)
FROM employees
WHERE last_name
LIKE '%E';
#132

#7. Find all current or previous employees employees whose last name starts and ends with 'E'. 
#Enter a comment with the number of employees whose last name starts and ends with E. 
#How many employees' last names end with E, regardless of whether they start with E?
SELECT DISTINCT last_name
FROM employees
WHERE last_name
LIKE 'E%'
AND last_name
LIKE '%E';

SELECT COUNT(DISTINCT last_name)
FROM employees
WHERE last_name
LIKE 'E%'
AND last_name
LIKE '%E';
#5

SELECT COUNT(DISTINCT last_name)
FROM employees
WHERE last_name
LIKE '%E';
#132

#8. Find all current or previous employees hired in the 90s. 
#Enter a comment with the number of employees returned.

SELECT * 
FROM employees
WHERE hire_date LIKE '199%';

SELECT *
FROM employees
WHERE last_name like 'E%E';

SELECT *
FROM employees
WHERE birthdate LIKE '%-12-25';

SELECT * 
FROM employees 
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
AND birth_date LIKE '%-12-25';

#11
SELECT *
FROM employees
WHERE last_name LIKE '%q%';

#12
SELECT *
FROM employees
WHERE last_name LIKE '%q%'
AND NOT last_name LIKE '%qu%';




