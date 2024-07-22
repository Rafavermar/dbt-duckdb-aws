-- models/02.cleaned/cleaned_bike_trips.sql
{{ config(materialized='view') }}

SELECT
    ride_id,
    rideable_type,
    -- Convierte las cadenas de fecha y hora a tipo timestamp
    CAST(started_at AS TIMESTAMP) AS started_at,
    CAST(ended_at AS TIMESTAMP) AS ended_at,
    -- Normaliza los nombres de las estaciones
    TRIM(UPPER(start_station_name)) AS start_station_name,
    start_station_id,
    TRIM(UPPER(end_station_name)) AS end_station_name,
    end_station_id,
    -- Valida las coordenadas geográficas
    CASE WHEN start_lat BETWEEN -90 AND 90 THEN start_lat ELSE NULL END AS start_lat,
    CASE WHEN start_lng BETWEEN -180 AND 180 THEN start_lng ELSE NULL END AS start_lng,
    CASE WHEN end_lat BETWEEN -90 AND 90 THEN end_lat ELSE NULL END AS end_lat,
    CASE WHEN end_lng BETWEEN -180 AND 180 THEN end_lng ELSE NULL END AS end_lng,
    member_casual
FROM {{ ref('stg_bike_trips') }}
WHERE
    start_station_id IS NOT NULL AND
    end_station_id IS NOT NULL AND
    started_at IS NOT NULL AND
    ended_at IS NOT NULL AND
    started_at < ended_at
