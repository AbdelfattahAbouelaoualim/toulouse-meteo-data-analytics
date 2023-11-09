-- Stations non référencées:
WITH ReferencedStations AS (
  SELECT 
    DISTINCT station_id
  FROM `toulouse-meteo-data-analytics.ds_toulouse_meteo_data.tb_telemetry`
),
StationList AS (
  SELECT 
    slug
  FROM `toulouse-meteo-data-analytics.ds_toulouse_meteo_data.tb_stations`
)
SELECT 
  station_id
FROM ReferencedStations
WHERE station_id NOT IN (SELECT slug FROM StationList);


-- Réponse:
/*
48-station-meteo-toulouse-la-machine-af
39-station-meteo-tournefeuille-ecole
47-station-meteo-toulouse-la-machine-tm
00-station-meteo-toulouse-valade-copy0
*/