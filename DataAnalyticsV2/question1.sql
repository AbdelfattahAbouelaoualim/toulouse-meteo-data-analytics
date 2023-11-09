-- Nombre d’enregistrements en 2021
SELECT 
    COUNT(*) as total_records
FROM tb_telemetry_optimized
WHERE EXTRACT(YEAR FROM heure_de_paris) = 2021;