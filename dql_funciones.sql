--* Funcion 1: Calcular el gasto total de un cliente en un año específico
DELIMITER $$

CREATE FUNCTION TotalGastoClente (CustomerId INT, Year INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
MODIFIES SQL DATA
BEGIN
    DECLARE TotalGasto DECIMAL(10,2);
    SELECT SUM(IL.UnitPrice * IL.Quantity) INTO TotalGasto
    FROM Invoice I
    INNER JOIN InvoiceLine IL ON I.InvoiceId = IL.InvoiceId
    WHERE I.CustomerId = CustomerId AND YEAR(I.InvoiceDate) = Year;
    RETURN TotalGasto;
END $$
DELIMITER;

--* Funcion 2: Retorna el precio promedio de las canciones de un álbum
DELIMITER $$

CREATE FUNCTION PromedioPrecioPorAlbum (AlbumId INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE Promedio DECIMAL(10,2);
    SELECT AVG(UnitPrice) INTO Promedio
    FROM Track
    WHERE AlbumId = AlbumId;
    RETURN Promedio;
END $$
DELIMITER;

--* Funcion 3: Calcula la duración total de todas las canciones vendidas de un género específico

DELIMITER $$

CREATE FUNCTION DuracionTotalPorGenero (GeneroID INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE Duracion INT;
    SELECT SUM(Milliseconds) INTO Duracion
    FROM Track
    WHERE GenreId = GeneroID;
    RETURN Duracion;
END $$
DELIMITER;

--* Funcion 4: Calcula el descuento a aplicar basado en la frecuencia de compra del cliente

DELIMITER $$

CREATE FUNCTION DescuentoPorFrecuencia (CustomerId INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE Descuento DECIMAL(10,2);
    DECLARE Compras INT;
    SELECT COUNT(*) INTO Compras
    FROM Invoice
    WHERE CustomerId = CustomerId;
    IF Compras > 10 THEN
        SET Descuento = 0.10;
    ELSEIF Compras > 5 THEN
        SET Descuento = 0.05;
        ELSE
        SET Descuento = 0.00;
        END IF;
    RETURN Descuento;
END $$
DELIMITER;

--* Funcion 5: Verifica si un cliente es "VIP" basándose en sus gastos anuales
DELIMITER $$

CREATE FUNCTION VerificarClienteVIP (CustomerId INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE TotalGasto DECIMAL(10,2);
    SELECT TotalGastoClente(CustomerId, YEAR(CURRENT_DATE)) INTO TotalGasto;
    IF TotalGasto > 10000 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END $$
DELIMITER;