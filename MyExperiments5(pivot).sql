use AdventureWorksLT2012
go

--

-- just to understand syntax begins
select distinct
	',' + QUOTENAME(ReasonType) 
from 
	Sales.SalesReason

select * from
	(select Name, 
	ReasonType, 
	YEAR(ModifiedDate) AS ModifiedYear, 
	DATENAME(MM,ModifiedDate) as ModifiedMonth 
	from Sales.SalesReason) as BaseData
pivot (
	count(Name)
	for ReasonType
	in (
	[Marketing]
	,[Other]
	,[Promotion])
) as PivotTable
ORDER BY
	ModifiedYear desc, ModifiedMonth desc
-- just to understand syntax ends

-- just to understand dynamic pivot table Begins

-- only for show as already created Begins
CREATE VIEW ColumnView AS SELECT DISTINCT ReasonType FROM Sales.SalesReason
-- only for show as already created Ends

DECLARE @ColumnNames NVARCHAR(MAX) = ''
DECLARE @SQL NVARCHAR(MAX) = ''

SELECT @ColumnNames +=  QUOTENAME(ReasonType) + ',' FROM ColumnView


SET @ColumnNames = LEFT(@ColumnNames, LEN(@ColumnNames) - 1)

SET @SQL =
'select * from
	(select Name, 
	ReasonType, 
	YEAR(ModifiedDate) AS ModifiedYear, 
	DATENAME(MM,ModifiedDate) as ModifiedMonth 
	from Sales.SalesReason) as BaseData
pivot (
	count(Name)
	for ReasonType
	in ('
	+ @ColumnNames +
	')
) as PivotTable
ORDER BY
	ModifiedYear desc, ModifiedMonth desc'

EXECUTE sp_executesql  @SQL

-- just to understand dynamic pivot table Ends

-- ** --

CREATE VIEW PivotView AS
select * from
	(select Name, 
	ReasonType, 
	YEAR(ModifiedDate) AS ModifiedYear, 
	DATENAME(MM,ModifiedDate) as ModifiedMonth 
	from Sales.SalesReason) as BaseData
pivot (
	count(Name)
	for ReasonType
	in (
	[Marketing]
	,[Other]
	,[Promotion])
) as PivotTable

SELECT * FROM PivotView

-- ** --

-- real static pivot test Begins

select * from Sales.SalesOrderDetail

select distinct
	',' + QUOTENAME(ProductID) 
from 
	Sales.SalesOrderDetail
where
	ProductID >= 700 and  ProductID <= 710

SELECT * FROM (select ProductID, 
	UnitPrice, 
	YEAR(ModifiedDate) AS ModifiedYear, 
	DATENAME(MM,ModifiedDate) as ModifiedMonth 
	from Sales.SalesOrderDetail) as BaseData
pivot (
	sum(UnitPrice)
	for ProductID
	in (
	[708]
	,[707]
	,[710]
	,[709]
	)
) as PivotTable
ORDER BY
	ModifiedYear desc, ModifiedMonth desc

-- real static pivot test Ends

-- real dynamic pivot test Begins

-- only for show as already created Begins
CREATE VIEW Sales.SalesColumnView AS
select distinct ProductID 
from 
	Sales.SalesOrderDetail
where
	ProductID >= 700 and  ProductID <= 710
-- only for show as already created Ends

DECLARE @ColumnNames NVARCHAR(MAX) = ''
DECLARE @SQL NVARCHAR(MAX) = ''

SELECT @ColumnNames +=  QUOTENAME(ProductID) + ',' FROM Sales.SalesColumnView


SET @ColumnNames = LEFT(@ColumnNames, LEN(@ColumnNames) - 1)

SET @SQL =
'SELECT * FROM (select ProductID, 
	UnitPrice, 
	YEAR(ModifiedDate) AS ModifiedYear, 
	DATENAME(MM,ModifiedDate) as ModifiedMonth 
	from Sales.SalesOrderDetail) as BaseData
pivot (
	sum(UnitPrice)
	for ProductID
	in ('
	+ @ColumnNames +
	')
) as PivotTable
ORDER BY
	ModifiedYear desc, ModifiedMonth desc'

EXECUTE sp_executesql  @SQL

-- real dynamic pivot test Ends