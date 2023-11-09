-- Temps moyen entre 2 mesures par station:
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
    `toulouse-meteo-data-analytics.ds_toulouse_meteo_data.tb_telemetry`
)
SELECT
  station_id AS station,
  AVG(NULLIF(diff_minutes, 0)) AS temps_moyen 
FROM
  MeasurementDeltas
WHERE
  diff_minutes > 0
GROUP BY
  station_id;


/*
25-station-meteo-tournefeuille-residentiel
15.060854901385786
39-station-meteo-tournefeuille-ecole
22.123627346794244
30-station-meteo-toulouse-george-sand
20.190429812645785
36-station-meteo-toulouse-purpan
20.369697882253188
09-station-meteo-toulouse-la-salade
322.10161177295043
19-station-meteo-mondouzil-mairie
15.602191943128039
24-station-meteo-colomiers-zi-enjacca
15.018400428369709
12-station-meteo-toulouse-montaudran
16.090723646253956
11-station-meteo-toulouse-soupetard
28.004985075864344
45-station-meteo-toulouse-st-exupery
47.8220757825376
04-station-meteo-toulouse-ile-empalot
15.608447361213988
37-station-meteo-toulouse-universite-paul-sabatier
16.137303301450316
61-station-meteo-blagnac-mairie
16.040279406516039
14-station-meteo-toulouse-centre-pierre-potier
19.66864774511636
47-station-meteo-toulouse-la-machine-tm
17.778099849952341
34-station-meteo-toulouse-teso
18.864225534672823
21-station-meteo-cugnaux-general-de-gaulle
253.7527509329253
13-station-meteo-toulouse-pech-david
30.60251587114961
02-station-meteo-toulouse-marengo
16.250724101590603
32-station-meteo-mons-ecole
20.843578247034962
50-station-meteo-blagnac-quinze-sols
18.005439470488067
41-station-meteo-toulouse-avenue-de-casselardit
19.820204425105679
53-station-meteo-toulouse-ponsan
17.035550883219575
08-station-meteo-toulouse-basso-cambo
16.171759259258948
*/