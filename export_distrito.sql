-- Eliminar la tabla si ya existe
DROP TABLE IF EXISTS entrega.entrega_distrito;

-- Crear la nueva tabla
CREATE TABLE entrega.entrega_distrito (
    id_capa        INTEGER,
    cod_estado     VARCHAR(10),
    nom_estado     VARCHAR(100),
    cod_mun        VARCHAR(10),
    nom_mun        VARCHAR(100),
    cod_distri     VARCHAR(10),
    nom_distri     VARCHAR(100),
    marca          VARCHAR(5),
    fecha          VARCHAR(10),
    version        VARCHAR(5),
    geom           geometry(MultiPolygon, 4326)
);

-- Insertar los datos desde la capa fuente
INSERT INTO entrega.entrega_distrito (
    id_capa, cod_estado, nom_estado,
    cod_mun, nom_mun,
    cod_distri, nom_distri,
    marca, fecha, version,
    geom
)
SELECT
    id_capa, cod_estado, nom_estado,
    cod_mun, nom_mun,
    cod_distri, nom_distri,
    marca, fecha, version,
    geom
FROM am_rj.distrito_fin;

-- Crear índice espacial
CREATE INDEX entrega_distrito_geom_idx
ON entrega.entrega_distrito
USING GIST (geom);
