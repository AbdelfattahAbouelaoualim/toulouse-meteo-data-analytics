-- Plages de jours consécutifs de canicules pour chaque station:
WITH RankedTemperatures AS (
  SELECT 
    station_id,
    DATE(heure_de_paris) AS date,
    temperature_en_degre_c,
    ROW_NUMBER() OVER (PARTITION BY station_id ORDER BY DATE(heure_de_paris)) AS rn,
    ROW_NUMBER() OVER (PARTITION BY station_id, temperature_en_degre_c > 25 ORDER BY DATE(heure_de_paris)) AS rn_heatwave
  FROM `toulouse-meteo-data-analytics.ds_toulouse_meteo_data.tb_telemetry`
),
HeatwavePeriods AS (
  SELECT
    station_id,
    date,
    temperature_en_degre_c,
    rn - rn_heatwave AS heatwave_group
  FROM RankedTemperatures
  WHERE temperature_en_degre_c > 25
)
SELECT
  station_id,
  MIN(date) AS heatwave_start,
  MAX(date) AS heatwave_end
FROM HeatwavePeriods
GROUP BY station_id, heatwave_group
ORDER BY station_id, heatwave_start;

