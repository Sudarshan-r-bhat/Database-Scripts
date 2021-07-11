-- QUERIES ARE MOVED TO 'VIEWS_MATERIALIZED_VIEWS.SQL'

-- MERGE QUERY
/*
NOTES: 
        syntax goes like  merge into a table based on the data in another table. compare 2 tables based on common column.
        when the columns match. it means the record is already present. Hence you update it.
        else you will end up inserting new record into  the 2nd table.
*/

-- CREATING A EMPTY TABLE; FOLLOWING THE COLUMN NAMES OF EMPLOYEE_COPY  TABLE.
create table MERGED_EMPLOYEE as (select * from employee_copy where 1 = 2);  -- 1 == 2 means col 1 and col 2 are equating , which is always false.

MERGE INTO MERGED_EMPLOYEE  me
USING EMPLOYEE_COPY ec
ON (me.employee_id = ec.employee_id)
WHEN  MATCHED THEN 
    UPDATE SET me.first_name = ec.first_name
WHEN NOT MATCHED THEN
    INSERT (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) 
    VALUES (ec.employee_id,ec.first_name,ec.last_name,ec.email,ec.phone_number,ec.hire_date,ec.job_id,ec.salary,ec.commission_pct,ec.manager_id,ec.department_id)
;


-- FETCHING ALL THE COLUMN NAMES OF EMPLOYEE_COPY TABLE.
select listagg('ec.' || column_name, ', ') from ALL_TAB_COLUMNS where table_name='EMPLOYEE_COPY';
-- ec.EMPLOYEE_ID, ec.FIRST_NAME, ec.LAST_NAME, ec.EMAIL, ec.PHONE_NUMBER, ec.HIRE_DATE, ec.JOB_ID, ec.SALARY, ec.COMMISSION_PCT, ec.MANAGER_ID, ec.DEPARTMENT_ID


-- XML AGGREGATION, XML ELEMENT
select XMLELEMENT("columnList", XMLAGG (XMLELEMENT("column", column_name) ) ) as aggregation from ALL_TAB_COLUMNS where table_name='EMPLOYEE_COPY';


