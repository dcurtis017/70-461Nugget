use NuggetDemoDB;
go

--indexes on views are physically stored in db so anything the view relys on cannot change so it must be bound to the underlying tales so you can't change them
--must include schema in view name as well as tables in queries for schema binding
create view dbo.vEmployeeSalesOrders
	with schemabinding 
As
	select employees.EmployeeID, Products.ProductID, sum(price*quantity) as SaleTotal,
	SaleDate,
	COUNT_BIG(*) as RecordCount --required to make an index when aggregate functions are used
	From
		dbo.Employees join dbo.Sales on Employees.EmployeeID = Sales.EmployeeID
		join
		dbo.Products on sales.ProductID = products.ProductID
	group by employees.EmployeeID, products.ProductID, sales.SaleDate
	--need to group by everything in the select list that is not the aggregate

go

select * from dbo.vEmployeeSalesOrders;
select * from dbo.vEmployeeSalesOrders with (noexpand); 
--with (no expand) forces it to use the clustered index not underlying tables...by default sql server express uses underlying tables
--indexes speed up performance
--the query optimizer will take the index in our views into account (only in enterprise and developer edition of sql server)

create unique clustered index CICX_vEmployeesSalesOrders
	on dbo.vEmployeeSalesOrders(EmployeeID, ProductID, SaleDate);
Go

