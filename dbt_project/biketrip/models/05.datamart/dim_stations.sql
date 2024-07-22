-- models/05.datamart/dim_stations.sql
{{ config(materialized='table') }}

WITH start_stations AS (
    SELECT
        DISTINCT
        start_station_id AS station_id,
        start_station_name AS station_name,
        start_lat AS latitude,
        start_lng AS longitude
    FROM {{ ref('cleaned_bike_trips') }}
),
end_stations AS (
    SELECT
        DISTINCT
        end_station_id AS station_id,
        end_station_name AS station_name,
        end_lat AS latitude,
        end_lng AS longitude
    FROM {{ ref('cleaned_bike_trips') }}
)

SELECT DISTINCT
    station_id,
    FIRST(station_name) AS station_name,
    FIRST(latitude) AS latitude,
    FIRST(longitude) AS longitude
FROM (
    SELECT * FROM start_stations
    UNION ALL
    SELECT * FROM end_stations
)
GROUP BY station_id
