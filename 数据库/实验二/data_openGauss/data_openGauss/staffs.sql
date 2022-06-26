CREATE TABLE staffs
(
staff_id NUMBER(6) not null,
first_name VARCHAR2(20),
last_name VARCHAR2(25),
email VARCHAR2(25),
phone_number VARCHAR2(20),
hire_date DATE,
employment_id VARCHAR2(10),
salary NUMBER(8,2),
commission_pct NUMBER(2,2),
manager_id NUMBER(6),
section_id NUMBER(4),
graduated_name VARCHAR2(60)
);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (198, 'Donald', 'OConnell', 'DOCONNEL', '650.507.9833', to_date('21-06-1999', 'dd-mm-yyyy'), 'SH_CLERK', 2600.00, null, 124, 50);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (199, 'Douglas', 'Grant', 'DGRANT', '650.507.9844', to_date('13-01-2000', 'dd-mm-yyyy'), 'SH_CLERK', 2600.00, null, 124, 50);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (200, 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', to_date('17-09-1987', 'dd-mm-yyyy'), 'AD_ASST', 4400.00, null, 101, 10);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (201, 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', to_date('17-02-1996', 'dd-mm-yyyy'), 'MK_MAN', 13000.00, null, 100, 20);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (202, 'Pat', 'Fay', 'PFAY', '603.123.6666', to_date('17-08-1997', 'dd-mm-yyyy'),
'MK_REP', 6000.00, null, 201, 20);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (203, 'Susan', 'Mavris', 'SMAVRIS', '515.123.7777', to_date('07-06-1994', 'dd-mm-yyyy'), 'HR_REP', 6500.00, null, 101, 40);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (204, 'Hermann', 'Baer', 'HBAER', '515.123.8888', to_date('07-06-1994', 'dd-mm-yyyy'), 'PR_REP', 10000.00, null, 101, 70);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (205, 'Shelley', 'Higgins', 'SHIGGINS', '515.123.8080', to_date('07-06-1994', 'dd-mm-yyyy'), 'AC_MGR', 12000.00, null, 101, 110);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (206, 'William', 'Gietz', 'WGIETZ', '515.123.8181', to_date('07-06-1994', 'dd-mm-yyyy'), 'AC_ACCOUNT', 8300.00, null, 205, 110);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (100, 'Steven', 'King', 'SKING', '515.123.4567', to_date('17-06-1987', 'dd-mm-yyyy'),
'AD_PRES', 24000.00, null, null, 90);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', to_date('21-09-1989', 'dd-mm-yyyy'), 'AD_VP', 17000.00, null, 100, 90);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', to_date('13-01-1993', 'dd-mm-yyyy'), 'AD_VP', 17000.00, null, 100, 90);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', to_date('03-01-1990', 'dd-mm-yyyy'), 'IT_PROG', 9000.00, null, 102, 60);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', to_date('21-05-1991', 'dd-mm-yyyy'), 'IT_PROG', 6000.00, null, 103, 60);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', to_date('25-06-1997', 'dd-mm-yyyy'), 'IT_PROG', 4800.00, null, 103, 60);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', to_date('05-02-1998', 'dd-mm-yyyy'), 'IT_PROG', 4800.00, null, 103, 60);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', to_date('07-02-1999', 'dd-mm-yyyy'), 'IT_PROG', 4200.00, null, 103, 60);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id) values (108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', to_date('17-08-1994', 'dd-mm-yyyy'), 'FI_MGR', 12000.00, null, 101, 100);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (109, 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', to_date('16-08-1994', 'dd-mm-yyyy'), 'FI_ACCOUNT', 9000.00, null, 108, 100);

insert into staffs (staff_id, first_name, last_name, email, phone_number, hire_date,employment_id, salary, commission_pct, manager_id, section_id)values (110, 'John', 'Chen', 'JCHEN', '515.124.4269', to_date('28-09-1997', 'dd-mm-yyyy'),
'FI_ACCOUNT', 8200.00, null, 108, 100);
