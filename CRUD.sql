-- Database: It is a data collection with a structure and a purpose.

-- RDBMS => Relational DataBase Management System. It is responsible of management the concurrency, backups, importing and exporting data.
-- The database is connected to a programming lenguage like PHP, Phyton, JavaScript.

-- SQL => Relational database -> Tables
-- NoSQL => Not relational database -> Data structure like Json, Bson, Blob, Key value, etc. 

-- C => Create
-- R => Read
-- U => Update         => Query
-- D => Delete

-- Rows => Records

-- Relationships between tables or cardinality
-- 1 -> 1 => two tables
-- 1 -> n => two tables
-- n -> n => three tables

-- Types of keys
-- Primery key => PK
-- Foreign key => FK

-- MySQL Workbench => Graphic tool 

-- Type of data
-- INT, FLOAT, VARCHAR, TIME_CURRENT

CREATE DATABASE helloworld; -- Create a database
SHOW DATABASES; -- Show database that the current user has access            
USE helloworld; -- Enter to a database.


-- AUTO_INCREMENT => It's a function that automatically inserts data when an user makes an insert into a table.
-- PRIMARY KEY => Field in a table that is no repeated and cannot be empty. It's an identifier of the row.
-- FOREIGN KEY => Field in a table that is used to connect the current table to other tables, this with the purpose of performing complex
-- queries. 
-- NOT NULL => It's a characteristic of a field to avoid that it being empty.

CREATE TABLE animals ( -- Create a table 
    id INT AUTO_INCREMENT,
    spicies VARCHAR(20) NOT NULL,
    status INT NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO animals (spicies, status) VALUES ('cat', 1); -- Insert data into the specified fields. 

ALTER TABLE animals MODIFY COLUMN id INT AUTO_INCREMENT; -- Add a column to a created table. 

DESCRIBE animals; -- Show table properties.
SHOW CREATE TABLE animals; -- Displays the command used to create a specified table. 

SELECT * FROM animals; -- Show all data in a table.
SELECT id, status FROM animals WHERE id = 1 AND spicies = 'cat'; -- Show all data in a table that fulfill the condition (WHERE).

UPDATE animals SET status = 0 WHERE id = 1; -- It is advisable use 'id' in the where.

DELETE FROM animals WHERE id = 1; -- It is advisable use 'id' in the where

CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(60) NOT NULL,
    name VARCHAR(50) NOT NULL,
    age INT NOT NULL
);

INSERT INTO user (name, age, email) VALUES ('Riquiardo', 23, 'riqui@gmail.com');
INSERT INTO user (name, age, email) VALUES ('Sandra', 20, 'san@gmail.com');
INSERT INTO user (name, age, email) VALUES ('Miguel', 13, 'mig@gmail.com');
INSERT INTO user (name, age, email) VALUES ('Laura', 26, 'lau@gmail.com');
INSERT INTO user (name, age, email) VALUES ('Daniela', 15, 'dan@gmail.com');

SELECT * FROM user LIMIT 2; -- Query with result limit.
SELECT * FROM user WHERE age >= 18 OR name = 'Daniela';
SELECT * FROM user WHERE name != 'Miguel';
SELECT * FROM user WHERE age BETWEEN 18 AND 25; -- Query with a result range.
SELECT * FROM user WHERE name LIKE '%M'; -- \
SELECT * FROM user WHERE name LIKE '%a%'; -- |=> Queries with a parameters specified in a column 
SELECT * FROM user WHERE name LIKE '%o'; -- /
SELECT * FROM user ORDER BY age ASC; -- Query ordened in ascending order.
SELECT * FROM user ORDER BY age DESC; -- Query ordened in descending order.
SELECT MAX(age) AS grandfather FROM user; -- Query ordened of mayor from largest to smallest.
SELECT MIN(age) AS child FROM user; -- Query ordened of mayor from largest to smallest.
SELECT id AS identifier, name FROM user; -- Query with an alias of a column.

CREATE TABLE products (
    id INT AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    created_by INT NOT NULL,
    brand VARCHAR(30) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (created_by) REFERENCES user(id)
);

RENAME TABLE products TO product; -- Rename table.

INSERT INTO product (name, created_by, brand)
VALUES 
('Macbook Pro 15', 1, 'Apple'),
('Samsung J8', 3, 'Samsung'),
('LG G7', 5, 'LG'),
('Iphone 13 mini', 2, 'Apple'),
('Tripowin Olina', 3, 'Tripowin');

SELECT u.name, p.name, p.brand FROM user u LEFT JOIN product p ON u.id = p.created_by; -- Query the tables on the left with respect to 
-- the table on the right (Difference). 
SELECT u.name, p.name, p.brand FROM user u RIGHT JOIN product p ON u.id = p.created_by; -- Query the tables on the right with respect to 
-- the table on the left (Difference). 
SELECT u.name, p.name, p.brand FROM user u INNER JOIN product p ON u.id = p.created_by; -- Query of a data that the specified tables have 
-- in common (Intersection). 
SELECT u.name, p.name FROM user u CROSS JOIN product p; -- Query of the combination a table with another table.
SELECT COUNT(id), brand FROM product GROUP BY brand;
SELECT COUNT(p.id) AS product_created FROM user u INNER JOIN product p ON u.id = p.created_by GROUP BY p.brand HAVING COUNT(p.id) >= 2;

DROP TABLE animals; -- Delete a specified table.
DROP TABLE product;
DROP TABLE user;

CREATE TABLE user (
    id INT AUTO_INCREMENT,
    username VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(60) NOT NULL UNIQUE,
    password VARCHAR(60) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE brand (
    id INT AUTO_INCREMENT,
    brand VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE product (
    id INT AUTO_INCREMENT, 
    name VARCHAR(50) NOT NULL, 
    brand_id INT NOT NULL, 
    created_by INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (created_by) REFERENCES user(id),
    FOREIGN KEY (brand_id) REFERENCES brand(id)    
);

CREATE TABLE order_detail (
    id INT AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

CREATE USER 'pepito'@'localhost' IDENTIFIED BY '123456'; -- Create a user.
GRANT ALL PRIVILEGES ON 'helloworld'. * TO 'pepito'@'localhost'; -- Assign the created user the privileges in MySQL.
FLUSH PRIVILEGES; -- Update or refresh changes.

CREATE USER 'perez'@'localhost' IDENTIFIED BY '123456';
GRANT REVOKE, CREATE USER, ALTER USER, DROP USER, CREATE DATABASE, ALTER DATABASE, DROP DATABASE, SHUTDOWN, CREATE TABLE, ALTER TABLE, DROP TABLE, INDEX, REFERENCES, TRIGGER, SELECT, INSERT, DELETE, UPDATE ON *.* TO 'perez'@'localhost';
FLUSH PRIVILEGES;