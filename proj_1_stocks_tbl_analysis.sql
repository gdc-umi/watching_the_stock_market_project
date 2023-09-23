SELECT * FROM stocks_tbl;

-- A.Basic Analysis
-- Queries: Perform basic analysis on the data and identify trends.
-- What are the distinct stocks in the table?
SELECT DISTINCT stock_symbol, stock_name
FROM stocks_tbl;

SELECT stock_symbol, stock_name, count(*)
FROM stocks_tbl
GROUP BY stock_symbol, stock_name;

-- Query all data for a single stock. Do you notice any overall trends?
SELECT *
FROM stocks_tbl
WHERE stock_symbol = "AAPL";

-- Which rows have a price above 100? between 40 to 50, etc?
SELECT *
FROM stocks_tbl
WHERE stock_price > 100;

SELECT stock_symbol, stock_name, count(*)
FROM stocks_tbl
WHERE stock_price > 100
GROUP BY stock_symbol, stock_name;

SELECT *
FROM stocks_tbl
WHERE stock_price BETWEEN 30 AND 50;

SELECT stock_symbol, stock_name, count(*)
FROM stocks_tbl
WHERE stock_price BETWEEN 30 AND 50
GROUP BY stock_symbol, stock_name;

-- Sort the table by price. What are the minimum and maximum prices?
SELECT *
FROM stocks_tbl
ORDER BY stock_price;

-- B.Intermediate Challenge
-- 1.Explore using aggregate functions to look at key statistics about the data (e.g., min, max, average).
SELECT min(stock_price) AS [Lowest Price], round(avg(stock_price),2) AS [Average Price], max(stock_price) AS [Highest Price]
FROM stocks_tbl;

SELECT stock_symbol, stock_name, min(stock_price) AS [Lowest Price], dttm_stamp
FROM stocks_tbl;

SELECT stock_symbol, stock_name, max(stock_price) AS [Highest Price], dttm_stamp
FROM stocks_tbl;

SELECT round(avg(stock_price),2) AS [Average Price]
FROM stocks_tbl;

-- 2.Group the data by stock and repeat. How do the stocks compare to each other?
SELECT stock_symbol, stock_name, min(stock_price) AS [Price Floor], round(avg(stock_price),2) AS [Average Price], max(stock_price) AS [Price Ceiling]
FROM stocks_tbl
GROUP BY stock_symbol, stock_name;	

SELECT stock_symbol, stock_name, min(stock_price) AS [Lowest Price], max(stock_price) AS [Highest Price], 
	round(avg(stock_price),2) AS [Average Price], round((max(stock_price) - min(stock_price)),2) AS [Range]
FROM stocks_tbl
GROUP BY stock_symbol, stock_name;

SELECT *
FROM stocks_tbl
WHERE stock_symbol = "AAPL";

SELECT *
FROM stocks_tbl
WHERE stock_symbol = "TSLA";
 
-- 3.Group the data by day or hour of day. Does day of week or time of day impact prices?
SELECT DISTINCT stock_symbol, effective_date,
		(SELECT stock_price FROM stocks_tbl AS [TMP_1]
			WHERE stocks_tbl.stock_symbol = TMP_1.stock_symbol
			AND stocks_tbl.effective_date = TMP_1.effective_date
			AND time(dttm_stamp) = "09:30:00") AS [Opening Balance],
		(SELECT stock_price FROM stocks_tbl AS [TMP_1]
			WHERE stocks_tbl.stock_symbol = TMP_1.stock_symbol
			AND stocks_tbl.effective_date = TMP_1.effective_date
			AND time(dttm_stamp) = "16:00:00") AS [Closing Balance]
-- 			, closing balance - opening balance --> This will be the Change
-- 			, 100 * (closing balance - opening balance) / opening balance --> This will be the Change %
FROM stocks_tbl;

WITH change_comp_query AS (
							SELECT DISTINCT stock_symbol, effective_date,
									(SELECT stock_price FROM stocks_tbl AS [TMP_1]
										WHERE stocks_tbl.stock_symbol = TMP_1.stock_symbol
										AND stocks_tbl.effective_date = TMP_1.effective_date
										AND time(dttm_stamp) = "09:30:00") AS opening_balance,
									(SELECT stock_price FROM stocks_tbl AS [TMP_1]
										WHERE stocks_tbl.stock_symbol = TMP_1.stock_symbol
										AND stocks_tbl.effective_date = TMP_1.effective_date
										AND time(dttm_stamp) = "16:00:00") AS closing_balance
							FROM stocks_tbl
						)
SELECT *,
		round((closing_balance - opening_balance), 2) AS [Change],
		round((100 * (closing_balance - opening_balance) / opening_balance), 2) AS [Change %]
FROM change_comp_query;

-- 4.Which of the rows have a price greater than the average of all prices in the dataset?
SELECT * 
FROM stocks_tbl
WHERE stock_price > (SELECT avg(stock_price)
						FROM stocks_tbl)
;
						
						
SELECT stock_symbol, stock_name, count(*)
FROM stocks_tbl
WHERE stock_price > (SELECT avg(stock_price)
						FROM stocks_tbl)
GROUP BY stock_symbol, stock_name;
