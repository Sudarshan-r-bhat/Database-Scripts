

-- 18 APRIL 2021
-- CREATING A BASIC VIEW TO FETCH ALL 
CREATE OR REPLACE VIEW basic_hr_view
(name, nationality, location, department, salary)
as (
select 
emp.first_name as name, 
c.country_name || 'ian'  as nationality, 
l.city as location,
d.department_name department,
emp.salary 
from employees emp
inner join departments d on d.department_id = emp.department_id
inner join locations l on l.location_id = d.location_id
inner join countries c on c.country_id = l.country_id

)
order by salary desc;
/
select * from basic_hr_view;

-- CREATING A MATERIALIZED VIEW.

-- PENDING
