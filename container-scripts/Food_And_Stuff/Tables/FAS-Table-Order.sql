USE Food_And_Stuff
GO

CREATE TABLE dbo.[Order]
(
    OrderId INT NOT NULL CONSTRAINT PK_Order PRIMARY KEY CLUSTERED,
    CustomerId INT,
    CONSTRAINT [FK_Order_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
)
GO