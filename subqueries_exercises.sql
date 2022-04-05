use employees;

select avg(salary) from salaries;

select emp_no from salaries
where;# not done

select emp_no from dept_manager
where dept_manage.to_date > now();

select first_name, last_name
from employees
where emp_no in; #?

select * from salaries
where to_date > now();

select current_salary.emp_no, current_salary.salary, first_name
from (select * from salaries
where to_date > now()) as current_salary
join employees using(emp_no);

-- find all employees whose current salary > overall average salary
select avg(salary) from salaries;
select * from salaries
join employees using (emp_no)
where salary >(select avg(salary) from salaries)
and salaries.to_date > now();

-- find all the department current managers names and birth dates
#get em_no for dept managers

select emp_no from dept_manager
where to_date > now();

select first_name, last_name, birth_date
from employees
where emp_no in();

-- find all employees with first name starting with 'geor'.
-- then join with salary table list first_name, last_name and salary
select * from employees
where first_name like 'geor%';

select table1.first_name, table1.last_name, salary
from (select * from employees
where first_name like 'geor%') as table1
join salaries using (emp_no);

#subquery in select statement example
select *, (select avg(salary) from salaries where to_date > now())
	from salaries;
    
-- Subqueiries_exercises

#1 Find all the current employees with the same hire date as employee 101010 using a sub-query.
select * from employees
where emp_no like '101010';

select hire_date from employees
where emp_no = '101010';

select first_name, last_name, hire_date
from employees
where hire_date in (
select hire_date from employees
where emp_no = '101010');

select *
from employees
JOIN dept_emp using (emp_no)
where to_date > now()
and hire_date =
	(select hire_date
    from employees
    where emp_no = 101010);

#2 Find all the titles ever held by all current employees with the first name Aamod.
select * from employees
where first_name like 'Aamod';

SELECT e.first_name,t.title
FROM titles AS t
JOIN employees AS e ON (t.emp_no=e.emp_no)
WHERE e.first_name='Aamod';

select distinct title
from titles
where emp_no IN (
	select emp_no
    from employees
    join dept_emp using (emp_no)
    where first_name ='aamod'
    and to_date > now());


#3 How many people in the employees table are no longer working for the company? 
#Give the answer in a comment in your code.

SELECT COUNT(*) as no_longer_w_company
	FROM employees 
	WHERE emp_no IN(
SELECT emp_no 
	FROM dept_emp
	GROUP BY emp_no
	HAVING max(to_date)<NOW());
    
select count(*) #count all the records
from employees #from the employees table
where emp_no not in
	(select emp_no
    from dept_emp
    where to_date > now());

#4 Find all the current department managers that are female. 
#List their names in a comment in your code. 

SELECT first_name,last_name, gender
FROM employees
WHERE emp_no IN(
SELECT emp_no 
FROM dept_manager
WHERE to_date>NOW()) AND gender='F';

# first_name, last_name, gender
#Isamu, Legleitner, F
#Karsten, Sigstam, F
#Leon, DasSarma, F
#Hilary, Kambil, F

select *
from employees
where emp_no in (
	select emp_no
		from dept_manager
			where to_date > now()
and gender="F";

-- 5)Find all the employees that currently have a higher than average salary.

SELECT e.first_name,e.last_name,s.salary, 'YES' as '> AVG_SALARY'
FROM employees AS e
JOIN salaries AS s ON (e.emp_no=s.emp_no)
WHERE s.salary>(
SELECT AVG(salary)
FROM salaries) AND s.to_date>NOW();


select emp_no
from salaries s
join employees e using(emp_no)
where to_date > now()
and salary > (select avg(salary) from salaries);

-- 6) How many current salaries are within 1 standard deviation of the highest salary? 
-- (Hint you can use a built in function to calculate the standard deviation.) 
-- What percentage of all salaries is this?
-- Returns the historic z-scores for each salary
-- Notice that there are 2 separate scalar subqueries involved
SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;


SELECT COUNT(*) as count,
CONCAT(FORMAT(COUNT(*)/(SELECT COUNT(*) FROM salaries WHERE to_date>NOW())*100,3), '%') as 'Percentage of all Salaries'
FROM salaries
WHERE to_date>NOW() AND salary >(SELECT MAX(salary)-STDDEV(salary) FROM salaries);

#78,.032%

#what is the max salary?
select max(salary) from salaries where to_date > now();

#what is the 1std for current salary;
select stddev(salary) from salaries where to_date > now();

select count(*) 
from salaries
where to_date > now()
and salary > (
(select max(salary) from salaries where to_date > now()) - 
(select stddev(salary) from salaries where to_date > now()));

#what percent
#count (numerator) / count of overall (denominator) *100

select count(*) from salaries
where to_date > now();

select ((select count(*) 
from salaries
where to_date > now()
and salary > (
(select max(salary) from salaries where to_date > now())-
(select std(salary) from salaries where to_date > now())
)) / (select count(*) 
from salaries
where to_date > now())) * 100 as "percentage";


-- BONUS
-- 1. Find all the department names that currently have female managers.

SELECT d.dept_name, gender
FROM employees AS e
JOIN dept_emp AS de ON (e.emp_no=de.emp_no)
JOIN departments AS d ON (d.dept_no=de.dept_no)
WHERE e.emp_no IN(
SELECT emp_no 
FROM dept_manager
WHERE to_date>NOW()) AND gender='F'
ORDER BY d.dept_name;

-- 2. Find the first and last name of the employee with the highest salary.

SELECT e.first_name,e.last_name,s.salary as Highest_Salary
FROM employees AS e
JOIN salaries AS s ON (e.emp_no=s.emp_no)
WHERE s.salary=(
SELECT MAX(salary)
FROM salaries) AND s.to_date>NOW();

-- 3. Find the department name that the employee with the highest salary works in.

SELECT d.dept_name as 'Depo w/ Highest $$$ that you wish you worked in'
FROM employees AS e
JOIN dept_emp AS de ON (e.emp_no=de.emp_no)
JOIN departments AS d ON (d.dept_no=de.dept_no)
JOIN salaries AS s ON (e.emp_no=s.emp_no)
WHERE s.salary=(
SELECT MAX(salary)
FROM salaries) AND s.to_date>NOW();













