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

      EXEC tSQLt.FakeTable 'dbo.Order'

      EXEC tSQLt.FakeTable 'dbo.Customer'

      EXEC tSQLt.ApplyConstraint N'dbo.Order',
          N'FK_Order_Customer_CustomerId'

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
GO
------------- END GivenMergeCustomers-ThenCustomerIsCorrect ------------------
--
--
------------- BEGIN GivenMergeCustomers-ThenOrderIsCorrect ----------------
CREATE PROC FAS_Tests.[test GivenMergeCustomers-ThenOrderIsCorrect]
AS
GO
------------- END GivenMergeCustomers-ThenOrderIsCorrect ------------------