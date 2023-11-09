-- Moyenne de température le premier mois d'exportation par station:
WITH FirstMonth AS (
  SELECT 
    station_id, 
    EXTRACT(MONTH FROM MIN(heure_de_paris)) AS first_month,
    EXTRACT(YEAR FROM MIN(heure_de_paris)) AS first_year
  FROM `toulouse-meteo-data-analytics.ds_toulouse_meteo_data.tb_telemetry`
  GROUP BY station_id
),
AvgTempFirstMonth AS (
  SELECT 
    f.station_id, 
    AVG(t.temperature_en_degre_c) AS avg_temp
  FROM `toulouse-meteo-data-analytics.ds_toulouse_meteo_data.tb_telemetry` t
  JOIN FirstMonth f ON t.station_id = f.station_id
  WHERE EXTRACT(MONTH FROM t.heure_de_paris) = f.first_month AND EXTRACT(YEAR FROM t.heure_de_paris) = f.first_year
  GROUP BY f.station_id
)
SELECT station_id, avg_temp
FROM AvgTempFirstMonth;



/*
48-station-meteo-toulouse-la-machine-af
14.254188210961731

26-station-meteo-toulouse-reynerie
10.255088495575217

01-station-meteo-toulouse-meteopole
14.712474576271195

13-station-meteo-toulouse-pech-david
27.202916666666667

14-station-meteo-toulouse-centre-pierre-potier
19.268682968682988

09-station-meteo-toulouse-la-salade
29.216561844863723

22-station-meteo-colomiers-za-perget
20.30164262820513

08-station-meteo-toulouse-basso-cambo
23.985278745644592

24-station-meteo-colomiers-zi-enjacca
24.220285188592452

31-station-meteo-mons-station-epuration
10.438061041292634

33-station-meteo-saint-jory-chapelle-beldou
7.8341379310344834

05-station-meteo-toulouse-nakache
18.669500000000014

10-station-meteo-castelginest-ecole
20.837339353942298

32-station-meteo-mons-ecole
9.3602262016965039

23-station-meteo-pibrac-bouconne-centre-equestre
21.868330792682926

58-station-meteo-toulouse-fondeyre
24.692685650474598

07-station-meteo-toulouse-avenue-de-grande-bretagne
22.532463465553217


50-station-meteo-blagnac-quinze-sols
-15.255837563451786

04-station-meteo-toulouse-ile-empalot
22.785327313769756

00-station-meteo-toulouse-valade-copy0
23.052604166666672

47-station-meteo-toulouse-la-machine-tm
20.407755102040795

21-station-meteo-cugnaux-general-de-gaulle
11.552895752895751

25-station-meteo-tournefeuille-residentiel
19.461687242798369

42-station-meteo-toulouse-parc-compans-cafarelli
20.6171666666667

37-station-meteo-toulouse-universite-paul-sabatier
23.052604166666658

27-station-meteo-toulouse-saint-cyprien
23.044325481798708

41-station-meteo-toulouse-avenue-de-casselardit
-50.0

45-station-meteo-toulouse-st-exupery
-47.11

62-station-meteo-toulouse-parc-maourine
22.6
*/