--Crear tabla

DROP TABLE IF EXISTS entrega.entrega_bairro;
CREATE TABLE entrega.entrega_bairro (
    id_capa      INTEGER,
    tipo_bar     VARCHAR(15),
    cod_estado 	 VARCHAR(10),
	nom_estado 	 VARCHAR(100),
    cod_mun      VARCHAR(10),
    nom_mun      VARCHAR(100),
	cod_distri   VARCHAR(10),
    nom_distri   VARCHAR(100),
	cod_bar      VARCHAR(15),
    nom_bar      VARCHAR(100),
    observ       VARCHAR(50),
    marca        VARCHAR(5),
    fecha        VARCHAR(10),
    version      VARCHAR(5),
    geom         geometry(MultiPolygon, 4326)
);

--insertar datos
INSERT INTO entrega.entrega_bairro (
    id_capa, tipo_bar, cod_bar, nom_bar,
    cod_mun, nom_mun, cod_distri, nom_distri,
    observ, marca, fecha, version, geom
)
SELECT
    id_capa, tipo_bar, cod_bar, nom_bar,
    cod_mun, nom_mun, cod_distri, nom_distri,
    observ, marca, fecha, version, geom
FROM am_rj.bairro_fin;

--crear indice
CREATE INDEX entrega_bairro_geom_idx
ON entrega.entrega_bairro
USING GIST (geom);
