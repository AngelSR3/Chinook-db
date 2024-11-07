###### 🛸AngelDev🛸

---
# Bienvenido a ChinookDB 🎸
⚠️➡︎ Base de datos totalmente funcional para la gestión y manejo de datos --> Chinook

---
## Tabla de contenidos 📋
- [Instalación](#Instalación) 
- [¿Como usar?](#Como_usar) 
- [Tecnologías usadas](#Tecnologías)
- [Funcionalidad](#Funcionalidad)
- [Autor/es](#Autor)
---
## 👽️Hecho por:
- [Angel Simanca](#Autor)

---
## Instalación📂
> [!TIP]
>Sigue cada uno de los siguientes pasos sin saltarte ningúno para la correcta instalación
#### Rquisitos minimos para la ejecución
- Windows 8 o superior 64-bits
- macOS Mojave (10.14) o superior
- Distribuciones de Linux como Ubuntu 20.04 y posteriores (64-bit)
- Procesador: 1 GHz o más rápido
- RAM: 4 GB (se recomienda 8 GB o más)
- Espacio en disco: 1 GB de espacio libre
- CONEXIÓN A INTERNET

#### Correcta Instalación
- Descarga o clona el actual repositorio
- Descomprime el archivo descargado
- Realiza la instalación correspondiente de MySQL
- (OPCIONAL) --> Instala Workbench
- Ejecuta cada uno de los Archivos descargados en Workbench
- (OPCIONAL) --> Instala la extención MySQL
- [¿Como instalo la extención en VSCODE](https://www.youtube.com/shorts/Et1DDO4a_Ys)
- Ejecuta cada Creación, inserción y demás desde VisualStudioCode
> [!TIP]
>Ejecuta en este orden los archivos [ddl.sql --> dml.sql --> Demás]
---
## Como_usar💼
> [!WARNING]
>Asegurate de hacer cada uno de todos estos pasos...
- Realizar correcta instalación (Ejecución ddl y dml)
#### Realizar cada consulta
- Puedes hacerlo desde VisualStudioCode con la extención MySQL
- Simplemente clickeamos "RUN" inicialmente al ```USE Chinook```
- Seguido de esto, clickeamos en "RUN" a cada una de las consultas que deseemos hacer
- #### De esta manera ejecutaremos toda la DataBase, haciendo uso de la extención
- En caso que no usen la extención, podran copiar y pegar todo el contenido de la Base de Datos en el terminar de su pc, haciendo uso de MySQL en terminal
- [Tutorial de como usar MySQL en terminal Windows](https://www.youtube.com/watch?v=2N79qVfC_I8)
- [Tutorial de como usar MySQL en terminal Linux](https://www.youtube.com/watch?v=wID839p6RYE)
---
## Estructura DataBase
- Se crearon las tablas necesarias para el control y gestión de datos de Chinook, la cual es una tienda de musica
- Tablas para el control de facturas, están relacionadas con clientes, albumes y tracks, para saber que procesos se llevan a cabo.
---
## Ejemplos de Consultas
1. Esta consulta busca el empleado que ha generado la mayor cantidad de ventas en el ultimo trimestre
```sql
SELECT e.FirstName, e.LastName, COUNT(i.InvoiceId) AS TotalVentas
FROM Employee e
JOIN Invoice i ON e.EmployeeId = i.CustomerId
WHERE i.InvoiceDate >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY e.EmployeeId
ORDER BY TotalVentas DESC
LIMIT 1;
```
2. Esta consulta lista los cinco artistas con mán canciones vendidas en el ultimo año
```sql
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
```
3. Esta consulta obtiene el total de ventas y la cantidad de canciones vendidas por país
```sql 
SELECT c.Country AS Pais, SUM(i.Total) AS TotalVentas, COUNT(t.TrackId) AS TotalCancionesVendidas
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
JOIN Track t ON il.TrackId = t.TrackId
GROUP BY c.Country
ORDER BY TotalVentas DESC;
```
---
## Tecnologías📱
- MySQL
- VisualStudioCode
- Extención MySQL / Workbench
---
---
## Funcionalidad💭
> [!IMPORTANT]  
> Funcionalidades educativas únicamente
- Gestionar base de datos de Tienda de musica
- Visualizar relación y creacion de tablas
---
### Creación DB
- Se creó el respectivo DIAGRAMA E-R
- Se creó el respectivo DDL (Creación de base de datos,tablas y relaciones)
- Se creó el respectivo DML (Inserciones de datos)
- Se creó el respectivo DQL (Consultas)
- Se creó el respectivo DQL_funciones (Funciones)
- Se creó el respectivo DQL_triggers (Triggers)
- Se creó el respectivo DQL_eventos (Eventos)

---
## Autor👨‍💻
#### "Codifica tus sueños"

> Angel Simanca
- Email : 		Angelduvan1016@gmail.com
- LinkedIn : 	www.linkedin.com/in/Angelsr3
- GitHub :		https://github.com/AngelSR3
