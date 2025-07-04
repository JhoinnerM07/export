-- Eliminar la tabla si ya existe
DROP TABLE IF EXISTS entrega.entrega_manzana;

-- Crear la nueva tabla con estructura definida
CREATE TABLE entrega.entrega_manzana (
    id_capa        INTEGER,
    cod_mz         INTEGER,
    nse            INTEGER,
    cod_estado     VARCHAR(10),
    nom_estado     VARCHAR(100),
    cod_mun        VARCHAR(10),
    nom_mun        VARCHAR(100),
    cod_distri     VARCHAR(10),
    nom_distri     VARCHAR(100),
    cod_bar        VARCHAR(15),
    nom_bar        VARCHAR(100),
    marca          VARCHAR(5),
    fecha          VARCHAR(10),
    version        VARCHAR(5),
    geom           geometry(MultiPolygon, 4326)
);

-- Insertar datos desde la tabla fuente
INSERT INTO entrega.entrega_manzana (
    id_capa, cod_mz, nse,
    cod_estado, nom_estado,
    cod_mun, nom_mun,
    cod_distri, nom_distri,
    cod_bar, nom_bar,
    marca, fecha, version,
    geom
)
SELECT
    id_capa, cod_mz, nse,
    cod_estado, nom_estado,
    cod_mun, nom_mun,
    cod_distri, nom_distri,
    cod_bar, nom_bar,
    marca, fecha, version,
    geom
FROM am_rj.manzana_fin;

-- Crear índice espacial
CREATE INDEX entrega_manzana_geom_idx
ON entrega.entrega_manzana
USING GIST (geom);
