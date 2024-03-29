USE [RNDetenciones]
GO
/****** Object:  StoredProcedure [dbo].[SP_RND_reincidentes_det]    Script Date: 16/01/2024 03:32:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		JLCR 
-- Create date: 16 Enero 2024
-- Description: datos del RND para generar detalle
-- =============================================
ALTER PROCEDURE [dbo].[SP_RND_reincidentes_det]
@idestad int,
@fecfin  date,
@nombre  varchar(200),
@paterno varchar(200),
@materno varchar(200),
@fecnacimiento varchar(12)

WITH EXEC AS CALLER
AS
BEGIN 
    BEGIN TRY

      DECLARE @fecini date;

      SET @fecini = dateadd(year, -1, @fecfin)

		SELECT ROW_NUMBER() OVER(ORDER BY d.id_detenido ASC) AS reg
		, dt.id_detencion
		, d.id_detenido
		, p.id_puesta_disposicion
		, d.folio_detenido
		, REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),rtrim(lTRIM(replace(replace(replace(replace(replace(UPPER(d.nombre), 'Á', 'A' ), 'É', 'E' ), 'Í', 'I' ), 'Ó', 'O' ), 'Ú', 'U' )))),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') as nombre
		, REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),rtrim(lTRIM(replace(replace(replace(replace(replace(UPPER(d.apellido_paterno), 'Á', 'A' ), 'É', 'E' ), 'Í', 'I' ), 'Ó', 'O' ), 'Ú', 'U' )))),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') as apellido_paterno
		, REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),rtrim(lTRIM(replace(replace(replace(replace(replace(UPPER(d.apellido_materno), 'Á', 'A' ), 'É', 'E' ), 'Í', 'I' ), 'Ó', 'O' ), 'Ú', 'U' )))),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') as apellido_materno
		, dc.CURP
		, d.fecha_nacimiento
		, dt.fecha_detencion
			--	into #Temregtotedo
		FROM RNDetenciones.dbo.detenidos d 
		inner join RNDetenciones.dbo.detenciones dt on dt.id_detencion=d.id_detencion
		left join RNDetenciones.dbo.puesta_disposiciones p on p.id_detenido=d.id_detenido and p.es_borrado = 0
		left join RNDetenciones.dbo.detenidos_datoscomplementarios dc on dc.id_puesta_disposicion=p.id_puesta_disposicion 

		where dt.id_entidad = @idestad
		and dt.fecha_detencion >= @fecini and dt.fecha_detencion <= @fecfin
		and REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),rtrim(lTRIM(replace(replace(replace(replace(replace(UPPER(d.nombre), 'Á', 'A' ), 'É', 'E' ), 'Í', 'I' ), 'Ó', 'O' ), 'Ú', 'U' )))),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') = @nombre
		and REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),rtrim(lTRIM(replace(replace(replace(replace(replace(UPPER(d.apellido_paterno), 'Á', 'A' ), 'É', 'E' ), 'Í', 'I' ), 'Ó', 'O' ), 'Ú', 'U' )))),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') = @paterno
		and REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),rtrim(lTRIM(replace(replace(replace(replace(replace(UPPER(d.apellido_materno), 'Á', 'A' ), 'É', 'E' ), 'Í', 'I' ), 'Ó', 'O' ), 'Ú', 'U' )))),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') = @materno
		and ISNULL(cast(d.fecha_nacimiento as date),'') = cast(@fecnacimiento as date)
		order by apellido_paterno, apellido_materno, nombre,d.fecha_nacimiento;
  END TRY

    BEGIN CATCH
        EXEC RethrowError;
    END CATCH
    
    SET NOCOUNT OFF
END
