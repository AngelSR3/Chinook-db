--* Consulta 1: Empleado que ha generado la mayor cantidad de ventas en el ultimo trimestre

SELECT e.FirstName, e.LastName, COUNT(i.InvoiceId) AS TotalVentas
FROM Employee e
JOIN Invoice i ON e.EmployeeId = i.CustomerId
WHERE i.InvoiceDate >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY e.EmployeeId
ORDER BY TotalVentas DESC
LIMIT 1;

--* Consulta 2: Listar los cinco artistas con mán canciones vendidas en el ultimo año

SELECT a.ArtistId, a.Name AS Artista, COUNT(t.TrackId) AS TotalCancionesVendidas
FROM Artist a
JOIN Album al ON a.ArtistId = al.ArtistId
JOIN Track t ON al.AlbumId = t.AlbumId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
JOIN Invoice i ON il.InvoiceId = i.InvoiceId
WHERE i.InvoiceDate >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY a.ArtistId
ORDER BY TotalCancionesVendidas DESC
LIMIT 5;

--* Consulta 3: Obtener el total de ventas y la cantidad de canciones vendidas por país

SELECT c.Country AS Pais, SUM(i.Total) AS TotalVentas, COUNT(t.TrackId) AS TotalCancionesVendidas
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
JOIN Track t ON il.TrackId = t.TrackId
GROUP BY c.Country
ORDER BY TotalVentas DESC;

--* Consulta 4: Calcular el número total de clientes que realizaron compras por cada género en un mes especifico

SELECT g.Name AS Genero, COUNT(DISTINCT c.CustomerId) AS TotalClientes
FROM Genre g
JOIN Track t ON g.GenreId = t.GenreId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
JOIN Invoice i ON il.InvoiceId = i.InvoiceId
JOIN Customer c ON i.CustomerId = c.CustomerId
WHERE MONTH(i.InvoiceDate) = "mes"
GROUP BY g.Name;

--* Consulta 5: Encuentra a los clientes que han comprado todas las canciones de un mismo álbum

SELECT c.CustomerId, c.FirstName, c.LastName
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
JOIN Track t ON il.TrackId = t.TrackId
JOIN Album al ON t.AlbumId = al.AlbumId
GROUP BY c.CustomerId, al.AlbumId
HAVING COUNT(DISTINCT t.TrackId) = (
    SELECT COUNT(*)
    FROM Track
    WHERE AlbumId = al.AlbumId
);

--* Consulta 6: Lista los tres países con mayores ventas durante el último semestre

SELECT c.Country AS Pais, SUM(i.Total) AS TotalVentas
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
WHERE i.InvoiceDate >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY c.Country
ORDER BY TotalVentas DESC
LIMIT 3;

--* Consulta 7: Muestra los cinco géneros menos vendidos en el último año

SELECT g.Name AS Genero, COUNT(DISTINCT t.TrackId) AS TotalCancionesVendidas
FROM Genre g
JOIN Track t ON g.GenreId = t.GenreId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
JOIN Invoice i ON il.InvoiceId = i.InvoiceId
WHERE i.InvoiceDate >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY g.Name
ORDER BY TotalCancionesVendidas ASC
LIMIT 5;

--* Consulta 8: Calcula el promedio de edad de los empleados al momento de su primera compra

SELECT AVG(YEAR(CURDATE()) - YEAR(e.BirthDate)) AS PromedioEdad
FROM Employee e
JOIN Invoice i ON e.EmployeeId = i.CustomerId
WHERE i.InvoiceDate = (
    SELECT MIN(InvoiceDate)
    FROM Invoice
);

--* Consulta 9: Encuentra los cinco empleados que realizaron más ventas de Rock

SELECT e.FirstName, e.LastName, COUNT(DISTINCT il.TrackId) AS TotalCancionesVendidas
FROM Employee e
JOIN Invoice i ON e.EmployeeId = i.CustomerId
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
JOIN Track t ON il.TrackId = t.TrackId
JOIN Genre g ON t.GenreId = g.GenreId
WHERE g.Name = "Rock"
GROUP BY e.EmployeeId
ORDER BY TotalCancionesVendidas DESC
LIMIT 5;

--* Consulta 10: Genera un informe de los clientes con más compras recurrentes

