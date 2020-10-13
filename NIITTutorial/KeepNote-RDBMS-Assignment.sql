create database KeepNote;
use KeepNote;
show tables;

-- note, category, reminder, user, usernote, notereminder, notecategory

create table user ( user_id varchar(10), user_name varchar(25), user_added_date date, user_password varchar(15), user_mobile varchar(10));

create table note ( note_id varchar(10), note_title varchar(25), note_content text, note_status varchar(10), note_creation_date date);

create table category (category_id varchar(10), category_name varchar(15), category_descr text, category_creation_date date, category_creator varchar(20));

create table reminder (reminder_id varchar(10), reminder_name varchar(15), reminder_descr text, reminder_type varchar(15), reminder_creation_date date, reminder_creator varchar(20));

create table notecategory (notecategory_id varchar(10), note_id varchar(10), category_id varchar(10));

create table notereminder (notereminder_id varchar(10), note_id varchar(10), reminder_id varchar(10));

create table usernote (usernote_id varchar(10), user_id varchar(10), note_id varchar(10));


--  insert statements

insert into user 
values
(1, 'samantha', '2017-08-23', 'sam123', 1234),
(2, 'ahaana', '2018-05-03', 'aha123', 1116),
(3, 'bob', '2020-03-17', 'bob123', 1956),
(4, 'dominic', '2020-12-11', 'dom123', 1176),
(5, 'zoya', '2019-06-10', 'zoy123', 1436);

-- table note_id varchar(10), note_title varchar(25), note_content text, note_status varchar(10), note_creation_date date);

insert into note
values
(1, 'start fresh', 'wake up early and exercise','pending', '2017-08-25'),
(2, 'new year resolution', 'work with determination to get a passionate job','on going', '2018-05-03'),
(3, 'cars', 'Aston martin is an astonising car company','done', '2020-05-17'),
(4, 'stay fit', 'run 5kms a day','on going', '2020-12-19'),
(5, 'learn java', 'code to solve problems','done', '2019-12-08');

-- category_id varchar(10), category_name varchar(15), category_descr text, category_creation_date date, category_creator varchar(20));
insert into category
values
(1, 'personal', 'put up a personal goal', '2017-01-01', 'arthur'),
(2, 'shopping', 'pen down you\'re shopping list', '2017-01-01', 'arthur'),
(3, 'lifestyle', 'plan you\'re life', '2017-01-01', 'arthur'),
(4, 'books', 'bookmark you\'re fav', '2017-01-01', 'arthur'),
(5, 'travel&vehicles', 'travel diary or describe you\'re fav vehicle', '2017-01-01', 'arthur');

-- reminder_id varchar(10), reminder_name varchar(15), reminder_descr text, reminder_type varchar(15), reminder_creation_date date, reminder_creator varchar(20)); 
 
insert into reminder
values
(1, 'wake up', 'get work done', 'needful', '2017-08-25', 'samanta'),
(2, 'exercise', 'stay fit', 'needful', '2018-05-04', 'bob'),
(3, 'coding contest', 'win the GSoC', 'most important', '2019-12-08', 'ahaana'),
(4, 'the \'nagas\'', 'purchase on the release date', 'important', '2020-12-19', 'zoya'),
(5, 'travel rome', 'book tickets', 'important', '2020-05-17', 'dominic');

-- notecategory (notecategory_id varchar(10), note_id varchar(10), category_id varchar(10));


-- notecategory (notecategory_id varchar(10), note_id varchar(10), category_id varchar(10));


--  usernote (usernote_id varchar(10), user_id varchar(10), note_id varchar(10));



-- queries to fetch appropriate data 




-- triggers
 








-- display part
describe usernote;
select * from user;
select * from note;
