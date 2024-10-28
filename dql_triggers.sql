--* Trigger 1: Al realizar una venta, actualiza el total de ventas acumuladas por el empleado correspondiente

DELIMITER //

CREATE TRIGGER ActualizarTotalVentasEmpleado
AFTER INSERT ON InvoiceLine
FOR EACH ROW
BEGIN
    UPDATE InvoiceLine
    SET Quantity= Quantity + NEW.Quantity
    WHERE InvoiceId;
END //

DELIMITER ;

--* Trigger 2: Cada vez que se modifica un cliente, registra el cambio en una tabla de auditoría

DELIMITER //

CREATE TRIGGER AuditarActualizacionCliente
AFTER UPDATE ON Customer
FOR EACH ROW
BEGIN
    INSERT INTO AuditoriaClientes
    (CustomerId, NombreAntiguo, NombreNuevo, ApellidoAntiguo, ApellidoNuevo, EmailAntiguo, EmailNuevo, FechaCambio)
    VALUES
    (NEW.CustomerId, OLD.FirstName, NEW.FirstName, OLD.LastName, NEW.LastName, OLD.Email, NEW.Email, NOW());
END //

DELIMITER ;

--* Trigger 3: Guarda el historial de cambios en el precio de las canciones

DELIMITER //

CREATE TRIGGER RegistrarHistorialPrecioCancion
AFTER UPDATE ON Track
FOR EACH ROW
BEGIN
    INSERT INTO HistorialPrecioCancion
    (TrackId, PrecioAntiguo, PrecioNuevo, FechaCambio)
    VALUES
    (NEW.TrackId, OLD.UnitPrice, NEW.UnitPrice, NOW());
END //

DELIMITER ;

--* Trigger 4: Registra una notificación cuando se elimina un registro de venta

DELIMITER //

CREATE TRIGGER NotificarCancelacionVenta
AFTER DELETE ON InvoiceLine
FOR EACH ROW
BEGIN
    INSERT INTO NotificacionesCancelacionVentas
    (InvoiceLineId, TrackId, CantidaCancelada, FechaCancelacion)
    VALUES
    (OLD.InvoiceLineId, OLD.TrackId, OLD.Quantity, NOW());
END //

DELIMITER ;

--* Trigger 5: Evita que un cliente con saldo deudor realice nuevas compras

DELIMITER //

CREATE TRIGGER RestringirCompraConSaldoDeudor
BEFORE INSERT ON Invoice
FOR EACH ROW
BEGIN
    DECLARE SaldoDeudor DECIMAL;
    
    SELECT Saldo INTO SaldoDeudor
    FROM Customer
    WHERE CustomerId = NEW.CustomerId;

    IF SaldoDeudor > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede realizar la compra, el cliente tiene una o mán deudas pendientes';
        ROLLBACK;
        END IF;

END //

DELIMITER 