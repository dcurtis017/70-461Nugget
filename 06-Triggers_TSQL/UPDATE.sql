use NuggetDemoDB
Go

if object_id('ProductPriceHistory', 'U') is not null
	drop table ProductPriceHistory
go
Create Table dbo.ProductPriceHistory(
	PriceHistoryId uniqueidentifier not null primary key,
	ProductID int not null,
	PreviousPrice decimal(19,4) null,
	NewPrice decimal(19,4) not null,
	PriceChangeDate datetime not null
) on [PRIMARY]

Go

If OBJECT_ID('uProductPrice Change', 'TR') Is not null -- PASSING NAME of object and type of object to object_id function
	drop trigger uProductPriceChange
Go

create trigger uProductPriceChagne on Products
	for update 
	--for and after mean the same thing 
	--if you waant the trigger to fire on multiple ddl statements separate them with a comma
as
	insert ProductPriceHistory(PriceHistoryId, ProductID, PreviousPrice, NewPrice, PriceChangeDate)
	select
		newid(), p.ProductID, d.price, i.Price , getdate()
		from 
			Products p
				join
			inserted i on p.ProductID = i.ProductID
				join
			deleted d on p.ProductID = d.ProductID
GO
