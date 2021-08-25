CREATE TRIGGER LegoSetDelete
ON LegoSet
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Cannot delete from this table.', 16, 1)
END;
GO

CREATE TRIGGER ColorDelete
ON Color
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Cannot delete from this table.', 16, 1)
END;
GO

CREATE TRIGGER ElementDelete
ON Element
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Cannot delete from this table.', 16, 1)
END;
GO

CREATE TRIGGER DesignDelete
ON Design
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Cannot delete from this table.', 16, 1)
END;