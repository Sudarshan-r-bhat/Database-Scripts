-- This is the first local sub-program
declare
    function get_emp(emp_num employees.employee_id%type) return employees%rowtype is
        emp employees%rowtype;
        begin
          select * into emp from employees where employee_id = emp_num;
          return emp;
    end;
  procedure insert_high_paid_emp(emp_id employees.employee_id%type) is 
    emp employees%rowtype;
    begin
      emp := get_emp(emp_id);
      insert into emps_high_paid values emp;  -- NOTE: DON'T ADD BRACES HERE. PROGRAM WON'T EXECUTE.
    end;
  
begin
  for r_emp in (select * from employees) loop
    if r_emp.salary > 15000 then
      insert_high_paid_emp(r_emp.employee_id);
    end if;
  end loop;
end;

/
select * from employees where salary > 15000;
/
--   OVERLOADING the FUNCTION as in the sub-programs.
declare
  procedure insert_high_paid_emp(p_emp employees%rowtype) is 
    emp employees%rowtype;
    function get_emp(emp_num employees.employee_id%type) return employees%rowtype is
      begin
        select * into emp from employees where employee_id = emp_num;
        return emp;
      end;
    function get_emp(emp_email employees.email%type) return employees%rowtype is
      begin
        select * into emp from employees where email = emp_email;
        return emp;
      end;
      -- Overloading is not possible for same parameter types. even though the columns are different.
--    function get_emp(emp_dpt_id employees.department_id%type) return employees%rowtype is
--      begin
--        select * into emp from employees where department_id = emp_dpt_id;
--        return emp;
--      end;
    begin
      emp := get_emp(p_emp.employee_id);
      insert into emps_high_paid values emp;  -- NOTE: DON'T ADD BRACES HERE. PROGRAM WON'T EXECUTE.
      emp:= get_emp(p_emp.email);
      insert into emps_high_paid values emp;
--      emp:= get_emp(p_emp.department_id);
--      insert into emps_high_paid values emp;
    end;
  
begin
  for r_emp in (select * from employees) loop
    if r_emp.salary > 15000 then
      insert_high_paid_emp(r_emp);
    end if;
  end loop;
end;
/
-------------------------------------------------------------------------
truncate table emps_high_paid;

select * from emps_high_paid;
/
-------------------------------------------------------------------------
create or replace function get_emp (emp_num employees.employee_id%type ) return employees%rowtype is
emp employees%rowtype;
begin
    select * into emp from employees where employee_id = emp_num;
    return emp;
end;
/

-- EXCEPTION HANDLING INSIDE THE FUNCTIONS. REFER: GET_EMP() in DB not in sql file.
declare 
    v_emp employees%rowtype;
begin
    dbms_output.put_line('fetching the employee data!..');
    v_emp:= get_emp(10);
    print('some of the information of the employee are: ');
    dbms_output.put_line(nvl(v_emp.first_name, 'null'));
end;


select to_char(sysdate, 'DDD') from dual;
/
-- implementation of sum functionr:     PENDING , BELOW IS THE FAILED ATTEMPT  AT IT.
create type rec as object(
    v_data number
);
/
create type tab_of_rec is table of rec;
/
create or replace function f_sum_rec(p_rec_tab tab_of_rec) return number as
    v_total number := 0;
    v_tab tab_of_rec ;
begin
    select * into v_tab from table(p_rec_tab);
    for r_rec in v_tab loop
        v_total := v_total + to_number(r_rec);
    end loop;
    return v_total;
end;




