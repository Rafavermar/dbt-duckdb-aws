{{ config(materialized='table') }}

SELECT
    *,
    '2024-01' as month
FROM read_csv_auto('s3://dbtlab/JC-202401-citibike-tripdata.csv')
UNION ALL
SELECT
    *,
    '2024-02' as month
FROM read_csv_auto('s3://dbtlab/JC-202402-citibike-tripdata.csv')
UNION ALL
SELECT
    *,
    '2024-03' as month
FROM read_csv_auto('s3://dbtlab/JC-202403-citibike-tripdata.csv')
UNION ALL
SELECT
    *,
    '2024-04' as month
FROM read_csv_auto('s3://dbtlab/JC-202404-citibike-tripdata.csv')
