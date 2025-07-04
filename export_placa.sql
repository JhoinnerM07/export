-- Eliminar la tabla si ya existe
DROP TABLE IF EXISTS entrega.entrega_placa;

-- Crear la tabla con geometría tipo Point
CREATE TABLE entrega.entrega_placa (
    id_capa        INTEGER,
    tipovia        VARCHAR(10),
    nomvia         VARCHAR(100),
    nomvtotal      VARCHAR(100),
    generadora     VARCHAR(50),
    placa          VARCHAR(10),
    cod_urb        VARCHAR(15),
    tipo_urb       VARCHAR(10),
    nom_urb        VARCHAR(100),
    manzana        VARCHAR(30),
    casa_lote      VARCHAR(50),
    tipo_dir       VARCHAR(20),
    direccion      VARCHAR(180),
    cep            VARCHAR(10),
    atipico        VARCHAR(10),
    id_manzana     INTEGER,
    id_mavvial     INTEGER,
    cod_estado     VARCHAR(10),
    nom_estado     VARCHAR(100),
    cod_mun        VARCHAR(10),
    nom_mun        VARCHAR(100),
    cod_distri     VARCHAR(10),
    nom_distri     VARCHAR(100),
    cod_bar        VARCHAR(10),
    nom_bar        VARCHAR(100),
    observ_dat     VARCHAR(30),
    observ_pos     VARCHAR(30),
    marca          VARCHAR(5),
    fecha          VARCHAR(10),
    version        VARCHAR(5),
    geom           geometry(Point, 4326)
);

-- Insertar los datos desde la capa fuente
INSERT INTO entrega.entrega_placa (
    id_capa, tipovia, nomvia, nomvtotal, generadora,
    placa, cod_urb, tipo_urb, nom_urb, manzana,
    casa_lote, tipo_dir, direccion, cep, atipico,
    id_manzana, id_mavvial,
    cod_estado, nom_estado, cod_mun, nom_mun,
    cod_distri, nom_distri, cod_bar, nom_bar,
    observ_dat, observ_pos, marca, fecha, version, geom
)
SELECT
    id_capa, tipovia, nomvia, nomvtotal, generadora,
    placa, cod_urb, tipo_urb, nom_urb, manzana,
    casa_lote, tipo_dir, direccion, cep, atipico,
    id_manzana, id_mavvial,
    cod_estado, nom_estado, cod_mun, nom_mun,
    cod_distri, nom_distri, cod_bar, nom_bar,
    observ_dat, observ_pos, marca, fecha, version, geom
FROM am_rj.placa_fin;

-- Crear índice espacial para consultas eficientes
CREATE INDEX entrega_placa_geom_idx
ON entrega.entrega_placa
USING GIST (geom);
