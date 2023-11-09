import pytest
from unittest.mock import patch, Mock
from etl.load import write_to_bigquery
from google.cloud import bigquery

# Exemple de données transformées qui seraient chargées dans BigQuery
transformed_data_example = [
    {
        "station_id": "ST123",
        "temperature_celsius": 23.5,
        "paris_time": "2023-11-06T14:00:00Z",
        "max_gust_force": 45,
        "rain_mm": 2.0,
        # ... autres champs
    }
]

# Simule une réponse réussie de BigQuery
mock_bigquery_client = Mock(spec=bigquery.Client)

@patch('etl.load.bigquery.Client', return_value=mock_bigquery_client)
def test_write_to_bigquery(mock_client):
    # Simulez la réponse de la fonction insert_rows_json comme succès
    mock_bigquery_client.insert_rows_json.return_value = []

    # Appellez la fonction de chargement avec les données transformées
    errors = write_to_bigquery('your-dataset.table', transformed_data_example)
    
    # Assurez-vous qu'aucune erreur n'a été renvoyée
    assert errors == []

    # Vérifiez que insert_rows_json a été appelée avec les données correctes
    mock_bigquery_client.insert_rows_json.assert_called_once_with(
        'your-dataset.table', transformed_data_example
    )

# Vous pouvez ajouter d'autres tests pour simuler et vérifier le comportement en cas d'erreurs de chargement.
