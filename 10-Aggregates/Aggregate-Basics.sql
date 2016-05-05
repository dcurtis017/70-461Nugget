use NuggetDemoDB
go

/**
Group by
*/
select productid, sum(quantity) as TotalQuantitySold from sales
group by ProductID order by ProductID

--when using aggregate function in select clause, everything not in aggregate must be in group by
select employeeid, productid, sum(quantity) as TotalQuantitySold from sales
group by employeeid, productid 
having sum(quantity) > 2
order by employeeid, ProductID

select datepart(yyyy, SaleDAte) as SalesYear, sum(quantity) as TotalQuantitySold
from sales
group by datepart(yyyy, SaleDate)
order by datepart(yyyy, SaleDate) desc

/**
Grouping Sets -- can add totals and subtotals to data
*/
select employeeid,  sum(quantity) as TotalQuantitySold from sales
group by grouping sets ((EmployeeID), ()) 
--first group is what we want to group by after teh comma is subtotal and grand totals empty parens as last param means grand total on everything

--group by employee id, salesyear and give grand total
select datepart(yyyy, SaleDAte) as SalesYear, sum(quantity) as TotalQuantitySold
from sales
group by grouping sets ((EmployeeID, datepart(yyyy, saledate)), ())

--group by employee id, salesyear and subtotal on employeeid
select datepart(yyyy, SaleDAte) as SalesYear, sum(quantity) as TotalQuantitySold
from sales
group by grouping sets ((EmployeeID, datepart(yyyy, saledate)), (employeeid))

--group by employee id, salesyear and subtotal on employeeid and grand total
select datepart(yyyy, SaleDAte) as SalesYear, sum(quantity) as TotalQuantitySold
from sales
group by grouping sets ((EmployeeID, datepart(yyyy, saledate)), (employeeid), ())

--multiple groups and multiple aggregations
select datepart(yyyy, SaleDAte) as SalesYear,datepart(mm, saledate), sum(quantity) as TotalQuantitySold
from sales
group by grouping sets (
(EmployeeID, datepart(mm, saledate), datepart(yyyy, saledate)), 
(EmployeeID, datepart(mm, saledate)),
(employeeid),
 ()
)

--grouping set with unrelated aggregations
select employeeid, datepart(yyyy,saledate) as saleyear, sum(quantity) as sales
from sales
group by grouping sets ((employeeid), (datepart(yyyy, saledate)))