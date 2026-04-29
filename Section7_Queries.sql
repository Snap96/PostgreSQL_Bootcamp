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

-- Numbers Data types
-- ##############################
/*
	1.	Numbers columns can hold various type numbers, but not NULL values.
	2.  Math operators (adding, multiplying, divide etc.) can be performed on numbers data type
	3.	Two main types of Numbers data are:
		Integers							Whole numbers, both +ve and -ve
		Fixed-point, floating point			Two format of fractions of whole numbers

Integers
=============


	1.	Most common type

	2. Three main types of integers
			smallint			2bytes			-32768				to +32767
			integer				4bytes			-2147483648			to +2147483647
			bigint				8bytes			-9223372036854775808	to +9223372036854775807

	3. bigint will be good enough for most of the situation if not all! Numbers larger than 2.1 billion

	4. Database will give error if a number is outside of its data type range as per above table.

	5. Auto-increment integer data type : SERIAL		An ANSI SQL standard for identity columns

		For serial data type:
			smallserial			2bytes			1 to 32767
			serial				4bytes			1 to 2147483647
			bigserial			8bytes			1 to 9223372036854775807
*/

-- Lets create a table with SERIAL data type

CREATE TABLE table_serial(
	product_id SERIAL,
	product_name VARCHAR(100)
);

-- Lets insert some data

INSERT INTO table_serial (product_name) VALUES
('pen');

SELECT * FROM table_serial;

INSERT INTO table_serial(product_name) VALUES
('pencil');

INSERT INTO table_serial(product_name) VALUES
('pencil2');


/* 
Decimal Number
========================

	1.	Decimal represent a whole number plus a fraction of a number

	2.	The fraction is represented by digits following a decimal point

	Fixed-point number
	------------------

	numeric(precision, scale)

	precision			Maximum number of digits to left and right of the decimal point
	scale				number of digits allowable on the right of the decimal point

	decimal(precision, scale)

	e.g. numeric(10,2) will return two digits to the right of the decimal points

	Floating-point numbers
	------------------------

	Two types are;

	real				allows precision to six decimal digits
	double				allows precision to 15 decimal points of precision

	unlike numeric, where we specify fixed precision and scale (e.g. numeric(10,2)), the decimal point in a given 
	column can "float" depending on the number

Data type				Storage Size				Storage type				Range
------------			----------------			---------------				--------------
numerical, decimal		variable					fixed point					Up to 131072 digits before the decimal point
																				Up to 16383 digits after the decimal point

real					4 bytes						floating point				6 decimal digits precision
double precision		8 bytes						floating point				15 decimal digits precision
*/



-- lets create our numbers table

CREATE TABLE table_numbers(
	col_numeric numeric(20,5),
	col_real real,
	col_double double precision
);

SELECT * FROM table_numbers;

INSERT INTO table_numbers (col_numeric, col_real, col_double) VALUES
(.9,.9,.9),
(3.13579, 3.13579, 3.13579),
(4.1357987654, 4.1357987654, 4.1357987654);

SELECT * FROM table_numbers;

-- Selecting Number data type
-- ################################

/*
	1. 	Use integers whenever possible.

	2. 	Decimal data and caluclations needs to be exact, then use numeric or decimal
		Float will save space, but be careful about exactness

	3.	Choose a big enough number type by looking at your data.

	4.	With big whole numbers, use bigint only if columns values constrained to fit into either smaller
		integer or smallint types
*/

-- Date/Time data types
-- #####################

/*
	1.	assigned to the variable that is supposed to store only the time value.

	2.	One of the most important types

	3.	Below is the date/time data types

														Stores							low value							High value
										Date			date only						4713 BC								294276 AD
										Time			time only						4713 BC								5874897 AD
										Timestap		Data and time					4713 BC								294276 AD
										Timestaptz		Data, time and timestamp		4713 BC								294276 AD

										Interval		Store values
*/

-- DATE data type
-- ######################
/*
	1.	Stores date values

	2.	Uses 4 bytes to store date value

	3.	By default uses the format YYYY-MM-DD

	4.	Some good useful keywords

			CURRENT_DATE		Stores current date

	5.	Column_name	DATE
*/

--	Lets create a sample table with a date data type

CREATE TABLE table_dates(
	id serial primary key,
	employee_name varchar(100) NOT NULL,
	hire_date DATE NOT NULL,
	add_date DATE DEFAULT CURRENT_DATE
);

