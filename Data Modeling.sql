
CREATE TABLE Employees(
    "emp_no" int   NOT NULL,
    "birth_date" date    NULL,
    "first_name" varchar    NULL,
    "last_name" varchar    NULL,
    "gender" char    NULL,
    "hire_date" date    NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);


CREATE TABLE Department (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NULL,
    CONSTRAINT "pk_Department" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE DEPT_EMP (
    "emp_no" int   NOT NULL,
    "dept_no" varchar   NOT NULL,
    "from_date" date    NULL,
    "to_date" date    NULL,
    CONSTRAINT "pk_DEPT_EMP" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE DEPT_MANAGER (
    "dept_no" varchar   NOT NULL,
    "emp_no" int   NOT NULL,
    "from_date" date    NULL,
    "to_date" date    NULL,
    CONSTRAINT "pk_DEPT_MANAGER" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE SALARIES (
    "emp_no" int   NOT NULL,
    "salary" float    NULL,
    "from_date" date    NULL,
    "to_date" date    NULL,
    CONSTRAINT "pk_SALARIES" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE TITLES (
    "emp_no" int   NOT NULL,
    "title" varchar   NOT NULL,
    "from_date" date  NOT  NULL,
    "to_date" date    NULL,
    CONSTRAINT "pk_TITLES" PRIMARY KEY (
        "emp_no","title","from_date"
     )
);

ALTER TABLE DEPT_EMP ADD CONSTRAINT "fk_DEPT_EMP_emp_no" FOREIGN KEY("emp_no")
REFERENCES Employees ("emp_no");

ALTER TABLE DEPT_EMP ADD CONSTRAINT "fk_DEPT_EMP_dept_no" FOREIGN KEY("dept_no")
REFERENCES Department ("dept_no");

ALTER TABLE DEPT_MANAGER ADD CONSTRAINT "fk_DEPT_MANAGER_dept_no" FOREIGN KEY("dept_no")
REFERENCES Department ("dept_no");

ALTER TABLE DEPT_MANAGER ADD CONSTRAINT "fk_DEPT_MANAGER_emp_no" FOREIGN KEY("emp_no")
REFERENCES Employees ("emp_no");

ALTER TABLE SALARIES ADD CONSTRAINT "fk_SALARIES_emp_no" FOREIGN KEY("emp_no")
REFERENCES Employees ("emp_no");

ALTER TABLE TITLES ADD CONSTRAINT "fk_TITLES_emp_no" FOREIGN KEY("emp_no")
REFERENCES Employees ("emp_no");
