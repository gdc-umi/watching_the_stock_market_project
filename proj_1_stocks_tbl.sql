-- For the creation of stocks_tbl table:
CREATE TABLE "stocks_tbl" (
	"stock_symbol"	TEXT NOT NULL,
	"stock_name"	TEXT,
	"stock_price"	REAL,
	"dttm_stamp"	datetime NOT NULL,
	"effective_date"	date,
	PRIMARY KEY("stock_symbol","dttm_stamp")
);

-- For the validation of the row count of stocks_tbl:
SELECT count(*)
FROM stocks_tbl;

-- For inserting records to the stocks_tbl table:
INSERT INTO stocks_tbl
VALUES
	("UBER", "Uber Technologies Inc", 45.31, "2023-09-07 09:30:00", "2023-09-07"),
	("UBER", "Uber Technologies Inc", 46.10, "2023-09-07 12:00:00", "2023-09-07"),
	("UBER", "Uber Technologies Inc", 46.25, "2023-09-07 16:00:00", "2023-09-07"),
	("UBER", "Uber Technologies Inc", 46.34, "2023-09-08 09:30:00", "2023-09-08"),
	("UBER", "Uber Technologies Inc", 46.99, "2023-09-08 12:00:00", "2023-09-08"),
	("UBER", "Uber Technologies Inc", 47.23, "2023-09-08 16:00:00", "2023-09-08")
;

-- For the validation of data in stocks_tbl:
SELECT *
FROM stocks_tbl;


/*
	NOTES:
	
	https://www.w3resource.com/sqlite/sqlite-datetime.php
	The SQLite datetime() function returns "YYYY-MM-DD HH:MM:SS".	
	Syntax: datetime(timestring, modifier, modifier, ...)
		SELECT datetime('now'); = 2023-09-11 04:07:46
	
	We can also use:
	** Assuming dttm_stamp = 2023-09-06 09:30:00
	To extract time only on a field or value -> time(dttm_stamp) = 2023-09-06
		SELECT time('2014-10-07 15:45:57.005678'); = 15:45:57
	To extract date only on a field or value -> date(dttm_stamp) = 09:30:00
		SELECT date('2014-10-07 15:45:57.005678'); = 2014-10-07
		
	------------------------------
	https://www.w3resource.com/sqlite/sqlite-strftime.php
	The SQLite strftime() function returns the date formatted according to the format string
	specified in argument first. The second parameter is used to mention the time string and
	followed by one or more modifiers can be used to get a different result.
	Syntax: strftime(format, timestring, modifier, modifier, ...)
		SELECT strftime('%Y %m %d','now'); = 2014 10 31
		SELECT strftime('%Y-%m-%d','now'); = 2014-10-31
		
		SELECT strftime('%H %M %S %s','now'); = 12 40 18 1414759218
		SELECT strftime('%H:%M:%S.%s','now'); = 12:40:18.1414759218
Exa
*/