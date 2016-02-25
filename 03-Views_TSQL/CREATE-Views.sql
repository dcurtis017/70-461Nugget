use NuggetDemoDB;
Go

create view vEmployeesWithSales
As 
	Select distinct Employees.* 
	from Employees inner join 
	Sales on Employees.EmployeeID = Sales.EmployeeID;
Go

create view vTop10ProductSalesByQuantity
As
	select top 10 --will only return first 10 records from query
		Sales.ProductID,
		Name as ProductName,
		sum(Sales.Quantity) as TotalQuantity
	from
		Sales Join
		Products on Sales.ProductID = Products.ProductID
	group by Sales.ProductID, Name
	order by sum(Sales.Quantity) Desc;
Go
select * from vEmployeesWithSales;
Go

drop view vAllEmployees;
Go

create view vAllEmployees
As 
	Select *
	from Employees
	where Title = 'Sales Person'

	With Check option; --will check that any data modification against our view follows the where clause
Go