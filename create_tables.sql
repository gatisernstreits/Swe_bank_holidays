-- sqlite
DROP TABLE IF EXISTS calendar;

CREATE TABLE calendar (
  d date UNIQUE NOT NULL,
  dayofweek INT NOT NULL,
--  weekday TEXT NOT NULL,
  quarter INT NOT NULL,
  year INT NOT NULL,
  month INT NOT NULL,
  day INT NOT NULL,
  flag INT
);
INSERT
  OR ignore INTO calendar (d, dayofweek, /*weekday*/quarter, year, month, day, flag)
SELECT *
FROM (
  WITH RECURSIVE dates(d) AS (
    VALUES('2022-01-01')
    UNION ALL
    SELECT date(d, '+1 day')
    FROM dates
    WHERE d < '2022-12-31'
  )
  SELECT d,
    (CAST(strftime('%w', d) AS INT) + 6) % 7 AS dayofweek,
--    CASE
--      (CAST(strftime('%w', d) AS INT) + 6) % 7
--      WHEN 0 THEN 'Sunday'
--      WHEN 1 THEN 'Monday'
--      WHEN 2 THEN 'Tuesday'
--      WHEN 3 THEN 'Wednesday'
--      WHEN 4 THEN 'Thursday'
--      WHEN 5 THEN 'Friday'
--      ELSE 'Saturday'
--    END AS weekday,

    CASE
      WHEN CAST(strftime('%m', d) AS INT) BETWEEN 1 AND 3 THEN 1
      WHEN CAST(strftime('%m', d) AS INT) BETWEEN 4 AND 6 THEN 2
      WHEN CAST(strftime('%m', d) AS INT) BETWEEN 7 AND 9 THEN 3
      ELSE 4
    END AS quarter,
    CAST(strftime('%Y', d) AS INT) AS year,
    CAST(strftime('%m', d) AS INT) AS month,
    CAST(strftime('%d', d) AS INT) AS day,
    
    CASE
      (CAST(strftime('%w', d) AS INT) + 6) % 7
      WHEN 0 THEN 'Y'
      WHEN 6 THEN 'Y'
      ELSE 'N'
    END AS flag
  FROM dates);

DROP TABLE IF EXISTS joined_calendar;


CREATE TABLE joined_calendar AS
SELECT * FROM calendar
LEFT JOIN swe_bank_holidays
on d=holiday_date;

ALTER TABLE joined_calendar
  ADD last_hol_flag int;
    
UPDATE joined_calendar SET last_hol_flag='Y' WHERE flag='Y' OR swe_hol_flag='Y';

ALTER TABLE joined_calendar
  ADD int_del_date int;

SELECT * FROM joined_calendar;