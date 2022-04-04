-- PostgreSQL REFORMATING STRING AND CHARACTER DATA
-- ---------------------------------------------------

-- CONCATENATION
SELECT first_name,
		last_name,
        first_name || ' ' || last_name AS full_name
FROM customer

SELECT
	first_name,
    last_name,
	CONCAT(first_name,' ',last_name) AS full_name
FROM customer

SELECT
	CONCAT(customer_id,' : ',first_name,last_name) AS full_name
FROM customer

-- CHANGING CHAR CASE
SELECT 
		UPPER(email), 
		LOWER(first_name)
-- 		INITCAP(last_name)
FROM customer

-- REPLACING CHAR IN STRING
SELECT 
		REPLACE(description, 'A Astounding', 'An Astounding')
FROM film

-- REVERSE STRING
SELECT
		title,
        REVERSE(title)
FROM film



-- ----------------------------------------------------------
-- POSTGRESQL : Parsing string and character data
-- ----------------------------------------------------------

-- LENGTH STRING
SELECT
	title,
    CHAR_LENGTH(title)
FROM film

SELECT
	title,
    LENGTH(description) AS desc_len
FROM film

-- POSITION
SELECT 
	email,
    POSITION('@' IN email)
FROM customer

SELECT 
	email,
    STRPOS(email, '@')
FROM customer

-- PARSING
SELECT
	LEFT(description, 30)
FROM film

SELECT
	SUBSTRING(description, 10, 20)
FROM film

SELECT
	SUBSTRING(email FROM 1 FOR POSITION('@' IN email)-1)
FROM customer

SELECT
	SUBSTRING(email FROM POSITION('@' IN email)+1 FOR CHAR_LENGTH(email))
FROM customer


SELECT
  LEFT(email, POSITION('@' IN email)-1) AS username,
  SUBSTRING(email FROM POSITION('@' IN email)+1 FOR LENGTH(email)) AS domain
FROM customer



-- ------------------------------------------------------
-- POSTGRESQL: Truncating and padding string data
-- ------------------------------------------------------

-- REMOVE WHITESPACE
SELECT  TRIM('    char   '),
		LTRIM('    char   '),
        RTRIM('    char   ');

-- LPAD = appand char
SELECT LPAD('char', 10, '*#')
SELECT RPAD('char', 10, '*#')


SELECT 
	RPAD(first_name, LENGTH(first_name)+1, '@')
FROM customer
