-- Создание процедуры usp_MakeFamilyPurchase
CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
    @FamilySurName VARCHAR(255)
AS
BEGIN
    DECLARE @FamilyID INT;
    
    -- Получение ID семьи по фамилии
    SELECT @FamilyID = ID
    FROM dbo.Family
    WHERE SurName = @FamilySurName;
    
    -- Если семья не найдена, генерировать ошибку
    IF @FamilyID IS NULL
    BEGIN
        RAISEERROR('Семья с фамилией %s не найдена', 16, 1, @FamilySurName);
        RETURN;
    END;
    
    -- Обновление бюджета семьи
    UPDATE dbo.Family
    SET BudgetValue =(SELECT SUM(Value) FROM dbo.Basket WHERE ID_Family = @FamilyID)
    WHERE ID = @FamilyID;
END;