-- models/04.structural/formatted_trips.sql
{{ config(materialized='view') }}

SELECT
    ride_id,
    rideable_type,
    STRPTIME(CAST(started_at AS VARCHAR), '%Y-%m-%d %H:%M:%S') AS start_datetime,
    STRPTIME(CAST(ended_at AS VARCHAR), '%Y-%m-%d %H:%M:%S') AS end_datetime,
    start_station_name AS start_location,
    end_station_name AS end_location,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    duration_minutes,
    member_casual AS rider_type
FROM {{ ref('enriched_bike_trips') }}
