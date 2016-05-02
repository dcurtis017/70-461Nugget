use NuggetDemoDB
go


--basic select for all columns
select * from Employees

--basic select for specific columns
select firstname, lastname from employees

--specific column with filter
select firstname from employees where title like '%Sales%'

--inner join
select * from products p join sales s on p.ProductID = s.ProductID --could also do products as p join sales as s

--left outer join 
/**
will give everything from products and only the matches in sales
*/
select name, count(*) as numberofsales, sum(Quantity) as salesquantitytotal, sum(price*quantity) as salesgrosstotal
from products p left join sales s on p.productid = s.productid
group by name


--right outer join
--what employees have sales
select firstname +' '+lastname+'-'+title as nameandtitle, count(s.SalesID) as NumberOfSales
From Sales s right join employees e on s.EmployeeID = e.employeeid
group by firstname +' '+lastname+'-'+title
Having count(s.salesID) > 0

--Derived Tables (think of it as creating a temporary table on the fly...a query that acts as a table
select firstname+' '+lastname as employee
from (Select * from employees where title like 'Sales%') as EmployeeDetails

--derived tables with joins
select top 10 name, quantity, firstname+' '+lastname as Employee, SaleDate
from 
	(select * from sales where quantity = 10) as salesquantityof10 
		join
	Products on salesquantityof10.ProductID = Products.ProductID
		join
	Employees on salesquantityof10.EmployeeID = Employees.EmployeeID
where Products.ProductID = 5
Order by SaleDate desc

--Derived Table Query Aggregate
Select Name, count(*) as NumberOfSales, isnull(Sum(Quantity),0) as SalesQuantityTotal, isnull(sum(Price*Quantity),0)  as SalesGrossTotal
from
	Products p 
	left join 
	Sales s on p.ProductID = s.ProductID
group by Name


Select Name, NumberofSales, SalesQuantityTotal, SalesGrossTotal
from
	Products pout join
	(select s.ProductID, count(*) as NumberOfSales, Sum(Quantity) as SalesQuantityTotal, sum(Price*Quantity) as SalesGrossTotal
	from
		sales s
			join
		products p on s.ProductID = p.ProductID
	group by
		s.ProductID) pin on pout.ProductID = pin.ProductID

--Synonyms -- can help provide a layer of abstraction and eliminate the need to always type the fully qualified name (server.schema.database.object)
--cannot do alter on synonym but can do crud
create synonym AWEmployee
	for Adventureworks2014.HumanResources.Employee
go

select * from AWEmployee

drop synonym AWEmployee
go	