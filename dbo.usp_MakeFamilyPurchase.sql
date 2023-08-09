-- �������� ��������� usp_MakeFamilyPurchase
CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
    @FamilySurName VARCHAR(255)
AS
BEGIN
    DECLARE @FamilyID INT;
    
    -- ��������� ID ����� �� �������
    SELECT @FamilyID = ID
    FROM dbo.Family
    WHERE SurName = @FamilySurName;
    
    -- ���� ����� �� �������, ������������ ������
    IF @FamilyID IS NULL
    BEGIN
        RAISEERROR('����� � �������� %s �� �������', 16, 1, @FamilySurName);
        RETURN;
    END;
    
    -- ���������� ������� �����
    UPDATE dbo.Family
    SET BudgetValue =(SELECT SUM(Value) FROM dbo.Basket WHERE ID_Family = @FamilyID)
    WHERE ID = @FamilyID;
END;