-- Moyenne de la température par station la semaine dernière
SELECT 
    station_id, 
    AVG(temperature_en_degre_c) AS avg_temperature
FROM tb_telemetry_optimized
WHERE heure_de_paris BETWEEN TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 WEEK) AND CURRENT_TIMESTAMP()
GROUP BY station_id;
