-- Somme cumulée de la pluie sur 3 jours pour semaine n°5 de 2021
WITH RainData AS (
  SELECT 
    station_id, 
    DATE(heure_de_paris) as date, 
    SUM(pluie) OVER(
        PARTITION BY station_id 
        ORDER BY DATE(heure_de_paris) 
        ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING
        ) AS sum_rain
  FROM tb_telemetry_optimized
  WHERE 
    EXTRACT(WEEK FROM heure_de_paris) = 5 
    AND EXTRACT(YEAR FROM heure_de_paris) = 2021
)
SELECT 
    station_id, 
    date, 
    sum_rain
FROM RainData;