-- Lets insert some data
INSERT INTO table_dates(employee_name, hire_date) VALUES
('ADAM', '2020-01-01'),
('LINDA', '202-02-01');

-- Lets view the data
SELECT * FROM table_dates;

UPDATE table_dates
SET hire_date = '2020-02-01'
WHERE id = 2;

-- Some useful functions

-- current date, and time
SELECT NOW();

-- current date
SELECT CURRENT_DATE;

-- TIME Data type
-- ##################

/*
	1.	stores the time of day values

	2. 	take 8 bytes to stores time

	3.	column_name TIME(precision)

	4.	precision = number of fractional digits placed in the second field
		precision up to 6 digits

	5.	Common Formats
		HH:MM
		HH:MM:SS
		HHMMSS

		MM:SS.pppppp
		HH:MM:SS.pppppp
		HHMMSS.pppppp
*/

-- Lets create a smaple table

CREATE TABLE table_time(
	id serial primary key,
	class_name varchar(100) NOT NULL,
	start_time TIME NOT NULL,
	end_time TIME NOT NULL
);

-- Lets insert some values
INSERT INTO table_time(class_name, start_time, end_time) VALUES
('MATH', '08:00:00', '09:00:00'),
('CHEMISTRY', '09:01:00', '10:00:00');

-- View the date
SELECT * FROM table_time;

-- Getting current time
SELECT CURRENT_TIME;

-- Getting current time with precision
SELECT CURRENT_TIME(4);

-- Use local time
SELECT CURRENT_TIME, LOCALTIME;
SELECT LOCALTIME, LOCALTIME(4);

--Airthematic operations
04:00
10:00

SELECT time '12:00' - time '04:00' as RESULT;

-- Using Intervals

n = number
type = second, minute, hours, day, month, year...

SELECT
CURRENT_TIME,
CURRENT_TIME + interval '2 hours' as result;

SELECT
CURRENT_TIME,
CURRENT_TIME + interval '-2 hours' as result;


-- TIMESTAMP and TIMESTAMPZ data types
-- ##########################################
/*
	1. Allows to store both date and time together

	2. Timestamp		timestamp without timezone

	   Timestamptz		timestamp with a timezone

	3. timestamptz		timezone handling

		-	Internally stored value is always in UTC
			(Universal Coordinated Time, traditionally known as Greenwich Mean Time GMT)

		Adding a timestamptz

		-	An INPUT value that has an explicit time zone specified is converted to UTC
			using the appropriate offset for the time zone
		-	If no time zone is stated in the input string, then it is assumed to be in the time zone
			indicated by the system's TimeZone parameter, is converted to UTC using the offset for 
			the timezone zone

		output a timestamptz

		-	When a timestamptz value is output, it is always converted from UTC to the current
			timezone zone, and displayed as local time in that zone
*/

-- Lets create a table

CREATE TABLE table_time_tz(
	ts TIMESTAMP,
	tstz TIMESTAMPTZ
);

-- Now lets set the timezone

INSERT INTO table_time_tz (ts, tstz) VALUES
('2026-02-22 10:10:10-07','2026-02-22 10:10:10-07');

SELECT * FROM table_time_tz;

-- Show current timezone

SHOW TIMEZONE;
-- Africa/Johannesburg

-- Now insert a record

-- View the data

-- lets change the timezone

SET TIMEZONE = 'America/New_York';

-- lets put back the original time zone

SET TIMEZONE = 'Africa/Johannesburg';

-- Current timestap

SELECT CURRENT_TIMESTAMP;

-- Current time of the day

SELECT TIMEOFDAY();

-- Using timezone() function to convert time based on a time zone

SELECT timezone('Asia/Singapore', '2020-01-01 00:00:00');
SELECT timezone('America/New_York', '2020-01-01 00:00:00');

-- UUID data type
-- #####################
/*
	1.	UUID	Universal Unique Identifier

	2.	It is a 128-bit quantity generated by an algorithm that make it unqiue in the known universe using the
		same algorithm

	3.	Example

		40e6215d-b5c6-4896-987c-f30f3678f608

		- 32 digits
		- hexadecimal digits
		- separated by hyphens

	4.	UUID is much much better than the SERIAL data type when it comes to 'uniqueness' across systems as SERIAL data
		Type generates only unqiue values within a single database.

	5.	To create a UUID data type in PostgreSQL, you need a third part UUID algorithms to generate UUID e.g uuid-ossp
*/

