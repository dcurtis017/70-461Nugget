use NuggetDemoDB
go

--using object_id metadata function -- name of object, type of object
if OBJECT_ID('iProductNotification', 'TR') IS NOT NULL
	drop trigger iProductNotification
go

--using OBJECTPROPERTY with OBJECT_ID metadata function
IF OBJECTPROPERTY(OBJECT_ID('Employees'), 'IsTable') = 1
	print 'Yes, it''s a table.'
else
	print 'No, not a table.'

--Querying sys.objects system view
select * from sys.objects where OBJECTPROPERTY(OBJECT_ID,'SchemaID') = SCHEMA_ID('dbo')

--more system metadata views
select * from INFORMATION_sCHEMA.TABLES
SELECT * FROM INFORMATION_SCHEMA.COLUMNS

--system stored procs
exec sp_Help 'Employees' --info about a table

--undocumented stored procs
--msforeachtable sp will loop through all tables in db ? will be replaced with a table
exec sp_msforeachtable 'DBCC CHECKTABLE ([?])'
exec sp_MSForeachtable 'EXECUTE sp_spaceused [?]'

--
