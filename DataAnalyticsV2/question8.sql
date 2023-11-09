-- Moyenne de température le premier mois d'exportation
WITH FirstMonth AS (
  SELECT 
    station_id, 
    EXTRACT(MONTH FROM MIN(heure_de_paris)) AS first_month,
    EXTRACT(YEAR FROM MIN(heure_de_paris)) AS first_year
  FROM 
    tb_telemetry_optimized
  GROUP BY 
    station_id
)
SELECT 
  t.station_id, 
  AVG(t.temperature_en_degre_c) as avg_temp
FROM 
  tb_telemetry_optimized t
JOIN 
  FirstMonth fm 
ON 
  t.station_id = fm.station_id 
  AND EXTRACT(MONTH FROM t.heure_de_paris) = fm.first_month
  AND EXTRACT(YEAR FROM t.heure_de_paris) = fm.first_year
GROUP BY 
  t.station_id;

