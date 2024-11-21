CREATE SCHEMA POKEMON;
SET SEARCH_PATH = "pokemon";

/*Entidad Jugador*/
CREATE TABLE POKEMON.Jugador(
    Nombre VARCHAR (20) PRIMARY KEY,
    N_Combates INT NOT NULL DEFAULT 0,
    ID VARCHAR (10) UNIQUE NOT NULL ,
    P_Deportividad INT NOT NULL DEFAULT 100,
    Nivel INT NOT NULL DEFAULT 1,
    PC_numero SMALLINT REFERENCES PasedeCombate(Numero),

    CONSTRAINT check_p_deportividad CHECK ( P_Deportividad<101 AND P_Deportividad >= 0 ),
    CONSTRAINT check_nivel CHECK ( Nivel>0 AND Nivel<51 )
);

/*Entidad del Rango Clasificatorio del Jugador*/
CREATE TABLE POKEMON.RangoClasificatorio (
    Nombre VARCHAR(12),
    Numero SMALLINT,
    PRIMARY KEY (Nombre, Numero),
    CONSTRAINT Numero CHECK ( Numero > 0 AND Numero < 6 )
);

/*Entidad del Circulo Unite (que seria como un clan en otros juegos)*/
CREATE TABLE POKEMON.CirculoUnite(
    Nombre VARCHAR (25) PRIMARY KEY,
    Descripcion VARCHAR (50),
    ID VARCHAR (10) UNIQUE,
    nmiembros INT NOT NULL DEFAULT 1
);

/*Entidad Logros de Jugador (Entidad Debil de Jugador)*/
CREATE TABLE POKEMON.LogrosdeJugador(
    JugadorNombre VARCHAR (20),
    LogroNombre VARCHAR (15),
    Fecha_de_adquisicion DATE,
    Descripcion VARCHAR NOT NULL,
    FOREIGN KEY (JugadorNombre) REFERENCES Jugador(Nombre),
    PRIMARY KEY (JugadorNombre, LogroNombre)
);

/*Entidad de la Ropa de Jugador (Entidad Debil de jugador)*/
CREATE TABLE POKEMON.RopadeJugador(
    JugadorNombre VARCHAR (20),
    RopaNombre VARCHAR (15),
    Tipo VARCHAR (15),
    FOREIGN KEY (JugadorNombre) REFERENCES Jugador(Nombre),
    PRIMARY KEY (JugadorNombre, RopaNombre)
);

/*Entidad de la Membresia Unite*/
CREATE TABLE MembresiaUnite (
    Mes SMALLINT CHECK (Mes >= 1 AND Mes <= 12),
    Año SMALLINT CHECK (Año >= 2021 AND Año <= 2100),
    Nro_gemas INT NOT NULL,
    Marco_exclusivo VARCHAR(50),
    Fondo_exclusivo VARCHAR(50),
    PRIMARY KEY (Mes, Año)
);

/* Entidad Pokemon*/
CREATE TABLE POKEMON.Pokemon(
    Nombre VARCHAR (20) PRIMARY KEY,
    Rol VARCHAR NOT NULL,
    Tipo_de_ataque VARCHAR NOT NULL,
    Rango_de_ataque VARCHAR NOT NULL
);

/*Entidad Movimiento (Debil de Pokemon)*/
CREATE TABLE POKEMON.Movimiento(
    PokemonNombre VARCHAR (20),
    MovimientoNombre VARCHAR (20),
    Descripcion VARCHAR (255),
    NivelAprendido SMALLINT CHECK ( NivelAprendido >= 1 AND NivelAprendido <= 15),
    RangodeAtaque VARCHAR (5),
    FOREIGN KEY (PokemonNombre) REFERENCES Pokemon(Nombre),
    PRIMARY KEY (PokemonNombre, Descripcion)
);

/*Entidad Holoatuendo (Debil de Pokemon)*/
CREATE TABLE POKEMON.Holoatuendo(
    PokemonNombre VARCHAR (30),
    HoloatuendoNombre VARCHAR (30) UNIQUE ,
    PrecioGemas INT CHECK ( PrecioGemas >= 0 AND PrecioGemas < 2500),
    Categoria VARCHAR (15),
    FOREIGN KEY (PokemonNombre) REFERENCES Pokemon(Nombre),
    PRIMARY KEY (PokemonNombre, HoloatuendoNombre)
);

/*Entidad Pase de Combate */
CREATE TABLE POKEMON.PasedeCombate(
    Numero SMALLINT CHECK ( Numero >= 1 AND Numero <= 27 ),
    IsPremium BOOL NOT NULL,
    PokemonNombre VARCHAR(30),
    Holoatuendo VARCHAR(30),
    FOREIGN KEY (PokemonNombre, Holoatuendo) REFERENCES Holoatuendo(PokemonNombre, HoloatuendoNombre),
    PRIMARY KEY (Numero, Holoatuendo)
);

/*Relacion Jugador_tiene_Pokemon*/
CREATE TABLE POKEMON.Jugador_tiene_Pokemon(
    JugadorNombre VARCHAR (20),
    PokemonNombre VARCHAR (20),
    PRIMARY KEY (JugadorNombre, PokemonNombre)
);

/*Relacion Jugador_tiene_RangoClasificatorio*/
CREATE TABLE POKEMON.Jugador_tiene_RangoClasificatorio(
    JugadorNombre VARCHAR (20) REFERENCES Jugador(Nombre),
    Rango_Nombre VARCHAR(12) REFERENCES RangoClasificatorio(Nombre),
    Rango_Numero SMALLINT REFERENCES RangoClasificatorio(Numero),
    PRIMARY KEY (JugadorNombre, Rango_Nombre, Rango_Numero)
);

/*Relacion Jugador_esta_CirculoUnite*/
CREATE TABLE POKEMON.Jugador_esta_CirculoUnite(
    JugadorNombre VARCHAR (20),
    Circulo_Nombre VARCHAR (25),
    PRIMARY KEY (JugadorNombre, Circulo_Nombre)
);

/*Relacion Jugador-compra-MembresiaUnite */
CREATE TABLE Jugador_compra_MembresiaUnite(
    JugadorNombre VARCHAR (20) REFERENCES Jugador(Nombre),
    Mes SMALLINT REFERENCES MembresiaUnite(Mes),
    Año SMALLINT REFERENCES MembresiaUnite(Año),
    PRIMARY KEY (JugadorNombre, Mes, Año)
);

/* Relacion PasedeCombate-incluye-Holoatuendo */
CREATE TABLE PasedeCombate_incluye_Holoatuendo(
    PokemonNombre VARCHAR(30) REFERENCES Holoatuendo(PokemonNombre),
    HoloatuendoNombre VARCHAR (30) REFERENCES Holoatuendo(HoloatuendoNombre),
    PaseNumero SMALLINT REFERENCES PasedeCombate(Numero),
    PRIMARY KEY (PokemonNombre, HoloatuendoNombre, PaseNumero)
);


