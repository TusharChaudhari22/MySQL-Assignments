#SET-2

#Inserted employee table from ConsolidatedTables.
select * from employee;

#Q1) select all employees in department 10 whose salary is greater than 3000. [table: employee]

select * from employee where deptno=10 and salary > 3000;

#=====================================================================================================

#Inserted student table from ConsolidatedTables.
select * from students;

/*
Q2) The grading of students based on the marks they have obtained is done as follows:

	40 to 50 -> Second Class
	50 to 60 -> First Class
	60 to 80 -> First Class
	80 to 100 -> Distinctions

a. How many students have graduated with first class?
b. How many students have obtained distinction? [table: students]
*/

alter table students add column grade varchar(15);

desc students;

update students set grade = 'Second Class' where marks between 0 and 50;
update students set grade = 'First Class' where marks between 50 and 60;
update students set grade = 'First Class' where marks between 60 and 80;
update students set grade = 'Distinctions' where marks between 80 and 100;

#a) How many students have graduated with first class?
select count(id) from students where grade = 'first class'; #12 students

#b) How many students have obtained distinction? 
select count(id) from students where grade = 'distinctions'; #11 students

#=====================================================================================================

#Inserted station table from ConsolidatedTables.
select * from station;

#Q3) Get a list of city names from station with even ID numbers only.
	# Exclude duplicates from your answer.[table: station]

select distinct city from station where id%2 = 0;

#=====================================================================================================

/*
Q4) Find the difference between the total number of city entries in the table and the number of distinct city entries in the table.
	In other words, if N is the number of city entries in station, and N1 is the number of distinct city names in station,
    write a query to find the value of N-N1 from station.
	[table: station]
*/

select count(city), count(distinct city), (count(city) - count(distinct city)) as "N-N1" from station;

#=====================================================================================================

#Inserted city table from ConsolidatedTables.
select * from city;

#Q5) Answer the following

#a. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. 
	#Your result cannot contain duplicates. [Hint: Use RIGHT() / LEFT() methods ]

select distinct city from station where left(city, 1) in ('a','e','i','o','u');

#b. Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters.
	#Your result cannot contain duplicates.
    
select distinct city from station where (left(city, 1) in ('a','e','i','o','u')) and (right(city, 1) in ('a','e','i','o','u'));

#c. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.

select distinct city from station where left(city, 1) not in ('a','e','i','o','u');

#d. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels.
	#Your result cannot contain duplicates. [table: station]
    
select distinct city from station where (left(city, 1) not in ('a','e','i','o','u')) and (right(city, 1) not in ('a','e','i','o','u'));

#=====================================================================================================

#Q6) Write a query that prints a list of employee names having a salary greater than $2000 per month who have been employed 
	#for less than 36 months. Sort your result by descending order of salary. [table: emp]
    
select * from emp;

select concat(first_name,' ',last_name) as "employee_name", hire_date, salary from emp where (hire_date > (select date_sub(max(hire_date), interval '36' month) from emp)) and (salary > 2000) order by salary desc;

#=====================================================================================================

#Inserted station table from ConsolidatedTables.
select * from employee;

#Q7. How much money does the company spend every month on salaries for each department? [table: employee]

select deptno, sum(salary) as total_salary from employee group by deptno;

#=====================================================================================================

#Q8. How many cities in the CITY table have a Population larger than 100000. [table: city]

select name from city where population > 100000; #city name

select count(name) from city where population > 100000;#city count

#=====================================================================================================

#Q9. What is the total population of California? [table: city]

select sum(population) from city where district = 'California'; #population=339002

#=====================================================================================================

#Q10. What is the average population of the districts in each country? [table: city]

select countrycode, avg(population) as avg_population from city group by countrycode; 

#=====================================================================================================

#Inserted orders and customers table from ConsolidatedTables.

select * from orders;

select * from customers;

#Q11. Find the ordernumber, status, customernumber, customername and comments for all orders that are ‘Disputed=  [table: orders, customers]

select o.ordernumber, o.status, o.customerNumber, c.customername, o.comments from orders as o inner join customers as c on (o.customerNumber = c.customerNumber)
where status='disputed';

#=====================================================================================================
