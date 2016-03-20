use NuggetDemoDB
GO

If Exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Employees]') And OBJECTPROPERTY(ID, N'IsUserTable') = 1)
	DROP TABLE [dbo].[Employees]
go
--Create employees table with null / not null constraints

create table [dbo].[Employees](
	EmployeeID [int] not null identity(1,1) Primary Key,
	[FirstName] [nvarchar](50) not null,
	[LastName] [nvarchar](50) not null,
	[Title] [nvarchar](100) null default ('New Hire'),
	[HireDate] [datetime] not null constraint DF_HireDate default(getdate()) check(DATEDIFF(d, getdate(), HireDate) <=0),
	--using days as an interval and saying compare the current date to the hire date and make sure it's in the past
	[VacationHours] [int] not null,
	[Salary] [decimal](19, 4) not null
	constraint U_Employee unique nonclustered (FirstName, LastName, HireDate)
) On [PRIMARY]

Go

If Exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Products]') And OBJECTPROPERTY(ID, N'IsUserTable') = 1)
	DROP TABLE [dbo].Products
go

CREATE TABLE [dbo].[Products](
	[ProductID] [int] NOT NULL identity(1,1),
	[Name] [nvarchar](255) NOT NULL unique nonclustered, --don't have to specify name of column since there is only one
	[Price] [decimal](19, 4) NOT NULL constraint CHK_Price check(price > 0),
	DiscontinuedFlag bit not null constraint DF_DiscontinuedFlag Default(0),
	constraint PK_ProductID Primary Key Clustered(ProductID ASC) -- don't need to say Clustered
) ON [PRIMARY]
--for constraints that extend over more than one column do them at the table not column level
GO

If Exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Sales]') And OBJECTPROPERTY(ID, N'IsUserTable') = 1)
	DROP TABLE [dbo].Sales
go

CREATE TABLE [dbo].[Sales](
	[SalesID] [uniqueidentifier] NOT NULL default newid(),
	[ProductID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[SaleDate] [datetime] NOT NULL constraint DF_SaleDate default(getdate()),
	constraint CHK_QuantitySaleDate check(quantity > 0 and datediff(d, getdate(), saledate) <=0),
	constraint PK_SaleID Primary Key Clustered(SalesID ASC)
	--can add WITH() to specify options such as IGNORE_DUP_KEY=[OFF/ON]
) ON [PRIMARY]

GO