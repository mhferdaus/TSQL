-------------------------------------------------------------
-- insert update and delete

-- INSERT INTO table_name
-- VALUES (value1,value2,value3,...);

-- INSERT INTO table_name (column1,column2,column3,...)
-- VALUES (value1,value2,value3,...);

insert into Course
values(7,'D'),
(8,'Z')

select * from Course

-- UPDATE table_name
-- SET column1=value1,column2=value2,...
-- WHERE some_column=some_value;

update Course
set Description = 'F'
Where Description = 'D'

select * from Course

-- DELETE FROM table_name
-- WHERE some_column=some_value; 

delete from Course
where Description = 'F'
or Description = 'Z'

select * from Course

--------------------------------------------------------

declare @temptable table
(
Id int,
Course_Description varchar(100)
)

insert into @temptable
select Id,
Course_Description=					-- can be any name with
	case Description				-- with varchar <= 100
		When 'M' then 'Math'
		when 'E' then 'Economics'
		when 'P' then 'Politics'
		when 'C' then 'Computer Science'
		when 'J' then 'Java'
		when 'S' then 'SQL'
	end
from course

select * from @temptable

--------------------------------------------------------

-- pageing

select *
From Course
order by Id
offset 0 rows
fetch next 2 rows only;

select *
From Course
order by Id
offset 2 rows
fetch next 2 rows only;

select *
From Course
order by Id
offset 4 rows
fetch next 2 rows only;

----------------------------------------------------------

-- scalar value table function

CREATE FUNCTION GetDescription
(
	@Id int
)
RETURNS varchar(1)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Description as varchar(1)

	-- Add the T-SQL statements to compute the return value here
	set @Description = (SELECT Description from Course
	where Id = @Id )

	-- Return the result of the function
	RETURN @Description

END
GO

-- testing the function

select ([dbo].[GetDescription](2))

----------------------------------------------
-- create table

--IF OBJECT_ID ('dbo.Dummy', 'T') IS NOT NULL
--   DROP TABLE dbo.Dummy;

CREATE TABLE [dbo].[Dummy](
	[Id] [int] IDENTITY(3,2) NOT NULL primary key,
	[Name] [varchar](50) NOT NULL,
	[Course] [varchar](50) NULL,
	[CourseDate] [date] NOT NULL Default '20150503'
)

insert into dbo.Dummy ( Name, Course)
values  ('Me', null),
		('Myself','CSC'),
		('Irene','MATH')

select * from dbo.Dummy

--------------------------------------------------------------
-- inserting using select

IF OBJECT_ID ('Dummy2', 'T') IS NOT NULL
   DROP TABLE Dummy2;


CREATE TABLE Dummy2(
	[Id] [int] IDENTITY(3,2) NOT NULL primary key,
	[Name] [varchar](50) NOT NULL,
	[Course] [varchar](50) NULL Default 'MATH'
)

insert into 
Dummy2(Name,Course)
select Name,Course 
from Dummy

select * from Dummy2