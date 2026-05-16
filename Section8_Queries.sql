-- Database: mydata

-- DROP DATABASE IF EXISTS mydata;

CREATE DATABASE mydata
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_South Africa.1252'
    LC_CTYPE = 'English_South Africa.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE persons(
	person_id SERIAL Primary Key,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL
);

ALTER TABLE persons
ADD COLUMN age INT NOT NULL;

SELECT * FROM persons;

ALTER TABLE persons
ADD COLUMN nationality VARCHAR(20) NOT NULL,
ADD COLUMN email VARCHAR(100) UNIQUE;

-- Modify Table Structure
-- #######################################

-- Rename a table

ALTER TABLE persons
RENAME TO users;

ALTER TABLE users
RENAME TO persons;

-- Rename a column

ALTER TABLE persons
RENAME COLUMN age TO person_age;

-- Drop a column

ALTER TABLE persons
DROP COLUMN person_age;

ALTER TABLE persons
ADD COLUMN age VARCHAR(10);

-- Change the data type of a column

ALTER TABLE persons
ALTER COLUMN age TYPE int
USING age::integer;

ALTER TABLE persons
ALTER COLUMN age TYPE VARCHAR(20);

SELECT * FROM persons;

-- Set a default values of values of a column

ALTER TABLE persons
ADD COLUMN is_enable VARCHAR(1);

ALTER TABLE persons
ALTER COLUMN is_enable SET DEFAULT 'Y';

INSERT INTO persons 
(first_name, last_name, nationality, age) VALUES
('JOHN', 'BENJAMIN', 'US', 40);

-- Add a constaint to a column
-- ##################################

-- Add a UNIQUE constraint to a column

CREATE TABLE web_links(
	link_id SERIAL Primary Key,
	link_url VARCHAR(255) NOT NULL,
	link_target VARCHAR(20)
);

SELECT * FROM web_links;

-- To set a column to accept only defined allowed/acceptable values