/* =====================================================================
   ORIGEN (OLTP) - Base: Sistema_Hotel
   Tablas nuevas: Servicios y Detalle_Servicio
   - Servicios: catalogo de servicios extra del hotel (50 registros)
   - Detalle_Servicio: servicios consumidos por reservacion (300+ registros)
   Ejecutar sobre la base Sistema_Hotel (servidor DAVIDAGUILERA\MSSQLSERVER02)
   ===================================================================== */
USE [Sistema_Hotel];
GO

/* Re-ejecutable: se borran primero (Detalle_Servicio depende de Servicios) */
IF OBJECT_ID(N'[dbo].[Detalle_Servicio]', N'U') IS NOT NULL DROP TABLE [dbo].[Detalle_Servicio];
IF OBJECT_ID(N'[dbo].[Servicios]', N'U') IS NOT NULL DROP TABLE [dbo].[Servicios];
GO

/* ---------------------- Tabla Servicios (catalogo) ---------------------- */
CREATE TABLE [dbo].[Servicios](
    [IdServicio]  [int] IDENTITY(1,1) NOT NULL,
    [Nombre]      [varchar](100) NOT NULL,
    [Descripcion] [varchar](200) NULL,
    [Precio]      [decimal](10,2) NULL,
    [Estado]      [varchar](20) NULL,
    CONSTRAINT [PK_Servicios] PRIMARY KEY CLUSTERED ([IdServicio] ASC)
);
GO

/* ------------- Tabla Detalle_Servicio (se relaciona con Reservaciones) ------------- */
CREATE TABLE [dbo].[Detalle_Servicio](
    [IdDetalleServicio] [int] IDENTITY(1,1) NOT NULL,
    [IdReservacion]     [int] NULL,
    [IdServicio]        [int] NULL,
    [Cantidad]          [int] NULL,
    [Precio]            [decimal](10,2) NULL,
    [Subtotal]          [decimal](10,2) NULL,
    CONSTRAINT [PK_Detalle_Servicio] PRIMARY KEY CLUSTERED ([IdDetalleServicio] ASC)
);
GO
ALTER TABLE [dbo].[Detalle_Servicio] WITH CHECK
    ADD CONSTRAINT [FK_DetServ_Reservacion] FOREIGN KEY([IdReservacion])
    REFERENCES [dbo].[Reservaciones] ([IdReservacion]);
GO
ALTER TABLE [dbo].[Detalle_Servicio] WITH CHECK
    ADD CONSTRAINT [FK_DetServ_Servicio] FOREIGN KEY([IdServicio])
    REFERENCES [dbo].[Servicios] ([IdServicio]);
GO

