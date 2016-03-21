use AdventureWorks2014
go

if object_id('HumanResources.dEmployee', 'TR') is not null
	drop trigger HumanResources.dEmployee
go

USE [AdventureWorks2014]
GO

/****** Object:  Trigger [HumanResources].[dEmployee]    Script Date: 3/20/2016 10:23:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [HumanResources].[dEmployee] ON [HumanResources].[Employee] 
INSTEAD OF DELETE NOT FOR REPLICATION AS --so trigger won't replicate if tables are replicated
--if a delete statement happens, this code will fire first so we can check before submission and even roll back

BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
	--@@rowcount says how many rows were affected by the last statement...it's a global
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;--don't return any counts to the messages window

    BEGIN
        RAISERROR
            (N'Employees cannot be deleted. They can only be marked as not current.', -- Message
            10, -- Severity.
            1); -- State.

        -- Rollback any active or uncommittable transactions
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
    END;
END;

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'INSTEAD OF DELETE trigger which keeps Employees from being deleted.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'TRIGGER',@level2name=N'dEmployee'
GO

