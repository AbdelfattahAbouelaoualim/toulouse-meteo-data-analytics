CREATE TABLE tb_stations_optimized (
  station_id STRING NOT NULL,
  longitude FLOAT64,
  latitude FLOAT64,
  title STRING,
  description STRING,
  keyword ARRAY<STRING>
) PARTITION BY station_id;
