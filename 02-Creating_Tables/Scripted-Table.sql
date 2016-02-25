USE [NuggetDemoDB]
GO

/****** Object:  Table [dbo].[Employees]    Script Date: 2/23/2016 10:49:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](75) NOT NULL,
	[Title] [nvarchar](100) NULL,
	[HireDate] [datetime] NOT NULL,
	[VacationHours] [smallint] NOT NULL,
	[Salary] [decimal](19, 4) NOT NULL
) ON [PRIMARY]

GO


