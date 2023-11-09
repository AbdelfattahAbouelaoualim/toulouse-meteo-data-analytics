import pytest
from etl.transform import transform_record
from datetime import datetime

# Exemple de données brutes qui pourraient être extraites de l'API
raw_data_example = {
    "station_id": "ST123",
    "temperature_en_degre_c": 23.5,
    "heure_de_paris": "2023-11-06T14:00:00Z",
    "force_rafale_max": 45,
    "data": "Some data",
    "pluie": 2.0,
    # ... ajouter tous les champs nécessaires
}

# Exemple de données après transformation
transformed_data_example = {
    "station_id": "ST123",
    "temperature_celsius": 23.5,
    "paris_time": datetime(2023, 11, 6, 14, 0, 0),
    "max_gust_force": 45,
    "data": "Some data",
    "rain_mm": 2.0,
    # ... ajuster les champs et les formats comme prévu après la transformation
}

def test_transform_record():
    # Transforme les données brutes en utilisant la fonction transform_record
    transformed_data = transform_record(raw_data_example)
    
    # Vérifie que les données transformées correspondent à l'exemple attendu
    assert transformed_data == transformed_data_example

# Vous pouvez ajouter d'autres tests pour couvrir différents scénarios et cas d'erreur.
