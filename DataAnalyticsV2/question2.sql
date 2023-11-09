-- Pourcentage de stations mises à jour hier
WITH latest_updates AS (
  SELECT 
    station_id, 
    MAX(heure_de_paris) AS last_update
  FROM tb_telemetry_optimized
  GROUP BY station_id
)
SELECT COUNTIF(DATE(last_update) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)) / COUNT(*) * 100 as update_percentage
FROM latest_updates;
