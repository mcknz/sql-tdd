USE Food_And_Stuff
GO

DROP PROCEDURE [dbo].[MergeCustomer]
GO
CREATE PROCEDURE [dbo].[MergeCustomer]
  @DuplicateCustomer INT,
  @CustomerToKeep    INT
AS
    BEGIN

        DELETE dbo.Customer 
        WHERE CustomerId = @DuplicateCustomer

        UPDATE dbo.[Order]
        SET CustomerId = @CustomerToKeep
        WHERE CustomerId = @DuplicateCustomer
           OR CustomerId = @CustomerToKeep

    END
GO