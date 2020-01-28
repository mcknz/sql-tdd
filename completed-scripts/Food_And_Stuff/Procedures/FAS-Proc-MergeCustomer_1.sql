USE Food_And_Stuff
GO

CREATE PROCEDURE [dbo].[MergeCustomer]
  @DuplicateCustomer INT,
  @CustomerToKeep    INT
AS
    BEGIN

        DELETE dbo.Customer 
        WHERE CustomerId = @DuplicateCustomer

    END
GO