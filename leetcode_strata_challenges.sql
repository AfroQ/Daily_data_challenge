-- Employees retiring and their job titles
-- Join employees and titles tables
SELECT
	e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date

-- INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Removing duplicate titles from the retiring employees table
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) 
	emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

-- number of employees about to retire by title
SELECT title, COUNT(title) as "Retirees per title"
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY "Retirees per title" DESC;

-- Employees eligible for mentorship
-- Join employees, departments and titles tables
SELECT DISTINCT ON(emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title

INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY emp_no, title ASC;

-- Find the current salary of each employee assuming that salaries increase each year.
-- Display the most recent salary (use DISTINCT ON)
-- Output their id, first name, last name, department ID, and current salary. 
SELECT DISTINCT ON(id) id, department_id, first_name, last_name, salary
FROM ms_employee_salary
-- Order your list by employee ID in ascending order.
ORDER BY id asc, salary desc;

select max(de.salary), dd.department
from db_employee as de
left join db_dept as dd
on de.id = dd.id
where dd.department IN('marketing', 'engineering')
group by department;

--  first name, last name, city, and state of each person in the Person table

select p.firstName, p.lastName, a.city, a.state
from Person as p
-- left outer join to return null values for entries on the right
left outer join Address as a
on p.personId = a.personId;

-- Select employees and their managers, and their salaries
-- Display all the employee names where their salaries are greater than managerId
-- Need to isolate employees and their salaries vs managers and their salaries
SELECT a.Name as 'Employee'
from Employee as a, Employee as b
where a.ManagerId = b.Id
    AND a.Salary > b.Salary;  

-- Finding duplicate emails
-- solution 1
select email from 
(Select email, count(email) as num
from Person
group by email
order by email) as t2
where num >1;

-- solution 2
select email 
from Person
group by email
having count(email) > 1;

-- Syntax check
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name(s);

-- Write an SQL query to report all customers who never order anything.
SELECT c.name as Customers
FROM Customers as c
Left Join Orders as o
-- Table links
ON c.id = o.customerId
WHERE o.customerId IS Null;

-- DELETE FROM table_name WHERE condition;
-- Write an SQL query to delete all the duplicate emails, 
-- keeping only one unique email with the smallest id
DELETE FROM Person
WHERE id NOT IN(
select * from (select MIN(id) from Person 
                    GROUP BY email) as t2);

-- solution 2 
DELETE t1 FROM Person t1, Person t2
Where t1.id > t2.id
    And t1.email = t2.email;

-- Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).

-- Challenge: Need to find temp record for today compared to yesterday
SELECT id 
FROM Weather
IN (SELECT t1 FROM Weather t1, 
    (SELECT * FROM Weather HAVING(recordDate-1)) t2 
   WHERE t1.temperature > t2.temperature
   AND t1.id = t2.id);

-- Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
-- Challenge: Need to find temp record for today compared to yesterday
SELECT Weather.id FROM Weather
JOIN Weather AS t2  
    ON DATEDIFF(DAY, Weather.recordDate, t2.recordDate) = 1
    AND Weather.temperature > t2.temperature;

