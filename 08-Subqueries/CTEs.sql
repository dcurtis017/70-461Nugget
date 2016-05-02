use NuggetDemoDB
go

/*
alter table Employees
	Add	ManagerID int  null*/

--basic CTE
--think of it as a named subquery..think of it as a named derived table
with SalesByYearCTE (EmployeeID, SaleID, SalesYear)
As
	(select EmployeeID, SalesID, Year(SaleDate) as SalesYear
		from Sales
	)

select EmployeeID, count(SaleID) as TotalSales, SalesYear
from SalesByYearCTE
where SalesYear >= Year(DATEADD(yyyy, -3, getDate()))
group by SalesYear, EmployeeID
order by EmployeeID, SalesYear;

--Multiple CTEs
with EmployeeProductSales (EmployeeID, ProductID, TotalSales) as
(
	select e.EmployeeID, p.productID, sum(price*quantity) as totalSales
	from employees e join sales s on e.employeeid = s.EmployeeID join Products p on s.ProductID = p.ProductID
	group by p.ProductID, e.EmployeeID
),
ProductInfo (ProductID, PRoductName, Price) as
(
	select productID, name, price 
	from products
),
employeeinfo (employeeid, employeename) as
(
	select employeeid, coalesce(firstname+' '+middlename+' '+lastname,
		firstname+' '+lastname, firstname, lastname) as employeename
	from employees
)

select [pi].productName, ei.employeeName, eps.totalsales
from EmployeeProductSales eps join ProductInfo [pi] on [pi].ProductID = eps.ProductID
	join employeeinfo ei on ei.employeeid = eps.EmployeeID
order by ProductName, TotalSales DESC, EmployeeName

--self referencing recursive query with cte
--the cte references itself (joins itself...that's recurssion)
with ManagerEmployeesCTE(Name, Title, EmployeeID, EmployeeLevel, Sort)
As (
	--anchor result set..first set
	select cast(coalesce(e.FirstName+' '+e.lastName, FirstName) as nvarchar(255)) as Name,
	e.title, e.employeeID, 1 as EmployeeLevel, 
	cast(coalesce(e.FirstName+' '+e.lastName, FirstName) as nvarchar(255)) as SortOrder
	from Employees e
	where e.ManagerID is null
	UNION All

	--Recursive result set..compared to anchor set over and over again
	select cast(replicate('|    ', EmployeeLevel) + e.firstname+' '+e.lastName as nvarchar(255)) as Name,
	e.title, e.employeeid, employeelevel+1 as Employeelevel,--employee level will track how deep in the recursion we are
	cast(rtrim(sort)+'|    '+firstname+' '+lastname as nvarchar(255)) as sortOrder
	from employees e join ManagerEmployeesCTE as d on e.managerid = d.EmployeeID
)

select employeeid, name, title, employeelevel from ManagerEmployeesCTE order by sort
--replicate replicates the provided character x number of times replicate('+', 3) will get +++