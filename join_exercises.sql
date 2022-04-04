#join example database

use join_example_db;
select *
from users
right join roles on users.role_id = roles.id;

select *
from users
left join roles on roles.id= users.role_id;

select roles.name
from roles
left join users on roles.id = users.role_id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
         JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
         LEFT JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
         RIGHT JOIN roles ON users.role_id = roles.id;

SELECT roles.name AS 'Role', COUNT(u.role_id) AS 'Count'
FROM roles
         LEFT JOIN users u ON roles.id = u.role_id
GROUP BY roles.name;

select roles.name as role_name, 
count(users.name) as number_of_employees
from users
right join roles on users.role_id = roles.id
group by role_name;

#1. employee database exercises
use employees;

#2. Using the example in the Associative Table Joins section as a guide, 
#write a query that shows each department along with the name of the current manager for that department.

SELECT d.dept_name AS 'Department Name',
CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager'
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
JOIN departments AS d ON dm.dept_no = d.dept_no
WHERE dm.to_date > CURDATE()
ORDER BY d.dept_name;

select d.dept_name,
concat(e.first_name, ' ', e.last_name) as current_department_manager
from employees as e
join dept_manager as dm on e.emp_no = dm.emp_no
and to_date > curdate()
join departments as d using (dept_no)
order by dept_name;

#3. Find the name of all departments currently managed by women.

SELECT d.dept_name AS 'Department Name',
CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager'
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
JOIN departments AS d ON dm.dept_no = d.dept_no
WHERE dm.to_date > CURDATE()
AND e.gender = 'F'
ORDER BY d.dept_name;

select d.dept_name,
concat(e.first_name, ' ', e.last_name) as current_department_manager,
gender
from employees as e; #not finished


#4 Find the current titles of employees currently working in the Customer Service department.

SELECT t.title AS 'Title', COUNT(t.emp_no) AS 'Count'
FROM titles AS t
JOIN dept_emp AS de ON t.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
WHERE t.to_date > CURDATE()
AND d.dept_name = 'Customer Service'
AND de.to_date > CURDATE()
GROUP BY t.title;

select * from dept_emp;


#5 Find the current salary of all current managers.

SELECT d.dept_name AS 'Department Name',
CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager',
CONCAT('$',s.salary) AS 'Salary'
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
JOIN departments AS d ON dm.dept_no = d.dept_no
JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE s.to_date > CURDATE()
AND dm.to_date > CURDATE()
ORDER BY d.dept_name;

select d.dept_name,
concat(e.first_name, ' ', e.last_name) as current_department_manager; #not done

select *
from employees
limit 5;

#6 Find the number of current employees in each department.
select count(*) as count,employees.emp_no
from employees
inner join departments on employees.emp_no = departments.dept_no 
group by departments.dept_name;

select 
	d.dept_no,
	d.dept_name,
	count(emp_no) as num_employees
from dept_emp as de
join departments as d on de.dept_no = d.dept_no
	and de.to_date > curdate()
group by dept_no, dept_name;

#7 Which department has the highest average salary? Hint: Use current not historic information.

select  
	d.dept_name,
	round(avg(salary), 2) as average_salary
from dept_emp as de
join salaries as s on de.emp_no = s.emp_no
	and de.to_date > curdate()
    and s.to_date > curdate()
join departments as d on de.dept_no = d.dept_no
group by d.dept_name
order by average_salary desc
limit 1;

#8 Who is the highest paid employee in the Marketing department?

select 
	e.first_name,
	e.last_name
from employees as e
join dept_emp as de on e.emp_no / de.emp_no
	and de.to_date > curdate()
join salaries as s on e.emp_no = s.emp_no
	and s.to_date > curdate()
join departments as d on de.dept_no = d.dept_no
	and d.dept_name = 'Marketing'
order by s.salary desc
limit 1;

#9

select
	e.fist_name,
    e.last_name,
    s.salary,
    d.dept_name
from emylopees as e;




#10
select d.dept_name, round(avg(s.salary),0) as avg_dept_salary
from departments d
join dept_emp de on d.dept_no;


#11 Bonus Find the names of all current employees, their department name, and their current manager's name.

select 
	dm.dept_no,
    concat(e.first_name, ' ', e.last_name) as managers
from employees as e
join dept_manager as dm on e.emp_no = dm.emp_no
	and to_date > curdate();
    
select
	concat(e.first_name, ' ', e.last_name) as 'employee name',
	d.dept_name as 'depart name',
    m.managers as 'man name'
from employees as e
join dept_emp as de on de.emp_no = e.emp_no
	and de.to_date ;> curdate()
join departments as d on de.dept_no = d.dept_no
join (select
		dm.dept_no,
        concat(e.first_name, ' ', e.last_name) as managers;
        
SELECT CONCAT(e.first_name, ' ', e.last_name)   AS 'Employee',
       d.dept_name AS 'Department Name',
       CONCAT(e2.first_name, ' ', e2.last_name) AS 'Manager'
FROM employees AS e
         JOIN dept_emp de ON e.emp_no = de.emp_no
         JOIN departments d ON de.dept_no = d.dept_no
         JOIN dept_manager dm ON d.dept_no = dm.dept_no AND dm.to_date > CURDATE()
         JOIN employees e2 ON e2.emp_no = dm.emp_no
WHERE de.to_date > CURDATE()
ORDER BY d.dept_name;

#12 Bonus Who is the highest paid employee within each department.

SELECT 
    dept_name AS 'Department',
    CONCAT(employees.first_name,
            ' ',
            employees.last_name) AS 'Highest Paid Employee'
FROM
    departments
        JOIN
    (SELECT 
        dept_no, MAX(salary) AS max_salary
    FROM
        dept_emp
    JOIN salaries USING (emp_no)
    WHERE
        dept_emp.to_date > NOW()
    GROUP BY dept_no) AS a USING (dept_no)
        JOIN
    salaries ON a.max_salary = salaries.salary
        JOIN
    employees USING (emp_no);







