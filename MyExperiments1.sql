use MyExperiments
go

select s.Id, s.Name, s.CourseId, 
"Course Description" =
	case c.Description
	When 'M' then 'Math'
	when 'E' then 'Economics'
	when 'P' then 'Politics'
	when 'C' then 'Computer Science'
	when 'J' then 'Java'
	when 'S' then 'SQL'
	end
from Student s
inner join Course c
on c.Id = s.CourseId

--------------------------------------
-- creating own function

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- sp_help [Person.Address]

CREATE FUNCTION dbo.ufnGetThreeCourseDesc(@FirstId int,@SecondId int, @ThirdId int)
RETURNS @retContactInformation TABLE 
(
    -- Columns returned by the function
    Id int NOT NULL, 
    Name varchar(100) NOT NULL, 
    CourseId int NULL, 
	Description varchar(1) not NULL
)
AS 
-- Returns the first name, last name, job title and business entity type for the specified contact.
-- Since a contact can serve multiple roles, more than one row may be returned.
BEGIN
	insert into @retContactInformation
		select s.Id, s.Name, s.CourseId, c.Description
		from Student s
		inner join Course c
		on c.Id = s.CourseId
		where c.Id = @FirstId
		or c.Id = @SecondId
		or c.Id = @ThirdId

	RETURN;
END;

-- drop dbo.ufnGetThreeCourseDesc

select * from dbo.ufnGetThreeCourseDesc(3,4,5)

-----------------------------------------------

-- Creating Stored Procedure


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE StudentsPerCourse
	-- Add the parameters for the stored procedure here
	@Course int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if @Course is null
		select Name, CourseId from Student
	else
		select Name, CourseId 
		from Student where CourseId = @Course

END
GO

-------------------------------------------------------------

StudentsPerCourse 4
exec StudentsPerCourse null

-------------------------------------------------------------