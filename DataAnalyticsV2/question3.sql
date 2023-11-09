-- Stations avec pression max inférieure à 100000 en 2021
SELECT 
    DISTINCT s.title, 
    s.description
FROM tb_stations_optimized s
JOIN tb_telemetry_optimized t ON s.station_id = t.station_id
WHERE EXTRACT(YEAR FROM t.heure_de_paris) = 2021 AND MAX(t.pression) < 100000
GROUP BY s.station_id;