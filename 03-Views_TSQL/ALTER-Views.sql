use NuggetDemoDB;
Go

alter view vEmployeesWithSales
As
	Select distinct Employees.EmployeeID, FirstName, LastName 
	from Employees inner join 
	Sales on Employees.EmployeeID = Sales.EmployeeID;
Go

drop view vEmployees;
go

sp_rename 'vAllEmployees', 'vEmployees';
Go

Insert vEmployees select 3, 'Garth', Null, 'Schulte', 'Trainer', '1/1/2010', 80, 100000.00;
Go
