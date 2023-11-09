-- Heure où la pression est au minimum en général:
WITH PressureByHour AS (
  SELECT 
    EXTRACT(HOUR FROM heure_de_paris) AS hour, 
    AVG(pression) AS avg_pressure
  FROM `toulouse-meteo-data-analytics.ds_toulouse_meteo_data.tb_telemetry`
  GROUP BY hour
)
SELECT 
  hour
FROM PressureByHour
ORDER BY avg_pressure ASC
LIMIT 1;


-- Réponse: 18