-- 18 april 2021
-- CREATING INDEX ON EMPLOYEE_COPY TABLE BASED ON ---> FIRST_NAME AND LAST_NAME.
CREATE INDEX emp_names_idx 
ON employee_copy (first_name, last_name);

-- EXECUTING THE QUERY TO CHECK PERFORMANCE. 
select count(*) from employees;
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE upper(LAST_NAME) LIKE '%SMITH%';

select count(*) from employee_copy;
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEE_COPY WHERE upper(LAST_NAME) LIKE '%SMITH%';

-- CONCLUSION: IT DOESN'T MATTER UNTIL THE SIZE OF THE TABLE IS HUGE. ANYWAY 2nd QUERY ON employee_copy table PERFORMED BETTER.

-- PARTITIONING BY RANGE, HASH, LIST 
ALTER TABLE EMPLOYEE_COPY MODIFY PARTITION BY RANGE(EMPLOYEE_ID) INTERVAL (30) (
    PARTITION P1 VALUES LESS THAN(30),
    PARTITION P2 VALUES LESS THAN(60)
) ONLINE;


SELECT * FROM employee_copy PARTITION(P1);
DESC EMPLOYEE_COPY;

-- 19 april 2021
create table non_partitioned (id int, phone number, salary int);
drop table non_partitioned;

alter table non_partitioned modify partition by range(id) interval(20)(
    partition p1 values less than (20),
    partition p2 values less than (40)
)online;

insert into non_partitioned
select 1, 987, 100 from dual 
union all
select 2, 234, 200 from dual 
union all
select 29, 343, 222 from dual
;
insert into non_partitioned values(56, 983653, 2200);

select * from non_partitioned; -- partition(p1);
select * from non_partitioned  partition(sys_p408);

