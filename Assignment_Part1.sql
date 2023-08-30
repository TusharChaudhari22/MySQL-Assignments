# SET-1

#Q1) Create database called 'assignment'.
create database assignment;

use assignment;

#=====================================================================================================

#Q2) Create table called 'countries' with the columns-name, poplulation, caplital.

create table countries (name varchar(30), population int, capital varchar(30));

desc countries;

#a)Insert the following data into the table.

insert into countries values ('China', 1382, 'Beijing');
insert into countries values ('India', 1326, 'Delhi');
insert into countries values ('United States', 324, 'Washington D.C.');
insert into countries values ('Indonesia', 260, 'Jakarta');
insert into countries values ('Brazil', 209, 'Brasilia');
insert into countries values ('Pakistan', 193, 'Islamabad');
insert into countries values ('Nigeria', 187, 'Abuja');
insert into countries values ('Bangladesh', 163, 'Dhaka');
insert into countries values ('Russia', 143, 'Moscow');
insert into countries values ('Mexico', 128, 'Mexico City');
insert into countries values ('Japan', 126, 'Tokyo');
insert into countries values ('Philippines', 102, 'Manila');
insert into countries values ('Ethiopia', 101, 'Addis Ababa');
insert into countries values ('Vietnam', 94, 'Hanoi');
insert into countries values ('Egypt', 93, 'Cairo');
insert into countries values ('Germany', 81, 'Berlin');
insert into countries values ('Iran', 80, 'Tehran');
insert into countries values ('Turkey', 79, 'Ankara');
insert into countries values ('Congo', 79, 'Kinshasa');
insert into countries values ('France', 64, 'Paris');
insert into countries values ('United Kingdom', 65, 'London');
insert into countries values ('Italy', 60, 'Rome');
insert into countries values ('South Africa', 55, 'Pretoria');
insert into countries values ('Myanmar', 54, 'Naypyidaw');
select * from countries;

#b) Add a couple of countries of your choice.

insert into countries values ('Mongolia', 52, 'Ulaanbaatar');
insert into countries values ('Sri Lanka', 50, 'Colombo');
insert into countries values ('Afghanistan', 48, 'Kabul');
insert into countries values ('Spain', 46, 'Madrid');
insert into countries values ('Portugal', 44, 'Lisbon');
insert into countries values ('Netherlands', 42, 'Amsterdam');
select * from countries;

#c) Change ‘Delhi' to ‘New Delhi'

set sql_safe_updates=0;
update countries set capital='New Delhi' where capital='Delhi';
select * from countries;

#=====================================================================================================

#Q3) Rename the table countries to big_countries.

rename table countries to big_countries;

show tables;

#=====================================================================================================

#Q4) Create tables

	#b) Suppliers
    
create table Suppliers
(
supplier_id varchar(20) primary key,
supplier_name varchar(30),
location varchar(20) not null);

	#a) Product
    
create table Product 
(
product_id varchar(20) primary key,
product_name varchar(30) not null unique,
description varchar(30),
supplier_id varchar(20),
foreign key (supplier_id) references suppliers(supplier_id) on delete set null on update cascade);

	#c) Stock
    
create table Stock
(
id int primary key auto_increment,
product_id varchar(20),
balance_stock int,
foreign key (product_id) references product(product_id) on delete set null on update cascade);

#=====================================================================================================

#Q5) Enter some records into the three tables.

# for suppliers
insert into Suppliers values ('S01','supplier_01','pune');
insert into Suppliers values ('S02','supplier_02','mumbai');
insert into Suppliers values ('S03','supplier_03','nagpur');
insert into Suppliers values ('S04','supplier_04','thane');
select * from suppliers;

#for product
insert into product values ('P01','product01',null,'S02');
insert into product values ('P02','product02',null,'S03');
insert into product values ('P03','product03',null,'S02');
insert into product values ('P04','product04',null,'S01');
select * from product;

#for Stock
insert into stock(product_id,balance_stock) values ('P01',3);
insert into stock(product_id,balance_stock) values ('P02',6);
insert into stock(product_id,balance_stock) values ('P01',4);
insert into stock(product_id,balance_stock) values ('P04',7);
select * from stock;
show tables;

#=====================================================================================================

#Q6) Modify the supplier table to make supplier name unique and not null.

alter table suppliers modify supplier_name varchar(30) unique not null;

desc suppliers;

#=====================================================================================================

#Added emp table from Consolidated Tables.

desc emp;
select * from emp;

#Q7) Modify the emp table as follows:

	#a) Add a column called deptno
    
    alter table emp add deptno int;
    select * from emp;
    
    #b) Set the value of deptno in the following order
		# deptno = 20 where emp_id is divisible by 2
		# deptno = 30 where emp_id is divisible by 3
		# deptno = 40 where emp_id is divisible by 4
		# deptno = 50 where emp_id is divisible by 5
		# deptno = 10 for the remaining records.
    
    alter table emp rename column emp_no to emp_id;
    
    update emp set deptno=20 where emp_id%2 = 0;
    update emp set deptno=30 where emp_id%3 = 0;
    update emp set deptno=40 where emp_id%4 = 0;
    update emp set deptno=50 where emp_id%5 = 0;
    update emp set deptno=10 where deptno is null;
    select * from emp;

#=====================================================================================================
    
#Q8) Create a unique index on the emp_id column.

create unique index uidx on emp(emp_id);

show indexes from emp;

#=====================================================================================================

#Q9) Create a view called emp_sal on the emp table by selecting the following fields in the order of highest salary to the lowest salary.
	#emp_no, first_name, last_name, salary

create view emp_sal as
select emp_id as emp_no, first_name, last_name, salary from emp order  by salary desc;

select * from emp_sal;

#=====================================================================================================