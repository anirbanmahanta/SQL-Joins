create database SQL_Joins;

use sql_joins;

create table Customers (
CustomerID int primary key,
CustomerName varchar (50) not null,
City varchar (50)
);

insert into customers (CustomerID, CustomerName, City)
values
(1, "John Smith", "New York"),
(2, "Mary Johnson", "Chicago"),
(3, "Peter Adams", "Los Angeles"),
(4, "Nancy Miller", "Houston"),
(5, "Robert White", "Miami");

select * from customers;

create table Orders (
OrderID int primary key,
CustomerID int not null,
OrderDate date,
Amount int
);

insert into Orders
values
(101, 1, "2024-10-01", 250),
(102, 2, "2024-10-05", 300),
(103, 1, "2024-10-07", 150),
(104, 3, "2024-10-10", 450),
(105, 6, "2024-10-12", 400);

select * from orders;

create table Payments (
PaymentID int primary key,
CustomerID int not null,
PaymentDate date,
Amount int
);

alter table Payments
change column PaymentID PaymentID varchar (4) ;

insert into Payments
values
("P001", 1, "2024-10-02" ,250),
("P002", 2, "2024-10-06" ,300),
("P003", 3, "2024-10-11" ,450),
("P004", 4, "2024-10-15" ,200);

select * from Payments;

create table Employees (
EmployeeID int primary key,
EmployeeName varchar (50),
ManagerID int
);

insert into Employees
values
(1, "Alex Green" , null),
(2, "Brian Lee", 1),
(3, "Carol Ray", 1),
(4, "David Kim", 2),
(5, "Eva Smith", 2);

select * from Employees;

## Question 1. Retrieve all customers who have placed at least one order.

select distinct c.CustomerID, c.CustomerName, c.City
from Customers c
inner join Orders o
on c.customerid = o.customerid;



## Question 2. Retrieve all customers and their orders, including customers who have not placed any orders.

select c.CustomerID, c.CustomerName, c.city, o.OrderID, o.OrderDate, o.Amount
from Customers c
left join Orders o
on c.CustomerID = o.CustomerID;


## Question 3. Retrieve all orders and their corresponding customers, including orders placed by unknown customers

select o.OrderID,o.OrderDate,o.Amount, c.CustomerID,c.CustomerName,c.City
from orders o
left join customers c
on o.CustomerID = c.CustomerID;


## Question 4. Display all customers and orders, whether matched or not.

select c.CustomerID, c.CustomerName, c.City,
o.OrderID, o.Amount, o.OrderDate
from Customers c
left join Orders o
on c.CustomerID = o.CustomerID

union

select c.CustomerID, c.CustomerName, c.City,
o.OrderID, o.Amount, o.OrderDate
from Customers c
right join Orders o
on c.CustomerID = o.CustomerID;


## Question 5. Find customers who have not placed any orders.

select c.CustomerID, c.CustomerName, c.City,
o.OrderID, o.Amount, o.OrderDate
from Customers c
left join Orders o
on c.CustomerID = o.CustomerID
where o.OrderId is Null;


## Question 6. Retrieve customers who made payments but did not place any orders.

select c.CustomerID, c.CustomerName
from Customers c
join Payments p 
on c.CustomerID = p.CustomerID
left join orders o
on c.CustomerID = o.CustomerID
where orderid is null;


## Question 7. Generate a list of all possible combinations between Customers and Orders.


select c.CustomerID, c.CustomerName,
       o.OrderID, o.Amount
from Customers c
cross join Orders o;


## Question 8. Show all customers along with order and payment amounts in one table.


select c.CustomerID, c.CustomerName,
o.Amount as OrderAmount,
p.Amount as PaymentAmount
from Customers c
left join Orders o
  on c.CustomerID = o.CustomerID
left join Payments p
  on c.CustomerID = p.CustomerID;
  
  
  ## Question 9. Retrieve all customers who have both placed orders and made payments.
  
select distinct c.CustomerID, c.CustomerName
from Customers c
inner join Payments p 
on c.CustomerID = p.CustomerID
inner join orders o
on c.CustomerID = o.CustomerID;