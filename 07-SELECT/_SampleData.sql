use NuggetDemoDB
go

--drop foreign key constraints
alter table sales
	drop constraint fk_employeesales, fk_productsales
go

--disable triggers
exec sp_MSforeachtable 'alter table ? disable trigger all'

/**
truncate will cause problems if you have foreign keys
*/
--empty tables/reseed auto-numbers
truncate table employees
truncate table products
truncate table sales

--add foreign key constraints
alter table sales
	add constraint FK_ProductSales foreign key (ProductID) references Products.ProductID,
	constraint FK_EmployeeSales foreign key (EmployeeID) references Employees.EmployeeID
go

--reenable triggers
exec sp_MSforeachtable 'alter table ? enable trigger all'

alter table employees
	alter column lastname nvarchar(50) null
go
--create employee records
--Insert Employees select 'Luke', NULL, 'Skywalker', 'Sales Person', '10/1/2005', 10, 50000

--create sample products
insert into products select 'LightSaber', 49.99, 0

--create 1k random sales records
declare @counter int
set @counter = 1

while @counter <=1000
	begin
		insert sales
			select
				newid(),
				(abs(checksum(newid())) % 5) + 1,
				(abs(checksum(newid())) % 3) + 1,
				(abs(checksum(newid())) % 10) + 1,
				dateadd(day, abs(checksum(newid()) % 3650), '2002-04-29')
		set @counter+=1
	end

