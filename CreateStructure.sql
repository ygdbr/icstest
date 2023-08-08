-- Создание таблицы SKU
CREATE TABLE dbo.SKU (
    ID INT IDENTITY PRIMARY KEY,
    SKUCode NVARCHAR(50) UNIQUE,
    Name NVARCHAR(100)
);
ALTER TABLE dbo.SKU ADD Code AS ('s' + CAST(ID AS NVARCHAR(50)));

-- Создание таблицы Family
CREATE TABLE dbo.Family (
    ID INT IDENTITY PRIMARY KEY,
    SurName NVARCHAR(100),
    BudgetValue DECIMAL(18, 2)
);

-- Создание таблицы Basket
CREATE TABLE dbo.Basket (
    ID INT IDENTITY PRIMARY KEY,
    ID_SKU INT,
    ID_Family INT,
    Quantity INT CHECK (Quantity >= 0),
    Value DECIMAL(18, 2) CHECK (Value >= 0),
    PurchaseDate DATE DEFAULT GETDATE(),
    DiscountValue DECIMAL(18, 2)
	FOREIGN KEY (ID_SKU) REFERENCES dbo.SKU(ID),
    FOREIGN KEY (ID_Family) REFERENCES dbo.Family(ID)
);
