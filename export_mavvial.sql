-- Eliminar la tabla si ya existe
DROP TABLE IF EXISTS entrega.entrega_mavvial;

-- Crear la tabla con la estructura requerida
CREATE TABLE entrega.entrega_mavvial (
    id_capa        INTEGER,
    tipovia        VARCHAR(10),
    nomvia         VARCHAR(100),
    nomvtotal      VARCHAR(100),
    nomcomun       VARCHAR(100),
    generadora     VARCHAR(50),
    costado        VARCHAR(2),
    rango_par      VARCHAR(20),
    rango_imp      VARCHAR(20),
    cep            VARCHAR(10),
    categ_vial     VARCHAR(10),
    oneway         VARCHAR(2),
    velocidad      VARCHAR(3),
    marca_vial     VARCHAR(10),
    cod_estado     VARCHAR(10),
    nom_estado     VARCHAR(100),
    cod_mun        VARCHAR(10),
    nom_mun        VARCHAR(100),
    cod_distri     VARCHAR(10),
    nom_distri     VARCHAR(100),
    cod_bar        VARCHAR(15),
    nom_bar        VARCHAR(100),
    observ_dat     VARCHAR(50),
    observ_pos     VARCHAR(50),
    marca          VARCHAR(5),
    fecha          VARCHAR(10),
    version        VARCHAR(5),
    geom           geometry(MultiLineString, 4326)
);

-- Insertar los datos desde la capa base
INSERT INTO entrega.entrega_mavvial (
    id_capa, tipovia, nomvia, nomvtotal, nomcomun, generadora,
    costado, rango_par, rango_imp, cep, categ_vial, oneway,
    velocidad, marca_vial,
    cod_estado, nom_estado, cod_mun, nom_mun,
    cod_distri, nom_distri, cod_bar, nom_bar,
    observ_dat, observ_pos, marca, fecha, version, geom
)
SELECT
    id_capa, tipovia, nomvia, nomvtotal, nomcomun, generadora,
    costado, rango_par, rango_imp, cep, categ_vial, oneway,
    velocidad, marca_vial,
    cod_estado, nom_estado, cod_mun, nom_mun,
    cod_distri, nom_distri, cod_bar, nom_bar,
    observ_dat, observ_pos, marca, fecha, version, geom
FROM am_rj.mavvial_fin;

-- Crear índice espacial para mejorar rendimiento en consultas espaciales
CREATE INDEX entrega_mavvial_geom_idx
ON entrega.entrega_mavvial
USING GIST (geom);
