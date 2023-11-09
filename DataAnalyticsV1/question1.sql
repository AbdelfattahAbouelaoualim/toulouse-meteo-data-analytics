-- Nombre d'enregistrements en 2021:
WITH Records2021 AS (
  SELECT 
    COUNT(*) AS total_count
  FROM `toulouse-meteo-data-analytics.ds_toulouse_meteo_data.tb_telemetry`
  WHERE EXTRACT(YEAR FROM heure_de_paris) = 2021
)
SELECT total_count
FROM Records2021;

-- Réponse: 1200082