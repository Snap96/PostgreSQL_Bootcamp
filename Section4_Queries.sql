CREATE TABLE customers(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(150),
	age INT
);

-- 2. Let view the table data with
-- SELECT * FROM tablename

SELECT * FROM customers;

-- 3. Insert data into table

/*
INSERT INTO tablename(columnname1, columnname2)
VALUES('value1', 'value2')
*/

INSERT INTO customers(first_name, last_name, email, age)
VALUES ('Adnan', 'Waheed', 'a@b.com', 40);

SELECT * FROM customers;

INSERT INTO customers(first_name, last_name)
VALUES
('ADNAN', 'WAHEED'),
('JOHN', 'ADAMS'),
('LINDA', 'ABE');

SELECT * FROM customers;

-- INSERT A DATA WITH QUOTES
-- e.g How to add first_name as "Bill'O Sullivan' in our customers table
INSERT INTO customers(first_name)
VALUES
('Bill'' O Sullivan');

SELECT * FROM customers;

-- USE 'RETURNING' to get info on return rows
-- First see the default behaviour when adding a record into a table

INSERT INTO customers(first_name)
VALUES('ADAM');

--After the insert lets return all rows

INSERT INTO customers(first_name)
VALUES('JOSEPH') RETURNING *;

--After the insert, lets returns a single column value

INSERT INTO customers(first_name)
VALUES('JOSEPH1') RETURNING customer_id;

-- UPDATE DATA TO A TABLE

/*
UPDATE tablename
SET columnname = 'new_value'
WHERE columnname = 'value';
*/

SELECT * FROM customers;

-- Update single column

UPDATE customers
SET email = 'a2@b.com'
WHERE customer_id = 1

-- Update multiple column

UPDATE customers
SET
email = 'a4@b.com',
age = 30
WHERE customer_id = 1

UPDATE customers
SET
email = 'adam@b.com',
age = 40
WHERE customer_id = 6

-- Use RETURING To get updated rows

UPDATE customers
SET
email = 'a@b.com'
WHERE customer_id = 3

-- UPDATE with no WHERE clause
SELECT * FROM customers;

UPDATE customers
SET is_enable = 'Y'
WHERE customer_id = 1

UPDATE customers
SET is_enable = 'Y'
RETURNING *;

-- DELETE RECORDS FROM A TABLE

SELECT * FROM customers;

-- To delete records based on a condition

/*
DELETE FROM tablename
WHERE columnname = 'value'
*/

DELETE FROM customers
WHERE customer_id = 9

-- To delete ALL records
-- DELETE FROM tablename

-- Using UPSERT
-- ######################
/*
	1. The idea is that when you insert a new row into the table, PostgreSQL will update the row if it already exists,
	otherwise, it will insert the new row.

	That is why we call the action is upsert (the combination of update or insert).

	2. Syntax

	INSERT INTO table_name(column_list)
	VALUES(value_list)
	ON CONFLICT target action

	3. 	for 'action'

		ON CONFLICT

		DO NOTHING
		DO UPDATE SET column_1 = value_1
		WHERE condition

	4.	this is similar to INSERT INTO . . . . IF NOT EXIST
*/

-- create a sample table

CREATE TABLE t_tags(
	id serial PRIMARY KEY,
	tag text UNIQUE,
	update_date TIMESTAMP DEFAULT NOW()
);

-- insert some sample data
INSERT INTO t_tags(tag) values
('Pen'),
('Pencil');

-- Lets view the data

SELECT * FROM t_tags;

-- "2025-12-25 19:34:21.222618"

-- Lets insert a record, on conflict do nothing
INSERT INTO t_tags(tag)
VALUES('Pen')
ON CONFLICT (tag)
DO
	NOTHING;

SELECT * FROM t_tags;

-- Lets insert a record, on conflict set new values
INSERT INTO t_tags(tag)
VALUES('Pen')
ON CONFLICT (tag)
DO
	UPDATE SET
		tag = EXCLUDED.tag,
		update_date = NOW();