-- List the employee number, last name, first name, sex, and salary of each employee 
-- e is Alias for employees table, s is Alias for salaries table

SELECT
	e.first_name AS "First Name",
	e.last_name AS "Last Name",
	e.sex,
	s.salary
FROM employees AS e
INNER JOIN salaries AS s ON e.emp_no=s.emp_no;
		

--	List the first name, last name, and hire date for the employees who were hired in 1986
-- CHATGPT to extract year from date

SELECT
	first_name AS "First Name",
	last_name AS "Last Name",
	hire_date AS "Hire Date"
FROM
	employees
WHERE
	EXTRACT(YEAR FROM hire_date) = 1986;

/* List the manager of each department along with their 
department number, department name, employee number,
last name, and first name
*/
/* d as alias for Department table
	m as aliss for dept_manager table
	e. as alias for employees table
*/

SELECT
	d.dept_no AS "Department Number",
	d.dept_name AS "Department Name",
	m.emp_no AS "Employee Number",
	e.last_name AS "Last Name",
	e.first_name AS "First Name"
FROM
	Department as d
INNER JOIN dept_manager AS m ON d.dept_no=m.dept_no
INNER JOIN employees AS e ON e.emp_no=m.emp_no;

/* List the department number for each employee along with that 
employee’s employee number, last name, first name, and department name 
*/

/* d as alias for department table
	de as alias for dept_emp table
	e for employee table
*/

SELECT
	de.dept_no AS "Department Number",
	de.emp_no AS "Employee Number",
	e.last_name AS "Last Name",
	e.first_name AS "First Name",
	d.dept_name AS "Department Name"
FROM 
	dept_emp AS de
INNER JOIN employees AS e ON e.emp_no=de.emp_no
INNER JOIN department AS d ON d.dept_no=de.dept_no;

/*List first name, last name, and sex
of each employee whose first name is Hercules
and whose last name begins with the letter B 
*/

SELECT
	first_name AS "First Name",
	last_name AS "Last Name",
	sex AS "Sex"
FROM
	employees
WHERE
	first_name = 'Hercules'
	AND 
	last_name LIKE 'B%';

/*List each employee in the Sales department, including their employee number, 
last name,
and first name */

SELECT
	emp_no AS "Employee Number",
	last_name AS "Last Name",
	first_name AS "First Name"
FROM
	employees
WHERE
	emp_no IN 
		(Select
			emp_no
		FROM 
			dept_emp
		WHERE dept_no IN
			(SELECT 
				dept_no
			FROM 
				department
			WHERE
				dept_name = 'Sales'
				)
		);
		
/*List each employee in the Sales and Development departments,
including their employee number, last name, first
name, and department name
*/

SELECT
	e.emp_no AS "Employee Number",
	e.last_name AS "Last Name",
	e.first_name AS "First Name",
	d.dept_name AS "Department Name"
FROM
	employees AS e
JOIN
    dept_emp AS de ON e.emp_no = de.emp_no
JOIN
    department AS d ON de.dept_no = d.dept_no
WHERE
    d.dept_name IN ('Sales', 'Development');

/*List the frequency counts, in descending order, of all the employee last names
(that is, how many employees share
each last name) */

SELECT
	last_name AS "Last Name",
	COUNT(last_name) AS "Frequency of Name"
FROM
	employees
GROUP BY
	last_name
ORDER BY
	"Frequency of Name" DESC;