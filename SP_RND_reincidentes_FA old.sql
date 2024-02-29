USE [RNDetenciones_fa]
GO
/****** Object:  StoredProcedure [dbo].[SP_RND_reincidentes_FA]    Script Date: 16/01/2024 12:23:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_RND_reincidentes_FA]
@idestad int,
@fecfin date

WITH EXEC AS CALLER
AS

BEGIN

-- ===============================================
-- Autor: JLCR
-- Fecha de creación: Enero 2024
-- Fecha de modificación:
-- Descripción: Genera resumen de detenidos Reincidentes en Faltas Administrativas, a partir del rango de Fecha 
-- dada se calcula un año atras para la consulta
-- Fecha Modificación: 22 ENE 24, se elimina la liga con la tabla "TDETENIDOSADICCIONES", de los tableros
--==================================================
BEGIN TRY

DECLARE @fecini date;
SET @fecini = DATEADD(year, -1, @fecfin)

IF OBJECT_ID(N'tempdb.dbo.#Temregtotedo', N'U') IS NOT NULL  
   DROP TABLE #Temregtotedo;

IF OBJECT_ID(N'tempdb.dbo.#regtotedo', N'U') IS NOT NULL  
   DROP TABLE #regtotedo;

IF OBJECT_ID(N'tempdb.dbo.#TopRegDuplicados', N'U') IS NOT NULL  
   DROP TABLE #TopRegDuplicados;

IF OBJECT_ID(N'tempdb.dbo.#TablaNomEstatus', N'U') IS NOT NULL  
   DROP TABLE #TablaNomEstatus;

SELECT ROW_NUMBER() OVER(ORDER BY d.id_detenido ASC) AS reg, e.NOMBRE entidad, m.NOMBRE municipio
, REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),dt.lugar_detencion),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') lugar_detencion
, d.id_detenido
, d.folio_detenido
, REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),rtrim(lTRIM(replace(replace(replace(replace(replace(UPPER(d.nombre), 'Á', 'A' ), 'É', 'E' ), 'Í', 'I' ), 'Ó', 'O' ), 'Ú', 'U' )))),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') as nombre
, REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),rtrim(lTRIM(replace(replace(replace(replace(replace(UPPER(d.apellido_paterno), 'Á', 'A' ), 'É', 'E' ), 'Í', 'I' ), 'Ó', 'O' ), 'Ú', 'U' )))),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') as apellido_paterno
, REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),rtrim(lTRIM(replace(replace(replace(replace(replace(UPPER(d.apellido_materno), 'Á', 'A' ), 'É', 'E' ), 'Í', 'I' ), 'Ó', 'O' ), 'Ú', 'U' )))),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') as apellido_materno
, dt.fecha_detencion
, dc.curp
, e1.NOMBRE entidad_dom
, m1.NOMBRE mpio_dom
, loc.nombre localidad_dom
, col.NOMBRE colonia_dom
, dc.numero_interio
, dc.numero_exterior
, dc.codigo_postal
, cmc.motivo_conclusion_ri
, d.describe_motivo_conclusion 
, REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),rtrim(lTRIM(replace(replace(replace(replace(replace(
    UPPER(p.nombre_oficial_recibe), 'Á', 'A' ), 'É', 'E' ), 'Í', 'I' ), 'Ó', 'O' ), 'Ú', 'U' ))))
    ,CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') as MP
, (SELECT STUFF(
      (select ', ' + 
            REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),rtrim(lTRIM(replace(replace(replace(replace(replace(UPPER(b.apellido_paterno 
                + ' ' + b.apellido_materno  + ' ' + b.Nombre)
                , 'Á', 'A' ), 'É', 'E' ), 'Í', 'I' ), 'Ó', 'O' ), 'Ú', 'U' )))),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ')
        from RNDetenciones_fa.dbo.oficiales_fa b 
        where b.id_detencion = d.id_detencion
            FOR XML PATH ('')),
        1,2, '')) oficial
, (SELECT STUFF(
      (SELECT ', ' + 
            REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),rtrim(lTRIM(replace(replace(replace(replace(replace(UPPER(b.paterno 
                + ' ' + b.materno  + ' ' + b.Nombre)
                , 'Á', 'A' ), 'É', 'E' ), 'Í', 'I' ), 'Ó', 'O' ), 'Ú', 'U' )))),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ')
        from RNDetenciones_fa.dbo.oficiales_PSP_fa b 
        where b.id_detencion = d.id_detencion
            FOR XML PATH ('')),
        1,2, '')) oficial_psp
, cedf.descripcion_estatus
, REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),dt.motivo_detencion),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') motivo_detencion
, REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),ctl.tipo_libertad),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') tipo_libertad
, REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),tr.causa_libertad),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') causa_libertad
, REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),ctt.nombre_tipo_traslado),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') nombre_tipo_traslado
, d.fecha_nacimiento
, d.edad
, REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),rtrim(lTRIM(replace(replace(replace(replace(replace(UPPER(dc.nombre_detenido), 'Á', 'A' ), 'É', 'E' ), 'Í', 'I' ), 'Ó', 'O' ), 'Ú', 'U' )))),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') as nombre_dc
, REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),rtrim(lTRIM(replace(replace(replace(replace(replace(UPPER(dc.apellido_paterno), 'Á', 'A' ), 'É', 'E' ), 'Í', 'I' ), 'Ó', 'O' ), 'Ú', 'U' )))),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') as apellido_paterno_dc
, REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),rtrim(lTRIM(replace(replace(replace(replace(replace(UPPER(dc.apellido_materno), 'Á', 'A' ), 'É', 'E' ), 'Í', 'I' ), 'Ó', 'O' ), 'Ú', 'U' )))),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') as apellido_materno_dc
, dc.fecha_nacimiento Fec_nac_dc
, (SELECT STUFF(
    (SELECT ', ' + ctd1.tipo_delito
            FROM RNDetenciones_fa.dbo.traslados_delitos_fa td1  
            LEFT JOIN RNDetenciones_fa.dbo.cat_subtipo_delito_fa csd1 ON td1.id_subtipo_delito = csd1.id_subtipo_delito 
            LEFT JOIN RNDetenciones_fa.dbo.cat_tipo_delito_fa ctd1 ON ctd1.id_tipo_delito = td1.id_tipo_delito AND ctd1.id_bien != 0 
            LEFT JOIN RNDetenciones_fa.dbo.cat_bienes_juridicos_fa cbj1 ON cbj1.id_bien = td1.id_bien 
            WHERE td1.id_traslado = tr.id_traslado 
            FOR XML PATH ('')),
        1,2, '')) delitos
, (SELECT STUFF(
    (SELECT ', ' + cbj1.bien_juridico
            FROM RNDetenciones_fa.dbo.traslados_delitos_fa td1  
            LEFT JOIN RNDetenciones_fa.dbo.cat_subtipo_delito_fa csd1 ON td1.id_subtipo_delito = csd1.id_subtipo_delito 
            LEFT JOIN RNDetenciones_fa.dbo.cat_tipo_delito_fa ctd1 ON ctd1.id_tipo_delito = td1.id_tipo_delito AND ctd1.id_bien != 0 
            LEFT JOIN RNDetenciones_fa.dbo.cat_bienes_juridicos_fa cbj1 ON cbj1.id_bien = td1.id_bien 
            WHERE td1.id_traslado = tr.id_traslado 
            FOR XML PATH ('')),
        1,2, '')) bien_juridico
, (SELECT STUFF(
    (SELECT ', ' + REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(max),td1.especifique_delito),CHAR(10),''),CHAR(9),' '),CHAR(13),''),'"',' ') 
            FROM RNDetenciones_fa.dbo.traslados_delitos_fa td1  
            LEFT JOIN RNDetenciones_fa.dbo.cat_subtipo_delito_fa csd1 ON td1.id_subtipo_delito = csd1.id_subtipo_delito 
            LEFT JOIN RNDetenciones_fa.dbo.cat_tipo_delito_fa ctd1 ON ctd1.id_tipo_delito = td1.id_tipo_delito AND ctd1.id_bien != 0 
            LEFT JOIN RNDetenciones_fa.dbo.cat_bienes_juridicos_fa cbj1 ON cbj1.id_bien = td1.id_bien 
            WHERE td1.id_traslado = tr.id_traslado 
            FOR XML PATH ('')),
        1,2, '')) especifique_delito
		into #Temregtotedo
FROM RNDetenciones_fa.dbo.detenidos_fa d 
INNER JOIN RNDetenciones_fa.dbo.detenciones_fa dt ON dt.id_detencion=d.id_detencion
INNER JOIN GeoDirecciones.dbo.ENTIDAD e ON e.IDENTIDAD = dt.id_entidad
LEFT JOIN RNDetenciones_fa.dbo.puesta_disposiciones_fa p ON p.id_detenido=d.id_detenido AND p.es_borrado = 0 
LEFT JOIN RNDetenciones_fa.dbo.detenidos_datoscomplementarios_fa dc ON dc.id_puesta_disposicion=p.id_puesta_disposicion
LEFT JOIN RNDetenciones_fa.dbo.traslados_fa tr ON tr.id_detenido_complemento = dc.id_detenido_complemento AND tr.es_activo = 1
LEFT JOIN RNDetenciones_fa.dbo.cat_tipos_libertades_fa ctl ON ctl.id_tipo_libertad = tr.id_tipo_libertad
INNER JOIN GeoDirecciones.dbo.MUNICIPIO m ON m.IDENTIDAD = dt.id_entidad AND m.IDMPIO = dt.id_municipio
INNER JOIN RNDetenciones_fa.dbo.cat_estatus_detenidos_fa cedf ON cedf.id_estatus_detenido = d.id_estatus_detenido
LEFT JOIN GeoDirecciones.dbo.ENTIDAD e1 ON e1.IDENTIDAD = dc.id_entidad
LEFT JOIN GeoDirecciones.dbo.MUNICIPIO m1 ON m1.IDENTIDAD = dc.id_entidad AND m1.IDMPIO = dc.id_municipio
LEFT JOIN GeoDirecciones.dbo.localidad loc ON loc.IDENTIDAD = dc.id_entidad AND loc.IDMPIO = dc.id_municipio AND loc.idloc = dc.id_localidad
LEFT JOIN GeoDirecciones.dbo.colonia col ON col.idcolonia = dc.id_colonia
LEFT JOIN RNDetenciones_fa.dbo.cat_tipos_traslados_fa ctt ON ctt.id_tipo_traslado = tr.id_tipo_traslado
LEFT JOIN RNDetenciones_fa.dbo.cat_motivos_conclusiones_ri_fa cmc ON cmc.id_motivo_conclusion_ri = d.id_motivo_conclusion_ri

/*WHERE d.id_detenido IN (
    SELECT tf.id_detenido 
    FROM indicadores_rnd.dbo.TDETENIDOSADICCIONES tf )*/

