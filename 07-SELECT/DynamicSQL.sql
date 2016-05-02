use NuggetDemoDB
go

--using exec..create sql as a string and call exec
declare @sql nvarchar(max),
		@topCount int

set @topCount = 10
set @sql = 'Select top ' + cast(@topCount as nvarchar(8)) + ' * from sales order by saledate desc';

exec(@sql)


--using sp_ExecuteSQL
--ms recommends b/c it's safer since it's parameterized
use master;
go

declare UserDatabases Cursor for
	select name from sys.databases where database_id > 4 --put query results in cursor
open UserDatabases

Declare @dbName nvarchar(128)
Declare @sql nvarchar(max)

Fetch next from UserDatabases into @dbName
While (@@FETCH_STATUS = 0)
	Begin 
		set @sql = 'USE ' +@dbName + ';' + char(13) + 'DBCC SHRINKDATABASE ('+@dbName+')'
		exec sp_executeSQL @sql

		fetch next from UserDatabases into @dbName
	end
close UserDatabases
Deallocate UserDatabases