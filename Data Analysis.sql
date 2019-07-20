-- List the following details of each employee: employee number, last name, first name, gender, and salary.

select e.emp_no,first_name,last_name,gender,salary
from
Employees E,
SALARIES S
where e.emp_no = s.emp_no;

-- List employees who were hired in 1986.

select *
from
Employees
where date_trunc('year', hire_date) = '1986-01-01';

-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

select
d.dept_no,
d.dept_name,
e.emp_no,
e.last_name,
e.first_name,
DM.from_date,
DM.to_date
from
Department D,
DEPT_MANAGER DM,
Employees E
where
D.dept_no = DM.dept_no and
DM.emp_no=E.emp_no;

-- List the department of each employee with the following information: employee number, last name, first name, and department name.
select * from dept_emp;
select
e.emp_no,
last_name,
first_name,
dept_name
from
Department D,
DEPT_EMP DE,
Employees E
where
D.dept_no = DE.dept_no and
DE.emp_no=E.emp_no;

-- List all employees whose first name is "Hercules" and last names begin with "B."

select * from Employees
where first_name = 'Hercules'
and last_name like 'B%';

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.

select
e.emp_no,
last_name,
first_name,
dept_name
from
Department D,
DEPT_EMP DE,
Employees E
where
D.dept_no = DE.dept_no and
DE.emp_no=E.emp_no and
d.dept_name = 'Sales';

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

select
e.emp_no,
last_name,
first_name,
dept_name
from
Department D,
DEPT_EMP DE,
Employees E
where
D.dept_no = DE.dept_no and
DE.emp_no=E.emp_no and
d.dept_name in ( 'Development' ,'Sales' )
;

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

select count(*),last_name from Employees
group by last_name
order by count(*) desc;
