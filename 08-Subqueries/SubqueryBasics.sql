use NuggetDemoDB
go

--subquery in column list
select Name, (select count(*) from sales where productID = p.productid) as SaleCount --correlated subquery...references value in outside table
from Products p

--subquery in where clause using in
select * from sales where employeeID in (select EmployeeID from employees where title like 'Sales%')

--Exists/Not Exists
use AdventureWorks2014
go

--Exists better on performance than IN exists works on a true false value in goes through the entire list
select p.FirstName, p.LastName, e.JobTitle
From Person.Person p join HumanResources.Employee e on e.BusinessEntityID = p.BusinessEntityID
where exists (
	select edh.departmentID --don't actually need this can use 1 instead exist uses true/false
	from 
		HumanResources.Department d join HumanResources.EmployeeDepartmentHistory as edh on 
		d.DepartmentID = edh.DepartmentID
	where
		e.BusinessEntityID = edh.BusinessEntityID and d.Name Like 'Research%'
	)

---exist/not exist get flattened into joins
select p.FirstName, p.LastName, e.JobTitle
From Person.Person p join HumanResources.Employee e on e.BusinessEntityID = p.BusinessEntityID
where not exists (
	select 1
	from 
		HumanResources.Department d join HumanResources.EmployeeDepartmentHistory as edh on 
		d.DepartmentID = edh.DepartmentID
	where
		e.BusinessEntityID = edh.BusinessEntityID and d.Name Like 'Research%'
	)