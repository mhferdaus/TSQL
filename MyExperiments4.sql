-- testing trigger on table TriggerTesterTable

IF OBJECT_ID ('reminder1', 'TR') IS NOT NULL
   DROP TRIGGER reminder1;
GO
CREATE TRIGGER reminder1
ON dbo.TriggerTesterTable
AFTER INSERT, UPDATE 
AS RAISERROR ('Notify Customer Relations', 16, 10);
rollback transaction
GO

insert into TriggerTestertable(Name,Course)
	values ('deo','feo')

