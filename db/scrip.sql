-- Script para crear la base de datos y las tablas necesarias para el proyecto
CREATE DATABASE IF NOT EXISTS `rtconfiable` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `rtconfiable`;

CREATE TABLE rol_user(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30) UNIQUE
);

INSERT INTO rol_user (id, nombre) VALUES
(1, 'user'),
(2, 'admin');

CREATE TABLE rol_user(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30) UNIQUE
);

INSERT INTO rol_user (id, nombre) VALUES
(1, 'user'),
(2, 'admin');

CREATE TABLE users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50) UNIQUE,
    nombre VARCHAR(30),
    num_documento VARCHAR(30),
    contrasena VARCHAR(100),
    celular INT(20),
    rol_id INT,
    FOREIGN KEY (rol_id) REFERENCES rol_user(id)
);