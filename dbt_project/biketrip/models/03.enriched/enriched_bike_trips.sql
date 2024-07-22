-- models/03.enriched/enriched_bike_trips.sql
{{ config(materialized='view') }}

SELECT
    *,
    -- Calcula la duración del viaje en minutos
    (epoch(ended_at) - epoch(started_at)) / 60 AS duration_minutes,
    -- Podríamos calcular la distancia del viaje si fuera relevante
    -- SQRT(POW(end_lat - start_lat, 2) + POW(end_lng - start_lng, 2)) * 111.139 AS distance_km
FROM {{ ref('cleaned_bike_trips') }}
