/*
Lego database. 

The lego database consists of two basic objects: lego sets and lego elements
(lego pieces). Each set has a unique identifier and consists of at least one lego element; it is possible
that there are multiple elements of the same type. Each lego set belongs to a certain theme (e.g.
Harry Potter, City, Technic, etc.). 
A lego set can possibly contain some mini figures (these
represent humans in the lego world). Each lego element can belong to a lego set, but it does not
have to. Each lego element has a unique identifier and a category attribute (duplo, system, technic,
etc.). Two lego elements may have the same design, but a different color (e.g. a 2x4 brick may come
in many different colors). Each design and color is identified by a unique identifier. (Note that
historically element identifiers were composed from design and color identifiers, but this is no
longer true, thus, each element needs a unique identifier.) Finally, each mini figure belongs to some
lego set and consists of at least three lego elements.
*/

-- Creations of tables

-- Lego element design
CREATE TABLE Design
(
    id INTEGER CONSTRAINT Design_PK PRIMARY KEY,
    category NVARCHAR(100) NOT NULL
);

-- Lego element color
CREATE TABLE Color
(
    id INTEGER CONSTRAINT Color_PK PRIMARY KEY,
    colorName NVARCHAR(20) NOT NULL,
);

-- Lego element
CREATE TABLE Element
(
    id INTEGER CONSTRAINT Element_PK PRIMARY KEY,
    elementName NVARCHAR(50) NOT NULL,
    designID INTEGER CONSTRAINT Element_FK_design REFERENCES Design(id),
    colorID INTEGER CONSTRAINT Color_FK_color REFERENCES Color(id),
);

-- Lego set theme
CREATE TABLE Theme
(
    id INTEGER IDENTITY(1, 1) CONSTRAINT Theme_PK PRIMARY KEY,
    themeName NVARCHAR(50) NOT NULL,
);

-- Lego set
CREATE TABLE LegoSet
(
    id INTEGER CONSTRAINT LegoSet_PK PRIMARY KEY,
    setName NVARCHAR(50) NOT NULL,
    releaseYear INTEGER CONSTRAINT Lego_CHK_Year CHECK (releaseYear >= 1949),
    themeID INTEGER CONSTRAINT legoSet_FK_theme REFERENCES Theme(id)
);

-- Lego Minifigure
CREATE TABLE Minifigure
(
    id INTEGER CONSTRAINT Minifigure_PK PRIMARY KEY,
    themeID INTEGER CONSTRAINT Minifigure_FK_theme REFERENCES Theme(id),
    setID INTEGER CONSTRAINT Minifigure_FK_set REFERENCES LegoSet(id)
);

-- Lego Inventory, relation representing which set contains which element
CREATE TABLE Inventory
(
    --association table M:N between Element and LegoSet
    setID INTEGER 
        CONSTRAINT Inventory_FK_LegoSet REFERENCES LegoSet(id),
    elementID INTEGER 
        CONSTRAINT Inventory_FK_Element REFERENCES Element(id),
    quantity INTEGER NOT NULL 
        CONSTRAINT Inventory_CHK_quantity CHECK (quantity > 0),
        CONSTRAINT Inventory_PK PRIMARY KEY (setID, elementID)
);
