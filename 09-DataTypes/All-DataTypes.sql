use NuggetDemoDB
go

if object_id('DataTypeTester', 'U') is not null
	drop table DataTypeTester
go

create table DataTypeTester
(
	--character data types
	[char] char(3),
	[varchar] varchar(10),
	[varcharMAX] varchar(max),
	[text] text,

	--unicode char
	[nchar] nchar(3),
	[nvarchar] nvarchar(10),
	[nvarcharMAX] nvarchar(max),
	[ntext] ntext,

	--binary
	[bit] bit, 
	[binary] binary(3),
	[varbinary] varbinary(10),
	[varbinaryMAX] varbinary(max),
	[image] image,

	--numeric (exact)
	[tinyint] tinyint,
	[smallint] smallint,
	[int] int,
	[bigint] bigint,
	[decimal] decimal(14, 6),
	[numeric] numeric(14, 6),
	[smallmoney] smallmoney,
	[money] money,

	--numeric (approx)
	[float] float,
	[real] real,

	--date
	[datetime] datetime,
	[datetim2e] datetime2,
	[smalldatetime] smalldatetime,
	[date] date,
	[time] time,
	[datetimeoffset] datetimeoffset,
	[timestamp] timestamp,

	--special
	[sql_variant] sql_variant,
	[uniqueidentifier] uniqueidentifier,
	[xml] xml,
	[hierarchyid] hierarchyid,

	--spacial
	[geometry] geometry,
	[geography] geography
)

insert into DataTypeTester
	([char],[varchar],[varcharMAX],	[text],	[nchar],[nvarchar],[nvarcharMAX],[ntext],[bit], [binary],[varbinary],[varbinaryMAX],[image],[tinyint],[smallint],[int],[bigint],[decimal],[numeric],[smallmoney],[money],[float],[real],	[datetime],[datetim2e],[smalldatetime],[date],[time],[datetimeoffset],[sql_variant],[uniqueidentifier],[xml],	[hierarchyid],	[geometry])--,[geography] )
	values
	(
		---character
		'ABC', 'Varying', 'MAX of over 1billion chars', 'Up to 2gb of data!',

		--unicode
		--the N ensures the data goes into sql server as unicode
		N'Uni',N'Unice',N'asian',N'cyrillic',

		--binary
		0,
		cast('ABC' as binary(3)),
		CAST('Varying' as varbinary(10)),
		cast('max of 2gb data' as varbinary(max)),
		(select * from openrowset(bulk 'C:\Users\curtis\Documents\SQL Server Management Studio\70-461 Querying SQL2014\09-DataTypes\pic.jpg', single_blob) i),
		--open rowset opens the file
		--bulk will read the contents as binary data
		--single blob will result in a single row single column format

		--numeric(exact)
		253,32761,2147483647,9223372036854775807,99999999.999999,99999999.999999,14748.3647,223377203685477.5807,

		--numeric (approximate)
		1.79E+308,3.40E+38,

		--datetime
		getdate(), sysdatetime(), cast(getdate() as smalldatetime),
		cast(getdate() as date), convert(varchar(12), getdate(), 14),--convert will format dates, times, numerical formats and even xml
		todatetimeoffset(getdate(), '-06:00'),

		--special data
		getdate(),
		newid(),
		'<XMLRoot>
			<Person>
				<FirstName>Luke</FirstName>
				<LastName>Skywalker</LastName>
			</Person>
		</XMLRoot>',
		null,

		--spacial
		geometry::STGeomFromText('LINESTRING(1 1, 5 1,3 5, 1 1)', 0)
		--geography::STMPolyFromText('MULTIPOLYGON(((1 1, 1 -1, -1 -1, -1 1, 1 1)),((1 1, 3 1, 3 3)))', 4326)
	)
go

select * from DataTypeTester
