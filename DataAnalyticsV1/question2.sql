-- Pourcentage de stations mises à jour hier:
WITH UpdatedYesterday AS (
  SELECT 
    DISTINCT station_id
  FROM `toulouse-meteo-data-analytics.ds_toulouse_meteo_data.tb_telemetry`
  WHERE DATE(heure_de_paris) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)
),
TotalStations AS (
  SELECT 
    COUNT(*) AS station_count
  FROM `toulouse-meteo-data-analytics.ds_toulouse_meteo_data.tb_stations`
),
UpdatedCount AS (
  SELECT 
    COUNT(*) AS updated_count
  FROM UpdatedYesterday
)
SELECT 
  (updated_count / station_count) * 100 AS update_percentage
FROM UpdatedCount, TotalStations;


-- Réponse: 10.204081632653061
/*
Durée
0 s
Octets traités
145,05 Mo
Octets facturés
146 Mo
*/