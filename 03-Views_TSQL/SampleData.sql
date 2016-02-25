use NuggetDemoDB;
Go

Insert employees select 1, 'John', Null, 'Shephard', 'Sales Person', '1/1/2016', 5, 40000;
Insert employees select 1, 'Jane', Null, 'Shephard', 'Sales Person', '12/11/2016', 15, 70000;

Truncate table Products;
Insert Products Select 1, 'Shirt', 12.99;
Insert Products Select 2, 'Shorts', 14.99;
Insert Products Select 3, 'Pants', 19.99;
Insert Products Select 4, 'Hat', 9.99;

Insert sales select newid(), 1,1,4, '02/01/2012';
Insert sales select newid(), 2,1,1, '02/01/2012';
Insert sales select newid(), 3,1,2, '02/01/2012';
Insert sales select newid(), 2,2,2, '02/01/2012';
Insert sales select newid(), 3,2,1, '02/01/2012';
Insert sales select newid(), 4,2,2, '02/01/2012';

--create 50000 random sales records!
Declare @counter int
SET @counter = 1

WHILE @counter <= 50000
	BEGIN
		INSERT Sales
			select
			NEWID(),--generates a random guid
			(ABS(CHECKSUM(NEWID()))%4)+1, --checksum gives the hash value of whatever you pass it
			(ABS(CHECKSUM(NEWID()))%2)+1,--generating a random # between 1 and 2
			(ABS(CHECKSUM(NEWID()))%9)+1,
			dateadd(day, abs(checksum(newid())%3650), '2002-04-01')--random date in last 10 yrs with 04-01-02 as the start date
		set @counter+=1
	end