-- Stations avec une pression max en 2021 inférieure à 100000:
WITH PressureStats AS (
  SELECT 
    station_id, 
    MAX(pression) AS max_pressure
  FROM `toulouse-meteo-data-analytics.ds_toulouse_meteo_data.tb_telemetry`
  WHERE EXTRACT(YEAR FROM heure_de_paris) = 2021
  GROUP BY station_id
  HAVING max_pressure < 100000
)
SELECT 
  s.title, 
  s.description
FROM PressureStats ps
JOIN `toulouse-meteo-data-analytics.ds_toulouse_meteo_data.tb_stations` s ON ps.station_id = s.slug;


-- Réponse: 50 Station météo Blagnac Quinze Sols