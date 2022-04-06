-- Create a file named case_exercises.sql and craft queries to return 
-- the results for the following criteria:

# 1. Write a query that returns all employees, their department number, 
## their start date, their end date, and a new column 'is_current_employee' 
### that is a 1 if the employee is still with the company and 0 if not.

use employees;
select
	de.emp_no,
    de.dept_no,
    de.from_date AS start_date,
    de.to_date AS end_date,
    de.to_date > NOW() AS is_current_employee
FROM dept_emp de;


#2. Write a query that returns all employee names (previous and current), 
## and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z'
### depending on the first letter of their last name.

SELECT
    first_name,
    last_name,
    LEFT(last_name, 1) AS first_letter_of_last_name,
    CASE
        WHEN LEFT(last_name, 1) <= 'H' THEN 'A-H'
        WHEN LEFT(last_name, 1) <= 'Q' THEN 'I-Q'
        WHEN LEFT(last_name, 1) <= 'Z' THEN 'R-Z'
    END AS alpha_group
FROM employees;

SELECT
    first_name,
    last_name,
    substring(last_name, 1,1) AS first_letter_of_last_name,
    CASE
        WHEN substring(last_name, 1,1) <= 'H' THEN 'A-H'
        WHEN substring(last_name, 1,1) <= 'Q' THEN 'I-Q'
        WHEN substring(last_name, 1,1) <= 'Z' THEN 'R-Z'
        ELSE "UKNOWN"
    END AS alpha_group
FROM employees;

SELECT
    first_name,
    last_name,
    substring(last_name, 1,1) AS first_letter_of_last_name,
    CASE
        WHEN substring(last_name, 1,1) <= 'H' THEN 'A-H'
        WHEN substring(last_name, 1,1) <= 'Q' THEN 'I-Q'
        ELSE'R-Z'
    END AS alpha_group
FROM employees;


-- example from other classmate:
SELECT first_name, last_name, 
	CASE  #first character of last name
		WHEN LEFT(last_name,1) BETWEEN 'a' AND 'h' THEN 'A-H' #Inclusive, also finds uppercase in lowercase range
        WHEN LEFT(last_name,1) BETWEEN 'i' AND 'q' THEN 'I-Q'
        WHEN LEFT(last_name,1) BETWEEN 'r' AND 'z' THEN 'R-Z'
        ELSE 'Other' #If first character not in english alphabet (accent, special character)
	END AS alpha_group
FROM employees;


#3. How many employees (current or previous) were born in each decade?

SELECT birth_date
FROM employees;

SELECT
    COUNT(CASE WHEN birth_date BETWEEN '1950-01-01' 
    AND '1959-12-31' THEN birth_date ELSE NULL END) AS '50s',
    COUNT(CASE WHEN birth_date BETWEEN '1960-01-01' 
    AND '1969-12-31' THEN birth_date ELSE NULL END) AS '60s'
FROM employees;

# 50s - '182886', 60s - '117138'

SELECT
    CONCAT(SUBSTR(birth_date, 1, 3), '0') as decade,
    COUNT(*) as count
FROM employees
GROUP BY decade;


#4. What is the current average salary for each of the following 
## department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, 
### Customer Service?

SELECT
    CASE
        WHEN d.dept_name IN ('Research', 'Development') THEN 'R&D'
        WHEN d.dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
        WHEN d.dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
        WHEN d.dept_name IN ('Finance', 'Human Resources') THEN 'Finanace & HR'
        ELSE d.dept_name
    END AS dept_group,
    format(AVG(s.salary),2,0) AS avg_salary
FROM departments d
JOIN dept_emp de USING (dept_no)
JOIN salaries s USING (emp_no)
WHERE s.to_date > NOW() AND de.to_date > NOW()
GROUP BY dept_group;


