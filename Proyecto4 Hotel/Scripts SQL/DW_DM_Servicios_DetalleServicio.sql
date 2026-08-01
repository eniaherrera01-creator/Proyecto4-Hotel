/* =====================================================================
   DESTINO (DW) - Base: DW Sistema_Hotel
   Tablas destino de mis dimensiones nuevas:
     DM Servicios          <- origen Servicios
     DM Detalle_Servicio   <- origen Detalle_Servicio
   Ejecutar sobre la base DW Sistema_Hotel (servidor DAVIDAGUILERA\MSSQLSERVER02)
   ===================================================================== */
USE [DW Sistema_Hotel];
GO

IF OBJECT_ID(N'[dbo].[DM Detalle_Servicio]', N'U') IS NOT NULL DROP TABLE [dbo].[DM Detalle_Servicio];
IF OBJECT_ID(N'[dbo].[DM Servicios]', N'U') IS NOT NULL DROP TABLE [dbo].[DM Servicios];
GO

/* ---------------------- DM Servicios ---------------------- */
CREATE TABLE [dbo].[DM Servicios](
    [IdServicio]  [int] NOT NULL,
    [Nombre]      [nvarchar](100) NULL,
    [Descripcion] [nvarchar](200) NULL,
    [Precio]      [numeric](10,2) NULL,
    [Estado]      [nvarchar](20) NULL,
    CONSTRAINT [PK_DM_Servicios] PRIMARY KEY CLUSTERED ([IdServicio] ASC)
);
GO

/* ---------------------- DM Detalle_Servicio ---------------------- */
CREATE TABLE [dbo].[DM Detalle_Servicio](
    [IdDetalleServicio] [int] NOT NULL,
    [IdReservacion]     [int] NULL,
    [IdServicio]        [int] NULL,
    [Cantidad]          [int] NULL,
    [Precio]            [numeric](10,2) NULL,
    [Subtotal]          [numeric](10,2) NULL,
    CONSTRAINT [PK_DM_Detalle_Servicio] PRIMARY KEY CLUSTERED ([IdDetalleServicio] ASC)
);
GO

/* (Opcional) Limpiar datos erroneos cargados antes en las dimensiones de Rafael:
   TRUNCATE TABLE [dbo].[DM Detalle_Reservacion];
   TRUNCATE TABLE [dbo].[DM Habitaciones];
*/
