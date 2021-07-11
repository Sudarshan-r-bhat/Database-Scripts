-- This is where you will be storing all the procedure and function statements with timestamp and comments.

-- 12 APRIL 2021 
-- CREATING PROCEDURE TO INCREASE THE SALARIES OF EMPLOYEES IN COPY TABLE.  
CREATE OR REPLACE PROCEDURE INCREASE_SALARIES AS
CURSOR c_emps is SELECT * FROM EMPLOYEE_COPY FOR UPDATE;
v_salary_increase number :=1.10;
v_old_salary number;
BEGIN
        FOR r_emp IN c_emps LOOP
            v_old_salary := r_emp.salary;
            r_emp.salary := r_emp.salary * v_salary_increase + r_emp.salary * NVL(r_emp.commission_pct, 0);
            UPDATE employee_copy SET ROW = r_emp WHERE CURRENT OF c_emps;
            DBMS_OUTPUT.PUT_LINE('The Salary of : ' || r_emp.employee_id || ' is Increased from ' ||
            v_old_salary || ' to' || r_emp.salary);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
END;


begin
dbms_output.put_line('...............................');
 increase_salaries;
 dbms_output.put_line('...............................');
end;

-- PROCEDURE FOR PRINT instead of dbms_output.put_line(...);
create or replace procedure print(text IN varchar2 default 'This is default value from PRINT procedure!') as
begin
    dbms_output.put_line(text);
end;
-- EXECUTE THE ABOVE PROCEDURE.
execute print('sudarshan is recovering');
execute print;


-- PROCEDURE FOR ACCEPTING DEFAULT PARAMETERS, AND INDEPENDENT OF POSITION
create procedure currency_convert(currency in varchar2 default 'USD', quantity in pls_integer default 10) is -- also you can use 'as'
total_value varchar2(64);
begin
total_value:= case currency 
                            when  'INR' then (currency * quantity)  || ' rupees'
                            when 'USD' then 0.013 * quantity || ' dollars US'
                            when 'AFG' then 1.04 * quantity || ' afghani rupees'
                            when 'PAK' then 2.03 * quantity || ' pak rupees'
                            else -1 || ' currently we only support inr, usd, afg, pak'
                      end;  
                    print(total_value);
end;
execute currency_convert('AFG', quantity => 39);
execute currency_convert(quantity => 79);
execute currency_convert(currency => 'PAK');


-- 13 APRIL 2021
-- FUNCTIONS IN ORACLE PL/SQL AND PROGRAMS.
-- TODO: need to implement the sum function on my own using cursor or dataType.
create or replace function custom_sum(tab table) return pls_integer as
sum_v integer := 0;
begin
    for row in table_col loop
        sum_v := sum_v + 2;  -- this is dummy for now.         
        
    end loop;
    return sum_v;
end custom_sum;
/
-- FUNCTION TO RETURN AVG SALARY OF EMPLOYEES IN A PARTICULAR DEPARTMENT.
create or replace function get_avg_sal(p_dept_id departments.department_id%type) return integer as
v_avg_salary integer;
begin
    select avg(salary) into v_avg_salary from employees where department_id=p_dept_id;
    return v_avg_salary;
end get_avg_sal;
/
select '$ ' || get_avg_sal(10) as avg_sal from dual;

-- CUSTOM TYPES, SUB-PROGRAMS AND THEIR PROPERTIES. 
-- copy the table structure. NOTE: this won't copy the procedrue, functions , partitions, indexes defined for the table.
create table emps_high_paid as select * from employees where 1=2; 
-- this is like a delimiter to avoid executing the above block
/  
declare
    function get_emp(emp_num employees.employee_id%type) return employees%rowtype as 
        emp employees%rowtype;
    begin
        select * into emp from employees where employee_id=emp_num;
        return emp;
        -- exception handling.
        exception
            when no_data_found then
                print('no data found');
                return null;
            when others then
                print('we have hit an exception');
                return null;
    end;
    procedure insert_high_paid_emp (emp_id employees.employee_id%type) as 
        emp employees%rowtype;  -- this is how create a variable of the record 
    begin
        emp := get_emp(emp_id);
        insert into emps_high_paid values emp; -- NOTE: DON'T ADD BRACES HERE. PROGRAM WON'T EXECUTE.
    end;
begin
    for r_emp in (select * from employees) loop
        if r_emp.salary > 15000 then
            insert_high_paid_emp(r_emp.employee_id);
        end if;
    end loop;
end;
/
select * from emps_high_paid;
/
--  THE NESTED TABLE DEFINITION IS PRESENT IN DDL FILE.
create or replace function f_get_days(p_start_date date, p_day_number int) return t_days_tab as
v_days t_days_tab := t_days_tab(); -- Note: this is not a function. You are creating a empty table of type t_days_tab. REFER NESTED TABLE CONCEPT.
begin
    for i in 1 .. p_day_number loop
        v_days.extend; -- This is how you add more record to an existing table.
        v_days(i) := t_days(p_start_date, to_number(to_char(p_start_date + i, 'DDD')));  -- DDD meaning 'day of the year'
    end loop;
    return v_days;
end;
/
select * from table(f_get_days(sysdate, 30));

/

-- PIPELINED FUNCTIONS ARE  LAZY FETCHING METHODS. IT FETCHES 1 ROW AT A TIME
create or replace function f_get_days_piped(p_start_date date, p_day_number int) return t_days_tab pipelined as
begin
    for i in 1 .. p_day_number loop
       pipe row(
            t_days(p_start_date, to_number(to_char(p_start_date + i, 'DDD')))
        );
    end loop;
    return ;
end;
/
select * from table(f_get_days_piped(sysdate, 30000));
/





