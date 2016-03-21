use NuggetDemoDB
Go

if object_id('iProductNotification', 'TR') is not null
	drop trigger iProductNotification
go

/**


*/

create trigger iProductNotification on Products
	for insert
As
	declare @ProductInformation nvarchar(255);

	select 
		@ProductInformation = 'New product' + Name + 'is not available for ' + cast(Price as nvarchar(20)) +'!'
		--need to cast the number to varchar in order to concat it
	from
		inserted;

	exec msdb.dbo.sp_send_dbmail
		@profile_name = 'Notifications',
		@recipients = 'mrjoefriday@gmail.com',
		@body = @ProductInformation,
		@subject = 'New Product Notification';
Go
