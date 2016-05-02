use NuggetDemoDB
go

--pivot for sum of quantity by year
--sales by year by product
select * from 
(select productid, Year(saledate) as saleyear, quantity from sales ) s -- base query we're going to pivot against
pivot
(sum(quantity) --data we want to pivot against
 for [saleyear] --row we're turning into columns
 in ([2005],[2006],[2007],[2008],[2009],[2010])) as pt


--PIVOT for avg sales per  year by product
select p.name, pt.* from
(Select sales.ProductID, year(Saledate) as saleyear, price*quantity as saletotal
from sales join products on sales.productid = products.productid) s
pivot
(
avg([saletotal])
for [SaleYear]
	in ([2005],[2006],[2007],[2008],[2009],[2010])
) as pt
	join
	products p on pt.productid = p.productid
order by
	pt.productid

--unpivot is the opposite