/***
-->Character Date (ANSI)
char - fixed length..will always allocate that amount even if it's not all used
varchar
text - dont use...instead use varchar(max)
256 codes (characters)
800 char max for varchar, char
varchar can use MAX which will allow over 1 billion characters (2 gigs)

-->Unicode Character Data -- usually when you'll be using other languages
nchar
nvarchar
ntext - dont use
twice the storage of ansi
unicode has up to 65536 unique codes

-->Binary Data
bit - 0, 1 or null
binary - fixed length binary field...generally store images, excel files, word files...n can be max of 8000
varbinary can use max for storage of up to 2 gigs
image - dont use

-->Numeric DAta (exact)
tinyint 0-255, 1 byte of data
smallint -32768-32767 2 bytes of storage
int -2billion something to +2bill 4 bytes of storage
bigint 8 bytes of storage space
decimal sql standard...specify precision (total number of digits) and scale (number of digits after decimal)...storage 5-17 bytes depending on precision
numeric ms sql standard...use decimal instead
smallmoney ms sql standard 4 bytes
money ms sql standard 8 bytes

-->Numeric (apporximate)
float 4-8 bytes of storage
real half of a float 4 bytes

-->spatial
geometry
geography - takes into account curvature

-->date and time
smalldatetime
datetime
datetime2 - higher precision than datetime
date 3 bytes
time 3-5 bytes
datetimeoffset pretty much datetime2 with a timezone offset
timestamp sql server creates this

-->special data
sql_variant can store a mismash of many different types except text, timestamp and ntext...have to check and do conversions on data when pulled out
xml
uniqueidentifier 128bit integer can be used to create unique ids
hierarchyid allows you to store a pointer to where a node sits in a heirarchy (tree structure)


-->GUID (uniqueid)
128bit int
simplified merging data from multiple sources
can slow down queries when used as primary key
you can use an int for the primary key but have a guid on the table that is used in for example urls to provide better security

-->Identity(int) 
32 bit
high performance primary keys
easier to type when manually working with data

-->Data Type converssions
implicityly happens automatically
explicit uses CAST or CONVERT
use cast for iso compliance
use convert to format data

-->Data type guidelines
use smallest data type possible
use correct data type
use fixed length when values are mostly the same size
use char datatypes for non-mathematical numeric values
*/