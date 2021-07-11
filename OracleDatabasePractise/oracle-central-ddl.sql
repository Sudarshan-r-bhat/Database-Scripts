-- This is where you will be storing all the ddl statements with timestamp and comments.
commit;
rollback;
-- 12 APRIL 2021
-- CREATING A COPY OF HR.EMPLOYEES TABLE. 
create table employee_copy as select * from employees;
describe employee_copy;

-- 13 April 2021
-- CREATING A CUSTOM TYPE:
create type t_days as object(
    v_date date, 
    v_day_number int
);

-- CREATING A NESTED TABLE.
create type t_days_tab is table of t_days;

















