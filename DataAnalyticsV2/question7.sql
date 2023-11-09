-- Temps moyen entre 2 mesures par station
WITH MeasurementDeltas AS (
  SELECT
    station_id,
    heure_de_paris,
    TIMESTAMP_DIFF(
      heure_de_paris, 
      LAG(heure_de_paris) OVER (PARTITION BY station_id ORDER BY heure_de_paris), 
      MINUTE
    ) AS diff_minutes
  FROM
    `your_project.your_dataset.tb_telemetry_optimized`
)
SELECT
  station_id AS station,
  AVG(NULLIF(diff_minutes, 0)) AS avg_time_diff
FROM
  MeasurementDeltas
GROUP BY
  station_id;
