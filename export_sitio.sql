-- Eliminar la tabla si ya existe
DROP TABLE IF EXISTS entrega.entrega_sitio;

-- Crear la tabla con geometría tipo Point
CREATE TABLE entrega.entrega_sitio (
    id_capa       INTEGER,
    codmz_ofi     VARCHAR(20),
    cod_est       VARCHAR(10),
    nom_est       VARCHAR(100),
    cod_mun       VARCHAR(10),
    nom_mun       VARCHAR(100),
    nse           VARCHAR(10),
    categoria     VARCHAR(100),
    nom_subcat    VARCHAR(100),
    nombre        VARCHAR(150),
    direccion     VARCHAR(200),
    telefono      VARCHAR(20),
    horario       VARCHAR(20),
    sitidata      VARCHAR(50),
    precision     VARCHAR(10),
    vigencia      VARCHAR(3),
    estado        VARCHAR(15),
    fecha_est     VARCHAR(15),
    fuente        VARCHAR(100),
    fech_fuent    VARCHAR(10),
    marca         VARCHAR(5),
    fecha         VARCHAR(10),
    version       VARCHAR(5),
	the_geom	VARCHAR(100),
    geom          geometry(Point, 4326)
);

-- Insertar los datos desde la capa fuente
INSERT INTO entrega.entrega_sitio (
    id_capa, codmz_ofi, cod_est, nom_est, cod_mun, nom_mun,
    nse, categoria, nom_subcat, nombre, direccion, telefono,
    horario, sitidata, precision, vigencia, estado, fecha_est,
    fuente, fech_fuent, marca, fecha, version, geom
)
SELECT
    id_capa, codmz_ofi, cod_est, nom_est, cod_mun, nom_mun,
    nse, categoria, nom_subcat, nombre, direccion, telefono,
    horario, sitidata, precision, vigencia, estado, fecha_est,
    fuente, fech_fuent, marca, fecha, version,
    geom::geometry(Point, 4326)
FROM am_rj.sitio_fin;

-- Crear índice espacial
CREATE INDEX entrega_sitio_geom_idx
ON entrega.entrega_sitio
USING GIST (geom);

UPDATE entrega.entrega_sitio
SET the_geom = ST_AsText(geom);

UPDATE entrega.entrega_sitio
SET estado = 'TERMINADO', fecha_est ='07-2025';

DO $$
DECLARE
  esquema TEXT := 'entrega';
  tabla TEXT := 'entrega_sitio';
  campo TEXT;
  sql TEXT;
  tiene_nulls BOOLEAN;
BEGIN
  FOR campo IN
    SELECT column_name
    FROM information_schema.columns
    WHERE table_schema = esquema
      AND table_name = tabla
      AND data_type IN ('text', 'character varying', 'character')
  LOOP
    -- Verificar si hay NULLs en este campo
    sql := format($f$
      SELECT EXISTS (
        SELECT 1 FROM %I.%I
        WHERE %I IS NULL
        LIMIT 1
      )
    $f$, esquema, tabla, campo);
    EXECUTE sql INTO tiene_nulls;

    -- Si hay NULLs, actualiza con 'N/A'
    IF tiene_nulls THEN
      sql := format($f$
        UPDATE %I.%I
        SET %I = 'N/A'
        WHERE %I IS NULL
      $f$, esquema, tabla, campo, campo);
      EXECUTE sql;
      RAISE NOTICE 'Campo % actualizado con "N/A".', campo;
    END IF;
  END LOOP;
END$$;


