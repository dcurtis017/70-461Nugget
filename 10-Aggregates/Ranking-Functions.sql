use NuggetDemoDB
go

--ranking
select employeeid, productid,
sum(quantity) as totalproductsales,
rank() over (order by sum(quantity) desc) as quantityrank,
dense_rank() over (order by sum(quantity) desc) as quantitydesnserank,
ntile(4) over (order by sum(quantity) desc) as quantityquartile,
row_number() over (order by sum(quantity) desc) as rownumber
from 
	sales s 
group by
	employeeid,productid

select employeeid, p.productid,
sum(quantity) as totalproductsales,
rank() over (order by sum(quantity) desc) as quantityrank,
dense_rank() over (order by sum(quantity) desc) as quantitydesnserank,
ntile(4) over (order by sum(quantity) desc) as quantityquartile,
row_number() over (order by sum(quantity) desc) as rownumber
from 
	sales s join products p on p.productid = s.productid
group by
	employeeid, p.productid

--ranking across a group using partition
--allow ranking based on a group
--partition by will work for ntile and row_number as well
select employeeid, productid,
sum(quantity) as totalproductsales,
rank() over (partition by employeeid order by sum(quantity) desc) as quantityrank, --will only be run at the employee level..should show each employees top product
dense_rank() over (partition by employeeid order by sum(quantity) desc) as quantitydesnserank,
ntile(4) over (order by sum(quantity) desc) as quantityquartile,
row_number() over (order by sum(quantity) desc) as rownumber
from sales
group by EmployeeID, ProductID

--first value/last value
select name, price, first_value(name) over (order by price) as cheapest
from products

select name, price, last_value(name) over (order by price) as cheapest
from products

--lag to compare previous years data with current year's data...allows us to avoid self joining
select productid,
year(saledate), sum(quantity), 
lag(sum(quantity), 1, 0) over (order by year(saledate))
--what to compare against, how many rows back, default value if null
from sales where productid = 1
group by productid

--opposite of lag
select productid,
year(saledate), sum(quantity), 
lead(sum(quantity), 1, 0) over (order by year(saledate))
--what to compare against, how many rows back, default value if null
from sales where productid = 1
group by productid

--cume_dist / percent_rank to show distribution and rank by salary
select coalesce(firstname+' '+lastnaem, firstname, lastname) as name,
title, salary,
cume_dist() over (order by salary) as cumedist,--the percent of values less than or equal to the current value
cume_dist() over (partition by title order by salary) as cumedist2,
percent_rank() over (order by salary) as pctrank
from employees
order by 
coalesce(firstname+' '+lastnaem, firstname, lastname), salary desc

--percentile_cont/percentile_disc to calculate median salary by title
--good for finding median
--parameter (percentile to computer) should be between 0 and 1... .5 means the median
select coalesce(firstname+' '+lastnaem, firstname, lastname) as name,
title, salary,
percentile_cont(.5) within group (order by salary) over (partition by Title),
percentile_cont(.5) within group (order by salary) over (partition by Title)
from employees
order by 
coalesce(firstname+' '+lastnaem, firstname, lastname), salary desc
