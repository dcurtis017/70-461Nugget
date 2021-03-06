use NuggetDemoDB
GO

If Exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Employees]') And OBJECTPROPERTY(ID, N'IsUserTable') = 1)
	DROP TABLE [dbo].[Employees]
go
--Create employees table with null / not null constraints

create table [dbo].[Employees](
	EmployeeID [int] not null,
	[FirstName] [nvarchar](50) not null,
	[LastName] [nvarchar](50) not null,
	[Title] [nvarchar](100) null,
	[HireDate] [datetime] not null,
	[VacationHours] [int] not null,
	[Salary] [decimal](19, 4) not null
) On [PRIMARY]

Go

If Exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Products]') And OBJECTPROPERTY(ID, N'IsUserTable') = 1)
	DROP TABLE [dbo].Products
go

CREATE TABLE [dbo].[Products](
	[ProductID] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Price] [decimal](19, 4) NOT NULL,
	DiscontinuedFlag bit not null
) ON [PRIMARY]

GO

If Exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Sales]') And OBJECTPROPERTY(ID, N'IsUserTable') = 1)
	DROP TABLE [dbo].Sales
go

CREATE TABLE [dbo].[Sales](
	[SalesID] [uniqueidentifier] NOT NULL,
	[ProductID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[SaleDate] [datetime] NOT NULL
) ON [PRIMARY]

GO