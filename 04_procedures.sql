
-- Procedure which adds and inventory item
CREATE PROCEDURE AddInventoryItem
    @set_id INTEGER,
    @elem_id INTEGER,
    @inv_quant INTEGER
AS
BEGIN
    INSERT INTO Inventory 
        VALUES (@set_id, @elem_id, @inv_quant)
END;
GO

-- Procedure which adds a lego element
CREATE PROCEDURE AddElement
    @elem_id INTEGER,
    @elem_name NVARCHAR(50),
    @design_id INTEGER,
    @design_category NVARCHAR(50),
    @color_id INTEGER,
    @color_name NVARCHAR(50)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Color WHERE Color.id = @color_id)
    BEGIN
        INSERT INTO Color 
        VALUES (@color_id, @color_name);
    END

    IF NOT EXISTS (SELECT * FROM Design WHERE Design.id = @design_id)
    BEGIN
        INSERT INTO Design 
            VALUES (@design_id, @design_category);
    END

    INSERT INTO Element 
        VALUES (@elem_id, @elem_name, @design_id, @color_id)
END;
GO

-- Procedure which adds a lego set
CREATE PROCEDURE AddSet
    @set_id INTEGER,
    @set_name NVARCHAR(50),
    @set_year INTEGER,
    @theme_name NVARCHAR(50)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Theme WHERE Theme.themeName = @theme_name)
    BEGIN
        INSERT INTO Theme 
        VALUES (@theme_name);
    END

    DECLARE @theme_id INT;
    SELECT @theme_id = Theme.id
        FROM Theme WHERE Theme.themeName = @theme_name
        ORDER BY Theme.id DESC;

    INSERT INTO LegoSet 
        VALUES (@set_id, @set_name, @set_year, @theme_id)
END;
GO

-- Procedure which adds a minifigure
CREATE PROCEDURE AddMinifig
    @minifig_id INTEGER,
    @set_id INTEGER
AS
BEGIN
    DECLARE @theme_id INT;
    SELECT @theme_id = Theme.id
        FROM LegoSet JOIN Theme ON LegoSet.themeID = Theme.id
        ORDER BY Theme.id DESC;
    
    INSERT INTO Minifigure
        VALUES (@minifig_id, @theme_id, @set_id)
END;
GO

-- This procedure prints a colorless inventory for a given lego set, that is,
-- all elements desings necessary to build the set together with necessary quantities,
-- regardless of the colors.
CREATE PROCEDURE ColorlessInventory
    @set_id INTEGER
AS
BEGIN
    SELECT Element.elementName, Element.designID, SUM(Inventory.quantity) AS quantity
        FROM Inventory JOIN Element ON Inventory.elementID = Element.id
        WHERE Inventory.setID = @set_id
        GROUP BY Element.elementName, Element.designID
END;
GO

-- This procedure prints in how many sets a given lego element design occurs.
CREATE PROCEDURE InSets
    @design_id INTEGER
AS
BEGIN
    SELECT COUNT(DISTINCT Inventory.setID)
    FROM Inventory Join Element ON Inventory.elementID = Element.id
    WHERE Element.designID = @design_id
END;