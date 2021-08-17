-- This is where you will be storing all the procedure and function statements with timestamp and comments.

-- basic DB stmts
show databases;
use world;
show tables;
desc city;

-----------------------------------------------------------------------------------------
-- 11-april-2021

-- PROCUDURE TO FETCH CITIES OF A PARTICULAR COUNTRY CODE
-- use delimiter compulsorily
delimiter //
CREATE PROCEDURE fetch_cities_based_on_code( IN code varchar(5), OUT city_name text)
BEGIN
	SELECT group_concat(name) as city_names  FROM city WHERE countrycode = code;
END
//
delimiter ;

CALL fetch_cities_based_on_code('ind', @city_name);

select @city_name;

-- GROUP_CONCAT() FUNCTION:
SELECT district, group_concat(name) as city_name, count(name) as count FROM city WHERE countrycode = 'afg' group by district;


