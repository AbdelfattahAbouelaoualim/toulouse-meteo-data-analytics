-- Moyenne de température la semaine dernière par station::
WITH LastWeek AS (
  SELECT 
    station_id, 
    AVG(temperature_en_degre_c) AS avg_temp
  FROM `toulouse-meteo-data-analytics.ds_toulouse_meteo_data.tb_telemetry`
  WHERE DATE(heure_de_paris) BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 1 WEEK) AND CURRENT_DATE()
  GROUP BY station_id
)
SELECT 
  station_id, 
  avg_temp
FROM LastWeek;


-- Réponse:
/*
02-station-meteo-toulouse-marengo
11.022108345534408
09-station-meteo-toulouse-la-salade
10.085714285714285
14-station-meteo-toulouse-centre-pierre-potier
5.1172972972972977
42-station-meteo-toulouse-parc-compans-cafarelli
10.826868044515104
28-station-meteo-toulouse-carmes
3.6531496062992144
53-station-meteo-toulouse-ponsan
11.248490566037736
*/