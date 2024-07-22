{{ config(materialized='table') }}

WITH generate_date AS (
    SELECT CAST(RANGE AS DATE) AS date_key
    FROM RANGE(DATE '2024-01-01', DATE '2024-04-30', INTERVAL 1 DAY)
)

SELECT
    date_key AS id,
    DAYOFYEAR(date_key) AS day_of_year,
    YEAR(date_key) AS year,
    MONTH(date_key) AS month,
    DAYOFWEEK(date_key) AS day_of_week,
    DAY(date_key) AS day_of_month,
    CASE
        WHEN MONTH(date_key) IN (1, 3) THEN 31
        WHEN MONTH(date_key) = 2 THEN 29  -- 2024 es un año bisiesto
        WHEN MONTH(date_key) = 4 THEN 30
    END AS days_in_month,
    CASE
        WHEN DAYOFWEEK(date_key) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS type_of_day
FROM generate_date
