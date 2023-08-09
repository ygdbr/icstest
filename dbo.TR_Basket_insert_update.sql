-- Создание триггера
CREATE TRIGGER dbo.TR_Basket_insert_update
ON dbo.Basket
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Обновляем DiscountValue в зависимости от количества записей для каждого ID_SKU
    UPDATE b
    SET DiscountValue = CASE WHEN cnt > 1 THEN Value * 0.05 ELSE 0 END
    FROM dbo.Basket b
    JOIN (
        SELECT ID_SKU, COUNT(*) AS cnt
        FROM inserted
        GROUP BY ID_SKU
    ) i ON b.ID_SKU = i.ID_SKU
    WHERE b.ID IN (SELECT ID FROM inserted);
END;