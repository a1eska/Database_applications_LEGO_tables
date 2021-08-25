
-- Colorless inventory for set 2161
EXECUTE ColorlessInventory 2167;
-- Colorless inventory for set 4651
EXECUTE ColorlessInventory 4651;
-- Colorless inventory for set 4294
EXECUTE ColorlessInventory 4294;

-- Show in how many lego sets is element with design Plate 2X3
EXECUTE InSets 3021;
-- Show in how many lego sets is element with design Roof Tiles 2X2
EXECUTE InSets 3039;

SELECT * FROM LEGOSET
SELECT * FROM THEME
SELECT * FROM ELEMENT
SELECT * FROM DESIGN
SELECT * FROM Color
SELECT * FROM INVENTORY
SELECT * FROM MINIFIGURE


-- try to delete 
Delete FROM LegoSet
WHERE LegoSet.releaseYear > 2000
