-- Somme cumulée de la pluie sur une fenêtre glissante de 3 jours pour la semaine n°5 de 2021:
WITH RainfallData AS (
  SELECT 
    station_id, 
    DATE(heure_de_paris) AS date, 
    SUM(pluie) OVER(
      PARTITION BY station_id 
      ORDER BY DATE(heure_de_paris) 
      ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING
    ) AS rolling_sum
  FROM `toulouse-meteo-data-analytics.ds_toulouse_meteo_data.tb_telemetry`
  WHERE 
    EXTRACT(WEEK(MONDAY) FROM heure_de_paris) = 5 
    AND EXTRACT(YEAR FROM heure_de_paris) = 2021
)
SELECT 
  station_id, 
  date, 
  rolling_sum
FROM RainfallData
ORDER BY station_id, date;
