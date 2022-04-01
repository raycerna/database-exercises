#NOTES from Group_By lesson

select gender from employees
group by gender;

select first_name from employees
group by first_name;

select emp_no, avg(salary), min(to_date) from salaries
group by emp_no;

select gender, avg(salary), format(stddev(salary), 0) from employees #the'0' is the number of decimal places
join salaries using (emp_no)
group by gender;

select * from employees
where gender = 'F';

select emp_no, avg(salary) as avg_salary from salaries
group by emp_no
having avg_salary > 50000;

#exercises
#1Create a new file named group_by_exercises.sql

#2 In your script, use DISTINCT to find the unique titles in the titles table. 
# How many unique titles have there ever been? Answer that in a comment in your SQL file.

SELECT DISTINCT title 
FROM titles;
#7

#3 Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.

SELECT last_name AS 'unique_last_name_w_E%E'
FROM employees
WHERE last_name like 'E%E' 
GROUP BY last_name;

#4 Write a query to to find all unique combinations of first and 
# last names of all employees whose last names start and end with 'E'.

select first_name, last_name as 'uni_last_name_w_E%E'
from employees
where last_name like 'E%E'
group by first_name, last_name;

#5 Write a query to find the unique last names with a 'q' but not 'qu'. 
#Include those names in a comment in your sql code.

select last_name
from employees
where instr(last_name,'Q')>1
and where not(last_name like 'QU'); #incorrect

select last_name
from employees
where not(last_name like 'QU%QU'); #incorrect

select last_name
from employees
where instr(last_name,'q')>1 and not instr(last_name,'qu')>1
group by last_name;
#CHLEQ,LINDQVIST



#6 Add a COUNT() to your results (the query above) to find the number of employees with the same last name.

select count(last_name) as 'count', last_name
from employees
where instr(last_name,'q')>1 and not instr(last_name,'qu')>1
group by last_name;

select last_name, count(last_name;

#7 Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. 
#Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

select count(first_name) as 'count', gender
from employees
where (first_name = 'irena'
or 'vidya'
or 'maya')
group by gender;

select count(*), gender
from employees
where (first_name = 'irena'
or 'vidya'
or 'maya')
group by gender;

select gender, first_name(gender)
from employees
where first_name IN('Irena','vidya','maya')
group by gender, first_name;

#8 Using your query that generates a username for all of the employees, generate a count employees for each unique username. 
# Are there any duplicate usernames? BONUS: How many duplicate usernames are there?

SELECT lower(concat(substr(first_name,1,1),substr(last_name,1,4),'_',substr(birth_date,6,2),substr(birth_date,3,2))) AS 'user_name', 
count(*)
FROM employees
GROUP BY user_name
ORDER BY COUNT(*) DESC; 

SELECT lower(concat(substr(first_name,1,1),substr(last_name,1,4),'_',substr(birth_date,6,2),substr(birth_date,3,2))) AS 'user_name', 
count(*) as 'count_of_users'
FROM employees
GROUP BY user_name
HAVING count(*)>=2;
#yes, 13251 duplicates

#9
select concat('$',format(salary, 0)) as salary
from salaries;












