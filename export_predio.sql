-- Eliminar la tabla si ya existe
DROP TABLE IF EXISTS entrega.entrega_predio;

-- Crear la tabla con geometría tipo MultiPolygon
CREATE TABLE entrega.entrega_predio (
    id_capa        INTEGER,
    cod_cata       VARCHAR(20),
    cod_mz         VARCHAR(20),
    cod_estado     VARCHAR(10),
    nom_estado     VARCHAR(100),
    cod_mun        VARCHAR(10),
    nom_mun        VARCHAR(100),
    cod_distri     VARCHAR(10),
    nom_distri     VARCHAR(100),
    cod_bar        VARCHAR(12),
    nom_bar        VARCHAR(100),
    marca          VARCHAR(5),
    fecha          VARCHAR(10),
    version        VARCHAR(5),
    geom           geometry(MultiPolygon, 4326)
);

-- Insertar los datos desde la capa fuente
INSERT INTO entrega.entrega_predio (
    id_capa, cod_cata, cod_mz,
    cod_estado, nom_estado,
    cod_mun, nom_mun,
    cod_distri, nom_distri,
    cod_bar, nom_bar,
    marca, fecha, version, geom
)
SELECT
    id_capa, cod_cata, cod_mz,
    cod_estado, nom_estado,
    cod_mun, nom_mun,
    cod_distri, nom_distri,
    cod_bar, nom_bar,
    marca, fecha, version, geom
FROM am_rj.predio_fin;

-- Crear índice espacial
CREATE INDEX entrega_predio_geom_idx
ON entrega.entrega_predio
USING GIST (geom);
