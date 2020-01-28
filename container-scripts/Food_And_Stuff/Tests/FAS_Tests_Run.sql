USE Food_And_Stuff

/*
EXEC tSQLt.RunAll
GO

EXEC tSQLt.Run
    N'FAS_Tests'
GO
*/

EXEC tSQLt.Run
     N'FAS_Tests.[test GivenMergeCustomers-ThenCustomerIsCorrect]'
GO

EXEC tSQLt.Run
     N'FAS_Tests.[test GivenMergeCustomers-ThenOrderIsCorrect]'
GO