-- 1. Enable third part UUID extensions first e.g. uuid-ossp

	CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. Lets generate a sample UUID value first

	SELECT uuid_generate_v1();

	SELECT uuid_generate_v4();

-- 3. Lets create a sample table 'table_uuid'

CREATE TABLE table_uuid(
	product_id UUID DEFAULT uuid_generate_v1(),
	product_name VARCHAR(100) NOT NULL
);

-- 4. Lets insert some data

INSERT INTO table_uuid(product_name) VALUES ('AB111aaasdasda');
SELECT * FROM table_uuid;

-- 5. lets change UUID default value
ALTER TABLE table_uuid
ALTER COLUMN product_id
SET DEFAULT uuid_generate_v4();

-- 6. Lets insert some more data


-- Array data types
-- #########################
/*
	1. 	Every data type has its own companion array type e.g.

	- integer has an integer[] array type
	- character has character[] array type

	2. 	An array data type is named by appending square brackets ([]) to the data type name of array elements.

		variable[]

		phones TEXT[]

		class_name VARCHAR[]
		
*/
-- Lets create a sample table

CREATE TABLE table_array(
	id SERIAL,
	name varchar(100),
	phones text[] -- our array
);

-- View the data

SELECT * FROM table_array;

-- insert some sample data

INSERT INTO table_array(name, phones)
VALUES('Adam', ARRAY['(801)-123-4567','(819)-555-2222']);

INSERT INTO table_array(name, phones)
VALUES('Linda', ARRAY['(201)-123-4567','(214)-222-3333']);

-- Query data

SELECT * FROM table_array;

SELECT 
	name, phones[1]
FROM table_array;

SELECT 
	name, phones[1]
FROM table_array
WHERE 
	phones[2] = '(214)-222-3333'



-- hstores data type
-- #######################
/*
	1. hstores is a data type that store data into key-value pairs

	2. The hstore module implements the hstore data type.

	3. The keys and values are just text strings only.
*/

-- 1. Lets install hstore extensions first

CREATE EXTENSION IF NOT EXISTS hstore;

-- 2. Lets create our sample table

CREATE TABLE table_hstore(
	book_id SERIAL PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	book_info hstore
);

INSERT INTO table_hstore (title, book_info) VALUES
(
	'TITLE 2',
	'
		"publisher" => "ABC publisher2",
		"paper_cost" => "20.00",
		"e_cost" => "10.85"
	'
)

-- 3. Lets query specific hstore value

SELECT * FROM table_hstore;

-- 4. Lets query specific hstore value
-- -> operator
SELECT 
	book_info -> 'publisher' AS "publisher",
	book_info -> 'e_cost' AS "Electronic_Cost"
FROM table_hstore;


-- JSON data type
-- ######################
/*
	1. 	PostgreSQL has built-in support for JSON with a great range of processing functions and operators,
		and complete indexing support.

	2.	The JSON datatype is actually text under the hood, with a verification that the format is valid json
		input... much like XML.

	3.	The JSONB implemented a binary version of the JSON datatype

	4.	The JSON datatype, being a text datatype, stores the data presentation exactly as it is sent to PostgreSQL,
		including whitespace and indentation, and also multiple-keys when present
		(no processing at all is done on the content, only form validation)

	5.	The JSONB datatype is an advanced binary storage format with full processing, indexing and searching
		capabilities, and as such pre-processes the JSON data to an internal format, which does include a single
		value per key; and also isn't sensible to extra whitespace or indentation.
*/

-- 1. lets create a table
CREATE TABLE table_json(
	id SERIAL PRIMARY KEY,
	docs JSON
);

SELECT * FROM table_json;

-- 2. lets insert some data
INSERT INTO table_json(docs) VALUES
('[1,2,3,4,5,6,7]'),
('[2,3,4,5,6,7]'),
('{"Key":"Value"}');

-- 3. Lets search the data
SELECT
	docs
FROM table_json;

-- 4. Search specific data in JSON column
SELECT
	docs
FROM table_json
WHERE docs @> '2';

ALTER TABLE table_json
ALTER COLUMN docs TYPE JSONB;

CREATE INDEX ON table_json USING GIN(docs jsonb_path_ops);