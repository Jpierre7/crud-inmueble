CREATE DATABASE [CRUDINMUEBLE]
GO

USE CRUDINMUEBLE
GO

CREATE TABLE [dbo].[Inmueble](
	[InmuebleID] [int] IDENTITY(1,1) NOT NULL,	
	[TipoInmuebleID] [int] NULL,
	[Direccion] [nvarchar](150) NULL,
	[Cantidad_Habitaciones] [int] NULL,
	[Estado_Inmueble] [varchar](100) NULL,
	[Disponibilidad] [varchar](100) NULL,
	[Ciudad] [varchar](50) NULL,
	[Fecha_Creacion] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[InmuebleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TipoInmueble](
	[TipoInmuebleID] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Fecha_Creacion] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[TipoInmuebleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Inmueble] ON 

INSERT [dbo].[Inmueble] ([InmuebleID], [TipoInmuebleID], [Direccion], [Cantidad_Habitaciones], [Estado_Inmueble], [Disponibilidad], [Ciudad], [Fecha_Creacion]) VALUES (1, 1, N'Av. Arequipa - Jesus Maria', 4, N'Nuevo', N'Disponible', N'Lima', CAST(N'2024-09-29' AS Date))
INSERT [dbo].[Inmueble] ([InmuebleID], [TipoInmuebleID], [Direccion], [Cantidad_Habitaciones], [Estado_Inmueble], [Disponibilidad], [Ciudad], [Fecha_Creacion]) VALUES (2, 1, N'Av. Universitaria - Cercado de Lima', 2, N'Usado', N'Alquilado', N'Lima', CAST(N'2024-09-29' AS Date))
INSERT [dbo].[Inmueble] ([InmuebleID], [TipoInmuebleID], [Direccion], [Cantidad_Habitaciones], [Estado_Inmueble], [Disponibilidad], [Ciudad], [Fecha_Creacion]) VALUES (3, 1, N'Av. Mansiche - Trujillo', 1, N'Nuevo', N'Vendido', N'Trujillo', CAST(N'2024-09-29' AS Date))
INSERT [dbo].[Inmueble] ([InmuebleID], [TipoInmuebleID], [Direccion], [Cantidad_Habitaciones], [Estado_Inmueble], [Disponibilidad], [Ciudad], [Fecha_Creacion]) VALUES (4, 1, N'Av. Peru - Trujillo', 3, N'Nuevo', N'Disponible', N'Trujillo', CAST(N'2024-09-29' AS Date))
SET IDENTITY_INSERT [dbo].[Inmueble] OFF
GO
SET IDENTITY_INSERT [dbo].[TipoInmueble] ON 

INSERT [dbo].[TipoInmueble] ([TipoInmuebleID], [Descripcion], [Fecha_Creacion]) VALUES (1, N'Casa', CAST(N'2024-09-29' AS Date))
INSERT [dbo].[TipoInmueble] ([TipoInmuebleID], [Descripcion], [Fecha_Creacion]) VALUES (2, N'Apartamento', CAST(N'2024-09-29' AS Date))
INSERT [dbo].[TipoInmueble] ([TipoInmuebleID], [Descripcion], [Fecha_Creacion]) VALUES (3, N'Local Comercial', CAST(N'2024-09-29' AS Date))
INSERT [dbo].[TipoInmueble] ([TipoInmuebleID], [Descripcion], [Fecha_Creacion]) VALUES (4, N'Terreno', CAST(N'2024-09-29' AS Date))
SET IDENTITY_INSERT [dbo].[TipoInmueble] OFF
GO
ALTER TABLE [dbo].[Inmueble]  WITH CHECK ADD FOREIGN KEY([TipoInmuebleID])
REFERENCES [dbo].[TipoInmueble] ([TipoInmuebleID])
GO

--GET LIST INMUEBLES
CREATE PROCEDURE SP_GETLIST_INMUEBLES
AS
BEGIN 
SELECT
	i.InmuebleID,
	i.Direccion,
	i.Cantidad_Habitaciones AS CantidadHabitaciones,
	i.Estado_Inmueble AS EstadoInmueble,
	i.Disponibilidad,
	i.Ciudad,
	i.Fecha_Creacion AS FechaCreacion,
	ti.Descripcion
FROM Inmueble i INNER JOIN TipoInmueble ti
ON ti.TipoInmuebleID = i.TipoInmuebleID
FOR JSON AUTO
END;
GO

--CREATE NEW INMUEBLE
CREATE PROCEDURE SP_INSERT_INMUEBLE 
	@direccion nvarchar(150),
	@cantHabitaciones int, 
	@estadoInmueble nvarchar(50),
	@disponibilidad nvarchar(50),
	@ciudad nvarchar(50),
	@tipoInmueble int
AS
BEGIN 
	INSERT INTO Inmueble(Direccion, Cantidad_Habitaciones, Estado_Inmueble, Disponibilidad, Ciudad, TipoInmuebleID, Fecha_Creacion)
	VALUES(@direccion, @cantHabitaciones, @estadoInmueble, @disponibilidad, @ciudad, @tipoInmueble, getdate())

	SELECT
		i.InmuebleID,
		i.Direccion,
		i.Cantidad_Habitaciones AS CantidadHabitaciones,
		i.Estado_Inmueble AS EstadoInmueble,
		i.Disponibilidad,
		i.Ciudad,
		i.Fecha_Creacion AS FechaCreacion,
		ti.Descripcion
	FROM Inmueble i INNER JOIN TipoInmueble ti
		ON ti.TipoInmuebleID = i.TipoInmuebleID
	WHERE InmuebleID = SCOPE_IDENTITY()
	FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER
END;
GO

--UPDATE INMUEBLE 
CREATE PROCEDURE SP_UPDATE_INMUEBLE 
	@idInmueble int, 
	@direccion nvarchar(150),
	@cantHabitaciones int, 
	@estadoInmueble nvarchar(50),
	@disponibilidad nvarchar(50),
	@ciudad nvarchar(50),
	@tipoInmueble int
AS
BEGIN
	UPDATE Inmueble
	SET Direccion = @direccion, Cantidad_Habitaciones = @cantHabitaciones, Estado_Inmueble = @estadoInmueble, Disponibilidad = @disponibilidad, Ciudad = @ciudad, TipoInmuebleID = @tipoInmueble
	WHERE InmuebleID = @idInmueble
END;
GO

--DELETE INMUEBLE
CREATE PROCEDURE SP_DELETE_INMUEBLE 
@idInmueble int 
AS
BEGIN
DELETE FROM Inmueble WHERE InmuebleID = @idInmueble
END;
