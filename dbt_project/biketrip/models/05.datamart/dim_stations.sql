{{ config(materialized='table') }}

SELECT
    DISTINCT
    start_station_id AS station_id,
    start_station_name AS station_name,
    start_lat AS latitude,
    start_lng AS longitude
FROM {{ ref('cleaned_bike_trips') }}

UNION

SELECT
    DISTINCT
    end_station_id AS station_id,
    end_station_name AS station_name,
    end_lat AS latitude,
    end_lng AS longitude
FROM {{ ref('cleaned_bike_trips') }}
