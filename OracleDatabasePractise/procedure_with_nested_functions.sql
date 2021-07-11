
/*
problem statement:
	. create a procedure to insert Employee details to a table,
	with a condition based on their salary.
	procedure must have functions that considers different fields of 
	employee_.. table. to insert or update the row into the table.

dnc:

pc:

tc and asc:


*/
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
    begin
      emp := get_emp(p_emp.employee_id);
      insert into emps_high_paid values emp;
      emp := get_emp(p_emp.email);
      insert into emps_high_paid values emp;
      emp := get_emp(p_emp.first_name,p_emp.last_name);
      insert into emps_high_paid values emp;
    end;
begin
  for r_emp in (select * from employees) loop
    if r_emp.salary > 15000 then
      insert_high_paid_emp(r_emp);
    end if;
  end loop;
end;
-------------------------------------------------------------------------------------------------------------------------------------------------
/
declare
  procedure insert_high_paid_emp(p_emp employees%rowtype) is 
    emp employees%rowtype;
    e_id number;
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
    function get_emp(f_name varchar2, l_name varchar2) return employees%rowtype is
      begin
        select * into emp from employees where first_name = f_name and last_name = l_name;
        return emp;
      end;
    begin
      emp := get_emp(p_emp.employee_id);
      insert into emps_high_paid values emp;
      emp := get_emp(p_emp.email);
      insert into emps_high_paid values emp;
      emp := get_emp(p_emp.first_name,p_emp.last_name);
      insert into emps_high_paid values emp;
    end;
begin
  for r_emp in (select * from employees) loop
    if r_emp.salary > 15000 then
      insert_high_paid_emp(r_emp);
    end if;
  end loop;
end;
/
-- TRIGGER PRACTISE. -- below is the skeleton for creation or replacing the trigger.

CREATE OR REPLACE TRIGGER <TRIGGER_NAME> 
AFTER INSERT OR UPDATE INTO PROJ_TRANSPORT_ATTRIBUTES
FOR EACH ROW
ENABLE
DECLARE
	v_value <type>;
BEGIN
		v_value := case :<something> 
				WHEN <COND> THEN <VALUE>;
				WHEN <COND> THEN <VALUE>;
				end;
		if <CONDITION> then
			<sql-stmt>
		ELSE IF <CONDITION> THEN
			<sql-stmt>
		ELSE 
			<sql-stmt>
		end if;
END;
