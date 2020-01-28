﻿USE Food_And_Stuff

CREATE TABLE dbo.Customer
(
    CustomerId INT NOT NULL CONSTRAINT PK_Customer PRIMARY KEY CLUSTERED,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    LoyaltyId INT NOT NULL
)
GO