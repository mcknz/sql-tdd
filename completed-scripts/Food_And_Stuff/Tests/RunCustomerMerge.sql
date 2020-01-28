USE Food_And_Stuff
GO

BEGIN TRAN

    DECLARE @RonaldId INT= 1
    DECLARE @RonId INT= 2  /* Customer Id we want to keep */

    EXEC FAS_Tests.InsertTestData

    EXEC dbo.MergeCustomer
        @DuplicateCustomer = @RonaldId,
        @CustomerToKeep = @RonId

    SELECT * FROM dbo.Customer
    SELECT * FROM dbo.[Order]
    SELECT * FROM dbo.OrderDetail

ROLLBACK
GO