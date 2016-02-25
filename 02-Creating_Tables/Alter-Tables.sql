use NuggetDemoDB;
Go

alter table Employees
	Add
		ActiveFlag bit not null,
		ModifiedDate datetime not null;

Alter table Products
	Alter column Price money;


Exec sp_rename 'Sales', 'SalesOrder';