/* ---------------------- 50 registros de Servicios ---------------------- */
INSERT INTO [dbo].[Servicios] ([Nombre],[Descripcion],[Precio],[Estado]) VALUES
('Masaje relajante','Masaje corporal de 60 minutos',45.00,'Activo'),
('Masaje descontracturante','Masaje terapeutico de espalda',55.00,'Activo'),
('Facial hidratante','Tratamiento facial con hidratacion profunda',40.00,'Activo'),
('Sauna','Acceso a sauna por sesion',20.00,'Activo'),
('Jacuzzi','Acceso a jacuzzi por sesion',25.00,'Activo'),
('Bano turco','Acceso a bano turco',22.00,'Activo'),
('Manicure','Servicio de manicure',18.00,'Activo'),
('Pedicure','Servicio de pedicure',20.00,'Activo'),
('Aromaterapia','Sesion de aromaterapia',35.00,'Activo'),
('Reflexologia','Masaje de reflexologia podal',30.00,'Activo'),
('Desayuno buffet','Desayuno buffet por persona',12.00,'Activo'),
('Almuerzo ejecutivo','Almuerzo de tres tiempos',18.00,'Activo'),
('Cena romantica','Cena para dos con decoracion',60.00,'Activo'),
('Room service','Servicio a la habitacion',15.00,'Activo'),
('Bar abierto','Barra libre por persona por hora',25.00,'Activo'),
('Botella de vino','Botella de vino de la casa',30.00,'Activo'),
('Coctel de bienvenida','Coctel de bienvenida por persona',8.00,'Activo'),
('Menu infantil','Menu especial para ninos',10.00,'Activo'),
('Servicio de cafeteria','Cafe y bebidas calientes',6.00,'Activo'),
('Picnic','Canasta de picnic para dos',35.00,'Activo'),
('Traslado aeropuerto','Transporte aeropuerto-hotel',40.00,'Activo'),
('Renta de auto','Alquiler de vehiculo por dia',55.00,'Activo'),
('Tour en bus','Tour panoramico en bus',28.00,'Activo'),
('Servicio de taxi','Taxi dentro de la ciudad',15.00,'Activo'),
('Estacionamiento VIP','Estacionamiento techado por noche',10.00,'Activo'),
('Lavado de ropa','Lavado por carga',12.00,'Activo'),
('Planchado','Planchado por prenda',3.00,'Activo'),
('Tintoreria','Limpieza en seco por prenda',7.00,'Activo'),
('Lustrado de zapatos','Servicio de lustrado',4.00,'Activo'),
('Tour ciudad','Recorrido guiado por la ciudad',30.00,'Activo'),
('Tour playa','Excursion a la playa',35.00,'Activo'),
('Buceo','Inmersion de buceo con guia',80.00,'Activo'),
('Snorkel','Alquiler de equipo y guia de snorkel',40.00,'Activo'),
('Paseo a caballo','Paseo a caballo de una hora',45.00,'Activo'),
('Alquiler de bicicleta','Bicicleta por dia',15.00,'Activo'),
('Clase de yoga','Sesion de yoga grupal',20.00,'Activo'),
('Entrada al gimnasio','Acceso diario al gimnasio',10.00,'Activo'),
('Acceso a piscina','Acceso a piscina para no huespedes',12.00,'Activo'),
('Excursion volcan','Excursion guiada al volcan',65.00,'Activo'),
('Sala de reuniones','Alquiler de sala por hora',50.00,'Activo'),
('Alquiler de proyector','Proyector para eventos por dia',25.00,'Activo'),
('Servicio de impresion','Impresion de documentos por hoja',0.50,'Activo'),
('Internet premium','Internet de alta velocidad por dia',8.00,'Activo'),
('Coffee break empresarial','Coffee break por persona',9.00,'Activo'),
('Late check-out','Salida tardia hasta las 18:00',25.00,'Activo'),
('Early check-in','Ingreso anticipado desde las 8:00',25.00,'Activo'),
('Cuna para bebe','Cuna adicional en habitacion',10.00,'Activo'),
('Decoracion especial','Decoracion de habitacion para ocasion',40.00,'Activo'),
('Caja fuerte','Alquiler de caja fuerte por noche',5.00,'Activo'),
('Servicio de ninera','Cuidado de ninos por hora',12.00,'Activo');
GO

/* --------- 300+ registros de Detalle_Servicio con FKs validas --------- */
DECLARE @rcount int = (SELECT COUNT(*) FROM [dbo].[Reservaciones]);
IF @rcount = 0
BEGIN
    PRINT 'ADVERTENCIA: No hay filas en Reservaciones; no se genero Detalle_Servicio.';
END
ELSE
BEGIN
    DECLARE @per int = (300 / @rcount) + 2;  -- filas por reservacion -> garantiza 300+
    ;WITH Nums AS (
        SELECT TOP (@per) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
        FROM sys.all_objects
    )
    INSERT INTO [dbo].[Detalle_Servicio] ([IdReservacion],[IdServicio],[Cantidad],[Precio],[Subtotal])
    SELECT  r.[IdReservacion],
            s.[IdServicio],
            c.Cantidad,
            s.[Precio],
            s.[Precio] * c.Cantidad
    FROM        [dbo].[Reservaciones] r
    CROSS JOIN  Nums
    CROSS APPLY (SELECT TOP 1 [IdServicio],[Precio] FROM [dbo].[Servicios] ORDER BY NEWID()) s
    CROSS APPLY (SELECT (ABS(CHECKSUM(NEWID())) % 3) + 1 AS Cantidad) c;
END
GO

/* ---------------------------- Verificacion ---------------------------- */
SELECT COUNT(*) AS Total_Servicios       FROM [dbo].[Servicios];
SELECT COUNT(*) AS Total_DetalleServicio FROM [dbo].[Detalle_Servicio];
GO
