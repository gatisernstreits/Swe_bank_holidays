DROP TABLE IF EXISTS latest_calendar;

CREATE TABLE latest_calendar AS
    SELECT d, last_hol_flag FROM joined_calendar;

ALTER TABLE latest_calendar
  ADD previous_bankday int;

ALTER TABLE latest_calendar
  ADD next_bankday int;

SELECT
    d,
    last_hol_flag,
    LAG (d, 1, 0) OVER (ORDER BY d) previous_bankday,
    LAG (d, -1, 0) OVER (ORDER BY d) next_bankday
        FROM latest_calendar;

--maybe try with CASE and when -> then
