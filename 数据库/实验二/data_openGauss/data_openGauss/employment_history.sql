create table employment_history
(
staff_id NUMBER(6),
start_date DATE,
end_date DATE,
employment_id VARCHAR2(10),
section_id NUMBER(4)
);

insert into employment_history (staff_id,start_date, end_date, employment_id, section_id)values (102, to_date('13-01-1993','dd-mm-yyyy'), to_date('24-07-1998', 'dd-mm-yyyy'), 'IT_PROG', 60);

insert into employment_history (staff_id,start_date, end_date, employment_id, section_id)values (101, to_date('21-09-1989','dd-mm-yyyy'), to_date('27-10-1993', 'dd-mm-yyyy'), 'AC_ACCOUNT', 110);

insert into employment_history (staff_id,start_date, end_date, employment_id, section_id)values (101, to_date('28-10-1993','dd-mm-yyyy'), to_date('15-03-1997', 'dd-mm-yyyy'), 'AC_MGR', 110);

insert into employment_history (staff_id,start_date, end_date, employment_id, section_id)values (201, to_date('17-02-1996','dd-mm-yyyy'), to_date('19-12-1999', 'dd-mm-yyyy'), 'MK_REP', 20);

insert into employment_history (staff_id,start_date, end_date, employment_id, section_id)values (114, to_date('24-03-1998','dd-mm-yyyy'), to_date('31-12-1999', 'dd-mm-yyyy'), 'ST_CLERK', 50);

insert into employment_history (staff_id,start_date, end_date, employment_id, section_id)values (122, to_date('01-01-1999','dd-mm-yyyy'), to_date('31-12-1999', 'dd-mm-yyyy'), 'ST_CLERK', 50);

insert into employment_history (staff_id,start_date, end_date, employment_id, section_id)values (200, to_date('17-09-1987','dd-mm-yyyy'), to_date('17-06-1993', 'dd-mm-yyyy'), 'AD_ASST', 90);

insert into employment_history (staff_id,start_date, end_date, employment_id, section_id)values (176, to_date('24-03-1998','dd-mm-yyyy'), to_date('31-12-1999', 'dd-mm-yyyy'), 'SA_REP', 80);

insert into employment_history (staff_id,start_date, end_date, employment_id, section_id)values (176, to_date('01-01-1999','dd-mm-yyyy'), to_date('31-12-1999', 'dd-mm-yyyy'), 'SA_MAN', 80);

insert into employment_history (staff_id,start_date, end_date, employment_id, section_id)values (200, to_date('01-07-1994','dd-mm-yyyy'), to_date('31-12-1998', 'dd-mm-yyyy'), 'AC_ACCOUNT', 90);





