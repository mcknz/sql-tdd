USE Food_And_Stuff
GO

EXEC tSQLt.NewTestClass
     @ClassName = N'FAS_Tests'
GO

------------- BEGIN [FAS_Tests].[InsertTestData] ----------
CREATE PROC FAS_Tests.InsertTestData
AS
  BEGIN

      ---------------- BEGIN CUSTOMERS -------------------
      DECLARE @RonaldId INT = 1, @RonId INT = 2

      INSERT INTO dbo.Customer(
          CustomerId, FirstName, LastName, LoyaltyId
      )
      VALUES(@RonaldId, 'Ronald', 'Swanson', 1234)

      INSERT INTO dbo.Customer(
          CustomerId, FirstName, LastName, LoyaltyId
      )
      VALUES(@RonId, 'Ron', 'Swanson', 1234)
      ---------------- END CUSTOMERS ---------------------
      --
      --
      ---------------- BEGIN ORDERS ----------------------
      DECLARE @RonaldOrderId INT = 11, @RonOrderId INT = 22

      -- customer 1 order
      INSERT INTO [dbo].[Order](OrderId, CustomerId)
      VALUES(@RonaldOrderId, @RonaldId)

      -- customer 2 order
      INSERT INTO [dbo].[Order](OrderId, CustomerId)
      VALUES(@RonOrderId, @RonId)
      ---------------- END ORDERS ------------------------
      --
      --
      ---------------- BEGIN ORDER DETAIL ----------------
      DECLARE @RonaldDetailId INT = 111
      DECLARE @RonDetailId INT = 222

      INSERT INTO [dbo].[OrderDetail](OrderDetailId, OrderId, ItemName)
      VALUES(@RonaldDetailId, @RonaldOrderId,
          'T-Bone Steaks: Val-U 20 Pack')

      INSERT INTO [dbo].[OrderDetail](OrderDetailId, OrderId, ItemName)
      VALUES(@RonDetailId, @RonOrderId,
          'Bacon Strips: Val-U 100 Pack')
      ---------------- END ORDER DETAIL -------------------
  END
GO

------------- END [FAS_Tests].[InsertTestData] ------------


------------- BEGIN [FAS_Tests].[Setup] -------------------
CREATE PROC FAS_Tests.Setup
AS
  BEGIN

--create fakes for tests against tables
      EXEC tSQLt.FakeTable 'dbo.OrderDetail'

      EXEC tSQLt.FakeTable 'dbo.[Order]'

      EXEC tSQLt.FakeTable 'dbo.Customer'

-- populate fake tables
      EXEC FAS_Tests.InsertTestData

  END
GO
------------- END [FAS_Tests].[Setup] ---------------------
--
--
------------- BEGIN GivenMergeCustomers-ThenCustomersIsCorrect ----------------
CREATE PROC FAS_Tests.[test GivenMergeCustomers-ThenCustomerIsCorrect]
AS
  BEGIN

--Arrange

      DECLARE @RonaldId INT= 1
      DECLARE @RonId INT= 2  /* Customer Id we want to keep */

      DECLARE @ExpectedRonFirstName NVARCHAR(50) = (
              SELECT FirstName FROM dbo.Customer
              WHERE CustomerId = @RonId
      )
      DECLARE @ExpectedRonLastName NVARCHAR(50)= (
              SELECT LastName FROM dbo.Customer
              WHERE CustomerId = @RonId
      )
      DECLARE @ExpectedLoyaltyId INT = (
              SELECT LoyaltyId FROM dbo.Customer
              WHERE CustomerId = @RonId
      )

      CREATE TABLE FAS_Tests.Expected(
        CustomerId           INT NOT NULL,
        FirstName            NVARCHAR(50) NOT NULL,
        LastName             NVARCHAR(50) NOT NULL,
        LoyaltyId            INT NOT NULL
      )

--only Ron should exist
      INSERT INTO FAS_Tests.Expected(
          CustomerId
        , FirstName
        , LastName
        , LoyaltyId
      )
      VALUES(
          @RonId
        , @ExpectedRonFirstName
        , @ExpectedRonLastName
        , @ExpectedLoyaltyId
      )

--Act
      EXEC dbo.MergeCustomer
           @DuplicateCustomer = @RonaldId,
           @CustomerToKeep = @RonId

--Assert
      EXEC tSQLt.AssertEqualsTable
           @Expected = N'FAS_Tests.Expected',
           @Actual = N'dbo.Customer',
           @FailMsg = N'Customer table has incorrect data.'
  END
GO
------------- END GivenMergeCustomers-ThenCustomerIsCorrect ------------------
--
--
------------- BEGIN GivenMergeCustomers-ThenOrderIsCorrect ----------------
CREATE PROC FAS_Tests.[test GivenMergeCustomers-ThenOrderIsCorrect]
AS
  BEGIN
 --Assert
      DECLARE @RonaldId INT= 1
      DECLARE @RonId INT= 2  /* Customer Id we want to keep */

      CREATE TABLE FAS_Tests.Expected(
        OrderId           INT NOT NULL,
        CustomerId        INT NOT NULL
      )

--only orders for Ron (CustomerId 2) should exist
      INSERT INTO FAS_Tests.Expected(
          OrderId
        , CustomerId
      )
      SELECT OrderId, @RonId
      FROM dbo.[Order]
      WHERE CustomerId = @RonaldId
        OR CustomerId = @RonId

--Act
      EXEC dbo.MergeCustomer
           @DuplicateCustomer = @RonaldId,
           @CustomerToKeep = @RonId

--Assert
      EXEC tSQLt.AssertEqualsTable
           @Expected = N'FAS_Tests.Expected',
           @Actual = N'dbo.[Order]',
           @FailMsg = N'Order table has incorrect data.'
  END
GO
------------- END GivenMergeCustomers-ThenOrderIsCorrect ------------------