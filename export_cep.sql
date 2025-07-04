-- Eliminar la tabla si ya existe
DROP TABLE IF EXISTS entrega.entrega_cep;

-- Crear tabla con la estructura especificada
CREATE TABLE entrega.entrega_cep (
    cep            VARCHAR(15),
    nomvia         VARCHAR(100),
    complement     VARCHAR(50),
    desde_izq      VARCHAR(10),
    hasta_izq      VARCHAR(10),
    desde_der      VARCHAR(10),
    hasta_der      VARCHAR(10),
    lado           VARCHAR(10),
    id_mavvial     INTEGER,
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
    revision       VARCHAR(10),
    fecha_rev      VARCHAR(10),
    geom           geometry(Point, 4326)
);

-- Insertar datos desde la tabla base
INSERT INTO entrega.entrega_cep (
    cep, nomvia, complement,
    desde_izq, hasta_izq,
    desde_der, hasta_der,
    lado, id_mavvial,
    cod_bar, nom_bar,
    cod_distri, nom_distri,
    cod_mun, nom_mun,
    cod_estado, nom_estado,
    marca, fecha, version,
    revision, fecha_rev,
    geom
)
SELECT
    cep, nomvia, complement,
    desde_izq, hasta_izq,
    desde_der, hasta_der,
    lado, id_mavvial,
    cod_bar, nom_bar,
    cod_distri, nom_distri,
    cod_mun, nom_mun,
    cod_estado, nom_estado,
    marca, fecha, version,
    revision, fecha_rev,
    geom
FROM am_rj.cep_fin;

-- Crear índice espacial para mejorar el rendimiento de consultas espaciales
CREATE INDEX entrega_cep_geom_idx
ON entrega.entrega_cep
USING GIST (geom);
