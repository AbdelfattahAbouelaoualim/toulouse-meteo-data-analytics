-- Liste des station_id non référencés
SELECT 
    t.station_id
FROM tb_telemetry_optimized t
LEFT JOIN tb_stations_optimized s ON t.station_id = s.station_id
WHERE s.station_id IS NULL
GROUP BY t.station_id;
