#2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. 
# In your comments, answer: What was the first and last name in the first row of the results? 
# What was the first and last name of the last person in the table?
SELECT *
FROM employees
WHERE
(first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya')
ORDER BY first_name;
#Irena Reutenauer
#Vidya Simmen

SELECT *
FROM employees
WHERE first_name IN ('Irena','Vidya','Maya';

#3 Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. 
# In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
SELECT *
FROM employees
WHERE
(first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya')
ORDER BY first_name, last_name;
#Irena Acton
#Vidya Zweizig

#4 Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. 
#In your comments, answer: What was the first and last name in the first row of the results? 
#What was the first and last name of the last person in the table?
SELECT *
FROM employees
WHERE
(first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya')
ORDER BY last_name, first_name;
#Irena Acton
#Maya Zyda

#5 Write a query to to find all employees whose last name starts and ends with 'E'. 
#Sort the results by their employee number. 
#Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
AND last_name LIKE '%E'
ORDER BY emp_no;
#899
#10021 Ramzi Erde
#499648 Tadahiro Erde

SELECT *
FROM employees
WHERE last_name LIKE "E%E"
ORDER BY emp_no;

#6 Write a query to to find all employees whose last name starts and ends with 'E'. 
# Sort the results by their hire date, so that the newest employees are listed first. 
# Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
AND last_name LIKE '%E'
ORDER BY hire_date DESC;
#899
#Teiji Eldridge
#Sergi Erde

#7 Find all employees hired in the 90s and born on Christmas. 
#Sort the results so that the oldest employee who was hired last is the first result. 
#Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25'
ORDER by hire_date DESC, birth_date ASC;
#362
#Khun Bernini

SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25'
ORDER by birth_date, hire_date DESC;

SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25'
ORDER by hire_date ASC, birth_date DESC;
#Alselm Cappello


#1 Copy the order by exercise and save it as functions_exercises.sql.

#2 Write a query to to find all employees whose last name starts and ends with 'E'. 
#Use concat() to combine their first and last name together as a single column named full_name.


SELECT CONCAT(first_name,' ',last_name) AS full_name
FROM employees
WHERE last_name LIKE 'E%E';

#3 Convert the names produced in your last query to all uppercase.

SELECT UPPER(CONCAT(first_name,' ',last_name)) AS full_name
FROM employees
WHERE last_name LIKE 'E%E';

#4 Find all employees hired in the 90s and born on Christmas. 
#Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),

SELECT DATEDIFF(current_date(),hire_date) AS day_w_company, first_name, last_name, hire_date, birth_date
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25';

#5 Find the smallest and largest current salary from the salaries table.

SELECT min(salary) AS smallest, max(salary) AS largest
FROM salaries;

SELECT min(salary), max(salary)
FROM salaries
WHERE to_date > CURDATE();

#6 Use your knowledge of built in SQL functions to generate a username for all of the employees. 
#A username should be all lowercase, and consist of the first character of the employees first name, 
#the first 4 characters of the employees last name, an underscore, the month the employee was born, 
#and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:
#username(f_initial,l_firstfour,mm,last2year),first_name,last_name,birth_date

SELECT lower(concat(substr(first_name,1,1),substr(last_name,1,4),'_',substr(birth_date,6,2),substr(birth_date,3,2))) AS user_name,
first_name,last_name, birth_date
FROM employees;







