-- Crear base de datos (esto usualmente lo hace Docker, pero lo incluimos por claridad)
-- Si usas esto dentro de Docker Compose, no es necesario el CREATE DATABASE aquí

-- Crear esquema (opcional)
CREATE SCHEMA IF NOT EXISTS esquema_prueba;
SET search_path TO esquema_prueba;

-- Tabla Persona
CREATE TABLE persona (
                         identificacion VARCHAR(20) PRIMARY KEY,
                         nombre VARCHAR(100) NOT NULL,
                         genero VARCHAR(10) NOT NULL,
                         edad INT CHECK (edad >= 0),
                         direccion VARCHAR(150),
                         telefono VARCHAR(20)
);

-- Tabla Cliente
CREATE TABLE cliente (
                         clienteid SERIAL PRIMARY KEY,
                         contrasena VARCHAR(100) NOT NULL,
                         estado BOOLEAN NOT NULL,
                         identificacion VARCHAR(20) NOT NULL,
                         CONSTRAINT fk_cliente_persona FOREIGN KEY (identificacion)
                             REFERENCES Persona(identificacion)
                             ON DELETE CASCADE
);

-- Tabla Cuenta
CREATE TABLE cuenta (
                        numero_cuenta SERIAL PRIMARY KEY,
                        tipo_cuenta VARCHAR(50) NOT NULL,
                        saldo_inicial NUMERIC(12, 2) NOT NULL CHECK (saldo_inicial >= 0),
                        estado BOOLEAN NOT NULL,
                        clienteid INT NOT NULL,
                        CONSTRAINT fk_cuenta_cliente FOREIGN KEY (clienteid)
                            REFERENCES Cliente(clienteid)
                            ON DELETE CASCADE
);

-- Tabla Movimientos
CREATE TABLE movimientos (
                             codigo SERIAL PRIMARY KEY,
                             fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             tipo_movimiento VARCHAR(50) NOT NULL,
                             valor NUMERIC(12, 2) NOT NULL,
                             saldo NUMERIC(12, 2) NOT NULL,
                             numero_cuenta INT NOT NULL,
                             CONSTRAINT fk_movimiento_cuenta FOREIGN KEY (numero_cuenta)
                                 REFERENCES Cuenta(numero_cuenta)
                                 ON DELETE CASCADE
);