SELECT c.CustomerId, c.FirstName, c.LastName, COUNT(i.InvoiceId) AS TotalCompras
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId
HAVING TotalCompras > 1
ORDER BY TotalCompras DESC;

--* Consulta 11: Calcula el precio promedio de venta por género

SELECT g.Name AS Genero, AVG(t.UnitPrice) AS PrecioPromedio
FROM Genre g
JOIN Track t ON g.GenreId = t.GenreId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
JOIN Invoice i ON il.InvoiceId = i.InvoiceId
GROUP BY g.Name;

--* Consulta 12: Lista las cinco canciones más largas vendidas en el último año

SELECT t.Name AS Cancion, t.Milliseconds AS Duracion_En_Milisegundos
FROM Track t
JOIN InvoiceLine il ON t.TrackId = il.TrackId
JOIN Invoice i ON il.InvoiceId = i.InvoiceId
WHERE i.InvoiceDate >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
ORDER BY Duracion_En_Milisegundos DESC
LIMIT 5;

--* Consulta 13: Muestra los clientes que compraron más canciones de Jazz

SELECT c.CustomerId, c.FirstName, c.LastName, COUNT(DISTINCT t.TrackId) AS TotalCancionesVendidas
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
JOIN Track t ON il.TrackId = t.TrackId
JOIN Genre g ON t.GenreId = g.GenreId
WHERE g.Name = "Jazz"
GROUP BY c.CustomerId
ORDER BY TotalCancionesVendidas DESC;

--* Consulta 14: Encuentra la cantidad total de minutos comprados por cada cliente en el último mes

SELECT c.CustomerId, c.FirstName, c.LastName, SUM(t.Milliseconds) / 60000 AS TotalMinutosComprados
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
JOIN Track t ON il.TrackId = t.TrackId
WHERE i.InvoiceDate >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY c.CustomerId
ORDER BY TotalMinutosComprados DESC;

--* Consulta 15: Muestra el número de ventas diarias de canciones en cada mes del último trimestre

SELECT MONTHNAME(i.InvoiceDate) AS Mes, COUNT(DISTINCT il.TrackId) AS TotalCancionesVendidas
FROM Invoice i
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
WHERE i.InvoiceDate >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY Mes
ORDER BY Mes;

--* Consulta 16: Calcula el total de ventas por cada vendedor en el último semestre

SELECT e.FirstName, e.LastName, SUM(i.Total) AS TotalVentas
FROM Employee e
JOIN Invoice i ON e.EmployeeId = i.CustomerId
WHERE i.InvoiceDate >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY e.EmployeeId
ORDER BY TotalVentas DESC;

--* Consulta 17: Encuentra el cliente que ha realizado la compra más cara en el último año

SELECT c.CustomerId, c.FirstName, c.LastName, MAX(i.Total) AS TotalCompraMasCara
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
WHERE i.InvoiceDate >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY c.CustomerId
ORDER BY TotalCompraMasCara DESC
LIMIT 1;

--* Consulta 18: Lista los cinco álbumes con más canciones vendidas durante los últimos tres meses

SELECT al.AlbumId, al.Title AS Album, COUNT(DISTINCT t.TrackId) AS TotalCancionesVendidas
FROM Album al
JOIN Track t ON al.AlbumId = t.AlbumId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
JOIN Invoice i ON il.InvoiceId = i.InvoiceId
WHERE i.InvoiceDate >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY al.AlbumId
ORDER BY TotalCancionesVendidas DESC
LIMIT 5;

--* Consulta 19: Obtén la cantidad de canciones vendidas por cada género en el último mes

SELECT g.Name AS Genero, COUNT(DISTINCT t.TrackId) AS TotalCancionesVendidas
FROM Genre g
JOIN Track t ON g.GenreId = t.GenreId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
JOIN Invoice i ON il.InvoiceId = i.InvoiceId
WHERE i.InvoiceDate >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY g.Name
ORDER BY TotalCancionesVendidas DESC;

--* Consulta 20: Lista los clientes que no han comprado nada en el último año

SELECT c.CustomerId, c.FirstName, c.LastName
FROM Customer c
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
WHERE i.InvoiceId IS NULL;

