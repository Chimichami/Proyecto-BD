-- Tablas base
CREATE TABLE RangoClasificatorio (
    nombre VARCHAR PRIMARY KEY,
    numero INT NOT NULL
);

CREATE TABLE CirculoUnite (
    nombre VARCHAR PRIMARY KEY,
    descripcion TEXT NOT NULL,
    id VARCHAR NOT NULL,
    nmiembros INT NOT NULL
);

CREATE TABLE Pokemon (
    nombre VARCHAR PRIMARY KEY,
    rol VARCHAR NOT NULL,
    tipo_de_ataque VARCHAR NOT NULL,
    rango_de_ataque VARCHAR NOT NULL
);

CREATE TABLE Holoatuendo (
    Po_nombre VARCHAR NOT NULL,
    nombre VARCHAR NOT NULL,
    precio_gemas INT NOT NULL,
    categoria VARCHAR NOT NULL,
    PRIMARY KEY (Po_nombre, nombre),
    FOREIGN KEY (Po_nombre) REFERENCES Pokemon(nombre)
);

CREATE TABLE PasedeCombate (
    numero INT PRIMARY KEY,
    isPremium BOOLEAN NOT NULL,
    H1_Po_nombre VARCHAR NOT NULL,
    H1_nombre VARCHAR NOT NULL,
    H2_Po_nombre VARCHAR NOT NULL,
    H2_nombre VARCHAR NOT NULL,
    FOREIGN KEY (H1_Po_nombre, H1_nombre) REFERENCES Holoatuendo (Po_nombre, nombre),
    FOREIGN KEY (H2_Po_nombre, H2_nombre) REFERENCES Holoatuendo (Po_nombre, nombre)
);


CREATE TABLE Jugador (
    Nombre VARCHAR PRIMARY KEY , -- Asegurar que puede ser referenciada
    N_Combates INT NOT NULL,
    Id VARCHAR UNIQUE,
    P_deportividad INT NOT NULL,
    Nivel INT NOT NULL,
    PC_numero INT NOT NULL,
    FOREIGN KEY (PC_numero) REFERENCES PasedeCombate(numero)
);


-- Tablas dependientes
CREATE TABLE Movimiento (
    Po_nombre VARCHAR NOT NULL,
    nombre VARCHAR NOT NULL,
    descripcion TEXT NOT NULL,
    nivel_aprendido INT NOT NULL,
    rango_de_ataque VARCHAR NOT NULL,
    PRIMARY KEY (Po_nombre, nombre),
    FOREIGN KEY (Po_nombre) REFERENCES Pokemon(nombre)
);

CREATE TABLE LogrosdeJugador (
    J_Nombre VARCHAR NOT NULL,
    nombre VARCHAR NOT NULL,
    fecha_de_adquisicion DATE NOT NULL,
    descripcion TEXT NOT NULL,
    PRIMARY KEY (J_Nombre, nombre),
    FOREIGN KEY (J_Nombre) REFERENCES Jugador(Nombre)
);

CREATE TABLE RopadeJugador (
    J_Nombre VARCHAR NOT NULL,
    nombre VARCHAR NOT NULL,
    tipo VARCHAR NOT NULL,
    PRIMARY KEY (J_Nombre, nombre),
    FOREIGN KEY (J_Nombre) REFERENCES Jugador(Nombre)
);

CREATE TABLE MembresiaUnite (
    mes VARCHAR NOT NULL,
    año VARCHAR NOT NULL,
    nro_gemas INT NOT NULL,
    marco_exclusivo TEXT NOT NULL,
    fondo_exclusivo TEXT NOT NULL,
    PRIMARY KEY (mes, año)
);

CREATE TABLE Jugador_compra_MembresiaUnite (
    J_Nombre VARCHAR NOT NULL,
    Me_mes VARCHAR NOT NULL,
    Me_año VARCHAR NOT NULL,
    PRIMARY KEY (J_Nombre, Me_mes, Me_año),
    FOREIGN KEY (J_Nombre) REFERENCES Jugador(Nombre),
    FOREIGN KEY (Me_mes, Me_año) REFERENCES MembresiaUnite(mes, año)
);

CREATE TABLE Jugador_tiene_Pokemon (
    J_Nombre VARCHAR NOT NULL,
    Po_nombre VARCHAR NOT NULL,
    PRIMARY KEY (J_Nombre, Po_nombre),
    FOREIGN KEY (J_Nombre) REFERENCES Jugador(Nombre),
    FOREIGN KEY (Po_nombre) REFERENCES Pokemon(nombre)
);

CREATE TABLE Jugador_tiene_RangoClasificatorio (
    J_Nombre VARCHAR NOT NULL,
    R_nombre VARCHAR NOT NULL,
    R_numero INT NOT NULL,
    PRIMARY KEY (J_Nombre, R_nombre, R_numero),
    FOREIGN KEY (J_Nombre) REFERENCES Jugador(Nombre),
    FOREIGN KEY (R_nombre) REFERENCES RangoClasificatorio(nombre)
);

CREATE TABLE Jugador_esta_CirculoUnite (
    J_Nombre VARCHAR NOT NULL,
    C_nombre VARCHAR NOT NULL,
    PRIMARY KEY (J_Nombre, C_nombre),
    FOREIGN KEY (J_Nombre) REFERENCES Jugador(Nombre),
    FOREIGN KEY (C_nombre) REFERENCES CirculoUnite(nombre)
);

CREATE TABLE PasedeCombate_incluye_RopadeJugador (
    J_Nombre VARCHAR NOT NULL,
    R_J_Nombre VARCHAR NOT NULL, -- Referencia al J_Nombre de RopadeJugador
    R_nombre VARCHAR NOT NULL,   -- Referencia al nombre de RopadeJugador
    PC_numero INT NOT NULL,
    PRIMARY KEY (J_Nombre, R_J_Nombre, R_nombre, PC_numero), -- Ajuste a la clave primaria
    FOREIGN KEY (J_Nombre) REFERENCES Jugador(Nombre),
    FOREIGN KEY (R_J_Nombre, R_nombre) REFERENCES RopadeJugador(J_Nombre, nombre),
    FOREIGN KEY (PC_numero) REFERENCES PasedeCombate(numero)
);

