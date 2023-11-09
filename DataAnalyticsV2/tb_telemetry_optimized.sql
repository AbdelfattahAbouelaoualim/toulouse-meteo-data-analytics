CREATE TABLE tb_telemetry_optimized (
  id STRING NOT NULL,
  station_id STRING NOT NULL,
  timestamp TIMESTAMP NOT NULL,
  temperature_en_degre_c FLOAT64,
  heure_de_paris TIMESTAMP,
  force_rafale_max INT64,
  data STRING,
  pluie FLOAT64,
  type_de_station STRING,
  direction_du_vecteur_vent_moyen INT64,
  heure_utc TIMESTAMP,
  pression INT64,
  pluie_intensite_max FLOAT64,
  humidite INT64,
  force_moyenne_du_vecteur_vent INT64,
  direction_du_vecteur_de_vent_max_en_degres FLOAT64,
  direction_du_vecteur_de_vent_max INT64
) PARTITION BY TIMESTAMP_TRUNC(heure_de_paris, DAY);
