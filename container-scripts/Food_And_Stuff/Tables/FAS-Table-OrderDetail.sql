USE Food_And_Stuff
GO

CREATE TABLE dbo.OrderDetail
(
    OrderDetailId INT NOT NULL CONSTRAINT PK_OrderDetailId PRIMARY KEY CLUSTERED,
    OrderId INT,
    ItemName NVARCHAR(50)
    CONSTRAINT [FK_OrderDetail_Order_OrderId] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Order] ([OrderId])
)
GO