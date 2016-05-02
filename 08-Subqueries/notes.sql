/**
CTE - common table expression


-->Subquery
A query nested in the main query or another subquery
You can pass subqueries to functions
AKA inner query
Correlated subquery is when the subquery references something in the outer query
Most subqueries can be rewritten as joins (the sql server optimizer will usually do this)
At times subqueries can outperform joins

-->Common Table Expressions
Temporary result set
Can be referenced multiple times unlike derived tables
Great for code readability
Completely separate from main query

-->Pivot Tables
Tranforms rows into columns
AKA Crosstab or Matrix

**A derived table is a table expression that appears in the from clasuse of a query
see https://www.mssqltips.com/sqlservertip/1042/using-derived-tables-to-simplify-the-sql-server-query-process/
-**/