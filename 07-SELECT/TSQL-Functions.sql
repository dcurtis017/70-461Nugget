use NuggetDemoDB
go

--case (equality expression)
select firstname, lastname,
	case Gender	
		when 'F' then 'Female'
		when 'M' then 'Male'
		else 'Unknown'
	end as GenderDescription,
	MaritalDescription = case MaritalStatus
		when 'S' then 'Single'
		when 'M' then 'Married'
		else 'Uknown'
	end
from
	AdventureWorks2014.HumanResources.Employee e
		join 
	AdventureWorks2014.Person.Person p on e.BusinessEntityID = p.BusinessEntityID

--case (searched expression using range)
select
	productid, name, price,
	case	
		when Price < 100 then 'Affordable'
		when Price >= 100 then 'How much?'
		when Price >=1000 then 'Galactic robbery'
	end as CustomerResponse
from Products

--case (in order by)
select * from Products
order by 
	case DiscontinuedFlag when 0 then Productid end desc, --when discotinued flag is 0 order by product id
	case DiscontinuedFlag when 1 then ProductID end desc

--case (in where -- lets you make decision in your where clase when equality is not enough)
select * from products
where 1 = case when price < 100 then 1 else 0 end -- when 1==1 return the row when 1 == 0 don't retrn the row ... only show when price < 100

--coaslece (x params, ansi sql standard)
--null+anything is null, coalesce will return the first nonnull expression among it's arguments
select employeeid, firstname,middlename, firstname+' '+lastname as fln,
coalesce(firstname+' '+middlename+' '+lastname, firstname+' '+lastname, firstname, lastname, 'No Name') as fullname
from Employees

--is null (2 params, t-sql specific)
select employeeid, firstname, isnull(middlename, 'N/A') as middlename, lastname
from employees

--ranking (employees by salary)
--dense_rank won't skip the number when ties happen...try out
select employeeid, title, salary, rank() over (order by salary desc) as SalaryRank, -- order by what we're ranking on
row_number() over (order by salary desc) as RowNum --Returns the sequential number of a row within a partition of a result set, starting at 1 for the first row in each partition.
from employees

--ranking (top sales by employee, products
select s.employeeid, p.productid, sum(quantity*price) as TotalProductSales,
rank() over (partition by s.employeeid order by sum(quanity*product) desc) --group ranks by employees so 1-x for employee1, 1-x for employee2...instead of 1-x for all employees
from sales s
join products p on s.ProductID = p.ProductID
group by s.employeeid, p.ProductID