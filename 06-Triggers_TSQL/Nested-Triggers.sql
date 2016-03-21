use NuggetDemoDB
go
--can turn nesting off or set the number of nested levels
--a recurssive trigger calls itself over and over again
--recursive triggers are disabled by default
--nested triggers are triggers that fire other triggers example an update calls our trigger which calls another trigger
--avoid circular calls...the max number of nesting levels is 32 
--nested triggers are on by default

--right click on db -> properties -> options to turn nested or recursive triggers off/on
--you can also use sp_configure
--you can disable/enable with sp_configure at the start/end of your trigger
If Exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[EmployeeAuditTrail]') And OBJECTPROPERTY(ID, N'IsUserTable') = 1)
	DROP TABLE [dbo].EmployeeAuditTrail
go
create table dbo.EmployeeAuditTrail(
	EmployeeAuditID int identity(1,1) not null primary key clustered,
	EmployeeID int not null,
	FirstName nvarchar(50) not null,
	MiddleName nvarchar(50) not null,
	LastName nvarchar(50) not null,
	Title nvarchar(100) not null,
	HireDate datetime null,
	VacationHours int null,
	Salary decimal(19,4) null,
	ModifiedDate datetime null,
	ModifiedBy nvarchar(255) null
) on [primary]
go

if object_id('udEmployeeAudit', 'TR') is not null
	drop trigger udEmployeeAudit
go

create trigger dbo.udEmployeeAudit on Employees
	for update, delete
as
	insert EmployeeAuditTrail
		select
			e.EmployeeID, d.FirstName, d.MiddleName, d.LastName,
			d.Title, d.HireDate, d.VacationHours, d.Salary,
			getdate(), system_user
		from
			Employees e
				join
			deleted d on e.EmployeeID = d.EmployeeID
go


if object_id('uRecalculateVacationHours', 'TR') is not null
	drop trigger uRecalculateVacationHours
go

create trigger uRecalculateVacationHours on Employees
	for update
as
	if update(HireDate) --tests to see if the hiredate column was updated
		begin
			declare @RecalcFlag bit
			select @RecalcFlag = IIF(YEAR(HireDate) = year(getdate()), 1, 0) from inserted--if the current year is the year we're in now set the recalc flag to true
			--iif Returns one of two values, depending on whether the Boolean expression evaluates to true or false in SQL Server.

			if(@RecalcFlag = 1)
				update Employees set vacationHOurs +=40 from Employees e join inserted i on e.EmployeeID = i.EmployeeID
		end
go

--the trigger above will cause an update will which will cause an audit to be done

select year(getdate())