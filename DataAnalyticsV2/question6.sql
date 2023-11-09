-- Heure de pression atmosphérique minimum
WITH HourlyPressure AS (
  SELECT 
    EXTRACT(HOUR FROM heure_de_paris) as hour, 
    AVG(pression) as avg_pressure
  FROM tb_telemetry_optimized
  GROUP BY hour
)
SELECT 
    hour
FROM HourlyPressure
ORDER BY avg_pressure ASC
LIMIT 1;
