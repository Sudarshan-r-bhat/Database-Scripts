create database Niit;
 use Niit;
 show databases;
 show tables;

create table customer(custno int primary key, 
 custname varchar(23), city varchar(23));
insert into customer values(1, 'stackroute', 'bangalore');
insert into customer values(2, 'niit', 'chennai');
insert into customer values(2, 'shankar', 'bangalore');

desc customer;

-- Modifying column-type in customer table
alter table customer modify custname varchar(23);

-- logical operator | and, or

-- display part
select * from customer;






