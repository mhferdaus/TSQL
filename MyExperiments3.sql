---------------------------------------------------------------
-- creating procedure

CREATE PROCEDURE StudentsPerCourseDescription
	-- Add the parameters for the stored procedure here
	@Description varchar(1)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if @Description is null
		select s.Id,s.Name, s.CourseId, c.Description
		from Student s
		inner join course c
		on c.Id = s.CourseId
	else
		select s.Id,s.Name, s.CourseId, c.Description
		from Student s
		inner join course c
		on c.Id = s.CourseId
		where c.Description = @Description 

END
GO

exec dbo.StudentsPerCourseDescription 'C'

--------------------------------------------------

drop procedure dbo.InsertToStudent;
go

CREATE PROCEDURE InsertToStudent
	@Name varchar(100),
	@CourseId int
 
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Student
            (Name,
			CourseId)
        VALUES (@Name,@CourseId);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback any active or uncommittable transactions before
        -- inserting information in the ErrorLog
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        EXECUTE [dbo].[uspLogError];
    END CATCH;
END;

GO

-- exec dbo.InsertToStudent 'Trick', 3

select * from Course

------------------------------------------------------
-- update procedure

DROP PROCEDURE dbo.UpdateToStudent;
GO

CREATE PROCEDURE UpdateToStudent
	@OldName varchar(100),
	@NewName varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if @OldName is not null and @NewName is not null
	begin
		if exists 
		( select Name
		from Student
		where Name = @OldName)
		begin 
			Update Student
			set Name = @NewName
			where Name = @OldName
			print 'Update Successful'
		end
		else
			print 'Update not successful'
	end
	else
		print 'Update not successful'
END
GO

exec dbo.UpdateToStudent 'Core', 'Quad'

-----------------------------------------------
-- delete procedure

drop procedure dbo.DeleteFromStudent;
go

create procedure DeleteFromStudent
	@Name varchar(100)
AS
BEGIN
	if @Name is not null
	begin
		if exists
		(select Name From Student
		where Name = @Name)
		begin
			delete from Student
			where Name = @Name
		end
		else
			print 'Delete not Successful'
	end
	else
		print 'Delete not Successful'
END

exec dbo.DeleteFromStudent 'Hat'

---------------------------------------------------------