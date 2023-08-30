#SET-3

/*
Q1. Write a stored procedure that accepts the month and year as inputs and prints the ordernumber, orderdate and status
 of the orders placed in that month. 
*/

select * from orders;

call order_status(2004, 05);

/* stored procedure
CREATE DEFINER=`root`@`localhost` PROCEDURE `order_status`(in year_ipt int, month_ipt int)
BEGIN
select ordernumber, orderdate, status from orders where (year(orderdate) = year_ipt) and (month(orderdate) = month_ipt);
END
*/

#=====================================================================================================

#Inserted payments table from ConsolidatedTables.

select * from payments;

/*
Q2. 
a. Write function that takes the customernumber as input and returns the purchase_status based on the following criteria. 
[table:Payments]
if the total purchase amount for the customer is < 25000 status = Silver, amount between 25000 and 50000, status = Gold
if amount > 50000 Platinum
*/

call assignment.purchase_status(114);

/* stored procedure
CREATE DEFINER=`root`@`localhost` PROCEDURE `purchase_status`(in customer_no int)
BEGIN
declare amt float;
declare checkno varchar(15);
declare mycur cursor for select amount, checkNumber from payments where customerNumber = customer_no;
declare exit handler for not found
select "No further records" as status;
open mycur;
myloop:loop
fetch mycur into amt, checkno;
if amt < 25000 then
select checkno, "Silver" as purchase_status;
elseif amt between 25000 and 50000 then
select checkno, "Gold" as purchase_status;
elseif amt > 50000 then
select checkno, "Platinum" as purchase_status;
end if;
end loop;
close mycur;
END
*/

#b. Write a query that displays customerNumber, customername and purchase_status from customers table.

select * from customers;

select customerNumber, customerName,
case
when creditLimit < 25000 then "Silver"
when creditLimit between 25000 and 50000 then "Gold"
when creditLimit > 50000 then "Platinum"
end as purchase_status from customers;

#=====================================================================================================

#Inserted movies and rentals table from ConsolidatedTables.

select * from movies;

select * from rentals;

#Q3. Replicate the functionality of 'on delete cascade' and 'on update cascade' using triggers on movies and rentals tables.

update movies set id=15 where id=10;
update movies set id=12 where id=1;
delete from movies where id=8;
delete from movies where id=2;
select id from movies;

/* trigger - after delete - on delete cascade implimentation
CREATE DEFINER=`root`@`localhost` TRIGGER `movies_AFTER_DELETE` AFTER DELETE ON `movies` FOR EACH ROW BEGIN
delete from rentals where movieid=old.id;
END
*/

/* trigger - after update - on update cascade implimentation
CREATE DEFINER=`root`@`localhost` TRIGGER `movies_AFTER_UPDATE` AFTER UPDATE ON `movies` FOR EACH ROW BEGIN
update rentals set movieid=new.id where movieid=old.id;
END
*/

#=====================================================================================================

#Q4. Select the first name of the employee who gets the third highest salary. [table: employee]

select * from employee;

select fname from employee order by salary desc limit 2,1; 

#=====================================================================================================

#Q5. Assign a rank to each employee  based on their salary. The person having the highest salary has rank 1.
# [table: employee]

select fname, salary, rank() over(order by salary desc) as rank_value from employee;

#=====================================================================================================
