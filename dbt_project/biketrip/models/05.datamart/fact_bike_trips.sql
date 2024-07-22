{{ config(materialized='table') }}

SELECT
    ride_id,
    CAST(start_datetime AS DATE) AS start_date_id,  -- Asociación con dimensión de fecha basada en la fecha de inicio
    CAST(end_datetime AS DATE) AS end_date_id,      -- Asociación con dimensión de fecha basada en la fecha de fin
    start_location AS start_station_id,  -- Este ID deberá asociarse con la dimensión de estación
    end_location AS end_station_id,    -- Este ID deberá asociarse con la dimensión de estación
    duration_minutes,  -- Métrica calculada de la duración del viaje
    rider_type         -- Tipo de usuario (miembro o casual)
FROM {{ ref('formatted_trips') }}
