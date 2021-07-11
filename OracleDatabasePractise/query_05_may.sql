
-- 05-May-2021
-- HERE i WILL BE WORKING ON CURSORS.

-- USING FOR LOOP ON EXTERNAL CURSORS.  (EXPLICIT CURSOR)
-- THERE ARE OTHER LIKE CURSOR WITH PARAMETER, IMPLICIT PARAMETER, 
declare
    cursor emp_cursor is 
        select first_name, last_name from employee_copy;
begin
    -- open emp_cursor;
    for rec in emp_cursor loop
        print(rec.first_name);
    end loop;
end;

-- FETCH STATEMENT ALONG WITH CURSOR
DECLARE 
v_name varchar2(32);
v_salary number;
CURSOR c1 is SELECT first_name, salary FROM EMPLOYEE_COPY;
BEGIN
    open c1;
    loop
        fetch c1 into v_name, v_salary;
        exit when c1%NOTFOUND;
        dbms_output.put_line(v_name || ' ' || v_salary);
    end loop;
    close c1;
END;
