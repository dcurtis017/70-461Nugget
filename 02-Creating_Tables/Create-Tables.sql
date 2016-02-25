
7

CREATE TABLE Employees(
	EmployeeID int NOT NULL,
	FirstName nvarchar(50) not null,
	MiddleName nvarchar(50) null,
	LastName nvarchar(75) not null,
	Title nvarchar(100) null,
	HireDate datetime not null,
	VacationHours smallint not null,
	Salary decimal(19, 4) not null
);
Go

create table Products(
	ProductID int not null,
	Name nvarchar(255) not null,
	Price decimal(19, 4) not null
);
Go

create table Sales(
	SalesID uniqueidentifier not null,
	ProductID int not null,
	EmployeeID int not null,
	Quantity smallint not null,	
	SaleDate datetime not null
);
Go
