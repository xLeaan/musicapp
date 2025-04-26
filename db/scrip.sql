-- Script para crear la base de datos y las tablas necesarias para el proyecto
CREATE DATABASE IF NOT EXISTS `rtconfiable` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `rtconfiable`;

CREATE TABLE users(
	id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50),
    nombre VARCHAR(30),
    apellido VARCHAR(30),
    contrasena VARCHAR(100),
    rol VARCHAR(30)
);