where    dt.id_entidad = @idestad
AND d.edad > 17
AND dt.fecha_detencion >= @fecini AND dt.fecha_detencion <= @fecfin
ORDER BY apellido_paterno, apellido_materno, nombre,d.fecha_nacimiento;

SELECT d.*
INTO #regtotedo 
FROM #Temregtotedo d
WHERE  (d.nombre != 'SIN DATOS'
AND  d.nombre != 'X'
AND d.nombre != 'N'
AND d.nombre NOT LIKE '%SIN DATO%'
AND d.nombre NOT LIKE '%NO PROPOR%'
AND d.nombre NOT LIKE '%SIN INFOR%')
AND LOWER(d.motivo_detencion) NOT LIKE '%pensi%alimenticia'
order by apellido_paterno, apellido_materno, nombre, d.fecha_nacimiento;

--determina detenido duplicados 
SELECT nombre, apellido_paterno ,apellido_materno, fecha_nacimiento, COUNT(1) reg
INTO #TopRegDuplicados
FROM #regtotedo
GROUP BY nombre, apellido_paterno ,apellido_materno, fecha_nacimiento
HAVING COUNT(1) > 1
ORDER BY 5 DESC, 2, 3, 1;

--genera listado de los acumulado por nombre y estatus

SELECT TOP 10 a.nombre, a.apellido_paterno, a.apellido_materno,a.fecha_nacimiento, COUNT(1) reg
INTO #TablaNomEstatus
FROM #regtotedo a
INNER JOIN #TopRegDuplicados b ON a.nombre + a.apellido_paterno + a.apellido_materno 
        = b.nombre + b.apellido_paterno + b.apellido_materno
        AND ISNULL(a.fecha_nacimiento, '') = ISNULL(b.fecha_nacimiento, '')
GROUP BY a.nombre, a.apellido_paterno, a.apellido_materno, a.fecha_nacimiento
ORDER BY reg DESC;

SELECT * FROM #TablaNomEstatus;

  END TRY

    BEGIN CATCH
        EXEC RethrowError;
    END CATCH
    
    SET NOCOUNT OFF

 END;
