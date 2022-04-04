
-- Adding and subtracting date / time data
SELECT date '2005-09-11' - date '2005-09-10'

SELECT date '2005-09-11' + integer '3'

SELECT date '2005-09-11 00:00:00' - date '2005-09-09 12:00:00'

SELECT AGE(timestamp '2005-09-11 00:00:00', timestamp '2005-09-09 12:00:00')

SELECT
	AGE(rental_date)
FROM rental




-- Retrieving the current timestamp
SELECT NOW()

SELECT CAST(NOW() as DATE)

SELECT CURRENT_TIMESTAMP()

SELECT CURRENT_DATE

SELECT CURRENT_TIME



-- Extracting and transforming date / time data
SELECT EXTRACT(quarter FROM timestamp '2005-01-24 05:12:00' ) AS quarter

SELECT DATE_PART(quarter, timestamp '2005-01-24 05:12:00' ) AS quarter


-- Truncating timestamps using DATE_TRUNC()
SELECT DATE_TRUNC('year', TIMESTAMP '2005-05-21 15:30:30')

SELECT DATE_TRUNC('month', TIMESTAMP '2005-05-21 15:30:30')


