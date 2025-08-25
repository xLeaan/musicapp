-- Script para crear la base de datos y las tablas necesarias para el proyecto
CREATE DATABASE IF NOT EXISTS `music` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `music`;

CREATE TABLE listeners(
    id_listener INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30) UNIQUE,
    full_name VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    password VARCHAR(100)
);

CREATE TABLE melomaniacs(
    follower_id INT,
    following_id INT,
    followed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (follower_id) REFERENCES listeners(id_listener),
    FOREIGN KEY (following_id) REFERENCES listeners(id_listener)
    PRIMARY KEY (follower_id, following_id)
);

CREATE TABLE post(
    id_post INT PRIMARY KEY AUTO_INCREMENT,
    id_listener VARCHAR(50) UNIQUE,
    music LONGTEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_listener) REFERENCES listeners(id_listener)
);

CREATE TABLE reactions(
    id_reaction INT PRIMARY KEY AUTO_INCREMENT,
    id_post INT,
    id_listener INT,
    reaction_type ENUM('like', 'love', 'haha', 'wow', 'sad', 'angry', 'cuestion'),
    reacted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_post) REFERENCES post(id_post),
    FOREIGN KEY (id_listener) REFERENCES listeners(id_listener)
);

CREATE TABLE block(
    bloqueado_id INT,
    bloqueador_id INT,
    blocked_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bloqueado_id) REFERENCES listeners(id_listener),
    FOREIGN KEY (bloqueador_id) REFERENCES listeners(id_listener)
)