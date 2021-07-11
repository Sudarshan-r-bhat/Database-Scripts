
column name format a20;

show con_name;
select name, con_id from v$pdbs;
show con_name;
-- ORACLE NOTES IN GIT REMOTE REPO @gitlab for further instruction / Manish from youtube
-- TO MOUNT THE PLUGGABL DB RUN THE BELOW COMMAND.
alter session set container=orclpdb;
select name, open_mode from v$pdbs;
alter PLUGGABLE DATABASE open;


-- TO VIEW THE USER CREATED FUNCTION OR PROCEDRUE.
SELECT * FROM USER_SOURCE
WHERE NAME LIKE 'GET_EMP';


