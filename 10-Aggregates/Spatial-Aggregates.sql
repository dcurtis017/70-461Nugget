--tables and data from http://www.thematicmapping.org

use NuggetDemoDB
go

create table [dbo].World_borders(
[FIPS][NVARCHAR](255) NULL,
[ISO2][NVARCHAR](255) NULL,
[ISO3][NVARCHAR](255) NULL,
[UN] INT NULL,
[NAME][NVARCHAR](255) NULL,
[POP2005][BIGINT] NULL,
[REGION][INT] NULL,
[SUBREGION] INT NULL,
[LON] FLOAT NULL,
[LAT] FLOAT NULL,
[GEOM] GEOMETRY NULL,
[GEOG] GEOGRAPHY NULL,
)
go

---INSERT DATA

select * from World_borders where SUBREGION = 5

--union aggregate to combine spacial objects into one ... remove interior borders
select geography::UnionAggregate(geog)
from World_borders
where subregion = 5

use AdventureWorks2014
go
select city, SpatialLocation
from person.address
where StateProvinceID = 79

--envelope aggregate will map all customers with state provinceid of 79 by long/lat
select city,
geography::EnvelopeAggregate(spatiallocation) as spatiallocation
from person.Address
where StateProvinceID = 79
group by city

--convert geogrpahy to character to find lat/long
select city,
spatiallocation,
cast(spatiallocation as varchar(max))
from person.Address
where StateProvinceID = 79

--collection...make a geometry object from a geography object
select geography::CollectionAggregate(spatiallocation).ToString() as spatiallocation
from person.Address
where StateProvinceID = 79

--convex hull helps to visualize the outerlimits
select geography::ConvexHullAggregate(spatiallocation) as spatiallocation
from person.Address
where StateProvinceID = 79