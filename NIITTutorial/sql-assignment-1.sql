
create database keepnote;

use keepnote;

create table user (user_id varchar(20), user_name varchar(20), user_added_date date, user_password varchar(20), user_mobile varchar(10) );

create table note(note_id varchar(20), note_title varchar(30), note_content text, note_status varchar(20), note_creation_date date);

create table reminder(reminder_id varchar(20), reminder_name varchar(20), reminder_descr text, reminder_type varchar(20), reminder_creation_date date, reminder_creator varchar(20));

create table category(category_id varchar(20), category_name varchar(20), category_descr text, category_creation_date date, category_creator varchar(20));

create table notecategory(notecategory_id varchar(20), note_id varchar(20), category_id varchar(20));


create table notereminder(notereminder_id varchar(20), note_id varchar(20), reminder_id varchar(20));

create table usernote(usernote_id varchar(20), user_id varchar(20), note_id varchar(20));




insert into user values 
	('1', 'kavita', '2017-08-03', 'kav123', '3142'),
	('2', 'gita', '2017-06-11', 'git23', '1243'),
	('3', 'savita', '2018-`11-22', 'sov123', '2134'),
	('4', 'sarita', '2019-10-09', 'sar123', '1423'),
	('5', 'babita', '2020-04-13', 'bab123', '4321');


insert into note values 
('1', 'keep going', 'never give up...learn sql', 'on going', '2017-08-27'),	
('2', 'wake up', 'wake up at 4am', 'pending', '2017-07-21'),	
('3', 'books', 'shiva triology', 'on going', '2019-01-07'),	
('4', 'travel', 'travel to shimla on bullet', 'pending', '2019-10-09'),	
('5', 'java', 'complete java tutorials', 'pending', '2017-04-05');


-- health, travel, books, lifestyle, vehicles, learning 
insert into reminder values 
	('1', 'start sql', 'start studying sql', 'learning', '2017-09-01', 'kavita'), 
	('2', 'jogg @5am', 'wake up to stay fit', 'health', '2017-08-07', 'gita'),
	('3', 'read', 'time to read shiva triology', 'books', '2019-02-19', 'savita'),
	('4', 'catch flight', 'go to shimla', 'travel', '2020-02-15', 'sarita'),
	('5', 'tutorials', 'finish java tutorials', 'learning', '2017-06-27', 'babita');

insert into category values
	('1', 'health', 'always stay fit', '2017-01-01', 'albert'),
	('2', 'travel', 'see amazing new places', '2017-02-01', 'albert'),
	('3', 'books', 'read to inherit great knowledge', '2017-01-01', 'zayaan'),
	('4', 'lifestyle', 'always live a happy lifestyle', '2017-01-11', 'albert'),
	('5', 'learning', 'learning is for lifetime', '2017-02-15', 'tony'),
	('6', 'vehicles', 'we all love super cars', '2017-02-15', 'albert');

insert into notecategory values
	('1', '1', '5'),
	('2', '2', '1'),
	('3', '3', '3'),
	('4', '4', '2'),
	('5', '5', '5');


insert into notereminder values 
	('1', '1', '1'),
	('2', '2', '2'),
	('3', '3', '3'),
	('4', '4', '4'),
	('5', '5', '5');

insert into usernote values 
	('1', '1', '1'),
	('2', '2', '2'),
	('3', '3', '3'),
	('4', '4', '4'),
	('5', '5', '5');



-- Fetching data from the database

-- fetching rows based on username and password
select user_name, user_password from user order by user_name, user_password;


-- fetching all category_name for date after  jan - 01 - 2018
select category_name from category where category_creation_date > '2017-01-01';


-- fetching all note_id from usernote, for a given user
select un.note_id 
from usernote as un
join 
(select user_name, user_id from user) as u
on  u.user_id = un.user_id 
where u.user_name = 'sarita';



-- fetching all notes for a given user
select n.note_title
from note as n
join usernote as un on un.note_id = n.note_id 
join user as u on u.user_id = un.user_id
where u.user_name = 'sarita'; 



-- fetching all notes for a given category
select n.note_id as "note id", c.category_id as "cat id", c.category_name, count(nc.note_id) as "notes count", count(c.category_id) as "category count"
from note as n
join notecategory as nc on nc.note_id = n.note_id 
join category as c on nc.category_id = c.category_id
where c.category_name = 'travel'
group by nc.note_id, c.category_id;


-- fetching reminder details for a given note id
select r.reminder_descr
from reminder as r
join notereminder as nr on nr.reminder_id = r.reminder_id 
join note as n on n.note_id = nr.note_id
where n.note_id = '3';

-- fetching reminder details for a given reminder id
select reminder_descr
from reminder
where reminder_id = '4';



-- delete queries
delete from 'usernote' where note_id = '3';
delete from 'note' where note_id = '3';

delete from 'notecategory' where note_id = '3';



-- update the tables
-- modify the note content for a given note_id 
update note 
	set note_content = "wake up at 4.30am"
	where note_id = '2';

-- updating a note column for id = 3
update 
	note
	set note_content = "Sckion of Ikshuvaku"
	where note_id = '3';


--  Triggers
DELIMITER $$

-- TO DELETE ALL NOTE DEPENDENCIES
create trigger delete_note_dependencies
before delete
on note for each row
begin
	delete from notereminder  where notereminder.note_id = note.note_id;
	delete from notecategory where notecategory.note_id = note.note_id;	
end
$$

-- TO DELETE ALL USER DEPENDENCIES
create trigger delete_user_dependencies
before delete
on user for each row
begin
	delete from usernote where usernote.user_id = user.user_id;
end	
$$

DELIMITER ;



-- display part
show tables;
show database;
desc users;

select *from users;
select * from category;
