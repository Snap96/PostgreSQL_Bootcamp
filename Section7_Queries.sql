-- Boolean data type
-- #########################

/*
	1.	PostgreSQl supports a single Boolean data type: BOOLEAN that can have three values:
		TRUE
		FALSE and
		NULL
		
	2.	Following are some valid literals for boolean values in PostgreSQL
		-- must be enclosed in single quotes except for true and false
		TRUE 	FALSE
		TRUE	FALSE
		'true'	'false'
		't'		'f'
		'y'		'n'
		'yes'	'no'
		'1'		'0'
*/

-- 1. Lets create a sample table called 'table_boolean'
CREATE TABLE table_boolean(
	product_id SERIAL PRIMARY KEY,
	is_available BOOLEAN NOT NULL
);

-- 2. Lets insert some data
INSERT INTO table_boolean(is_available)
VALUES ('n');

UPDATE table_boolean
SET is_available = 'true'
WHERE product_id = 11;


-- 3. Lets view the records
SELECT * FROM table_boolean;

-- 4. Lets insert more variable of boolean data
SELECT * FROM table_boolean
WHERE is_available = TRUE;

-- 5. Lets do some condition search
SELECT * FROM table_boolean
WHERE is_available = 'f';

-- Using NOT for conditions
SELECT * FROM table_boolean
WHERE NOT is_available;

SELECT * FROM table_boolean
WHERE is_available;

-- 6. Set default values for boolean columns
ALTER TABLE table_boolean
ALTER COLUMN is_available
SET DEFAULT FALSE;

INSERT INTO table_boolean(product_id) VALUES (14);

-- Character Data types
-- ##########################
/*
	1.	Characters strings types are general-types suitable for;
		- text
		- numbers, and
		- symbols
		
	2.	Three main types of character data:
		Chacter Types										Notes
		--------------------								-------------------------------
		CHARACTER(n), CHAR(n)								fixed-length, blank
		CHARACTER VARYING(n) VARCHAR(n)						variable-length with length limit
		TEXT, VARCHAR										variable unlimited length

	3.	Where n is the number of characters that holds. If no value specified then default is 1.
	
	4.	If the excessive character are all spaces , PostgreSQL truncates the spaces to maximum length(n) and stores the characters.

CHARACTER(n), CHAR(n)
===========================

	- char(10) will store 10 character length.
	- However if you insert less then 10 characters, PostgreSQL will pads the rest of the that column with spaces.
*/

SELECT CAST('Gomolemo' AS character(10)) AS "Name";
"Gomolemo  "

SELECT 'Gomolemo'::char(10) AS "Name";
"Gomolemo  "

SELECT
	CAST('Gomolemo' AS character(10)) AS "Name1",
	'Gomolemo'::char(10) AS "Name2";
"Gomolemo  "
"Gomolemo  "

/*
CHARACTER VARYING(n), VARCHAR(n)		variable-length with length limit
================================================================================

	1. Useful if entries in a column can vary in length but you do not want PostgreSQL to pad the field with blanks
	2. Store exactly the number of characters provided. Save space! :)
	3. No default value exist for this type.
	4. n here means maximum number of characters
*/

SELECT 'Gomolemo'::varchar(10);
SELECT 'THIS IS A  TEST FROM THE SYSTEM'::varchar(10);
"THIS IS A "

SELECT 'ABCD 123'::varchar(10);
"ABCD 123"

/*
TEXT	: variable length column, any size
================================================================================
	1. variable-length column type
	2. Unlimited length (per PostgreSQL it say max approx. 1GB)
	3. Not part of SQl standard, but similar types available in Microsoft SQL server and MySQL etc.
*/

-- Lets create a table for all characters
CREATE TABLE table_characters(
	col_char CHAR(10),
	col_varchar VARCHAR(10),
	col_text TEXT
);

SELECT * FROM table_characters;

INSERT INTO table_characters(col_char, col_varchar, col_text) VALUES
('ABC','ABC','ABC'),
('xyz', 'xyz', 'xyz');

SELECT * FROM table_characters;

-- Typically using varchar(n) is good for small to large database, but your choice of a good character data types should be based on
--	database design
--	read/write frequency and 
--	overall business logics

--	Save the space whenever you can!!!!!