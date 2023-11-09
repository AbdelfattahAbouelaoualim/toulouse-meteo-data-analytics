import pytest
from etl.extract import extract_data
from helpers.api_helper import APIHelper
from unittest.mock import patch, Mock

# Vous devriez remplacer 'your_api_endpoint' avec l'endpoint réel de l'API que vous utilisez pour l'extraction des données
API_ENDPOINT = 'your_api_endpoint'

# Test for successful data extraction
@patch.object(APIHelper, 'get')
def test_extract_data_success(mock_get):
    # Simuler une réponse API réussie
    mock_response = Mock()
    expected_data = {'data': 'expected data'}
    mock_response.json.return_value = expected_data
    mock_response.status_code = 200
    mock_get.return_value = mock_response
    
    # Appeler la fonction extract_data et récupérer le résultat
    result = extract_data('some_station_id')
    
    # Vérifier que le résultat correspond aux données attendues
    assert result == expected_data
    mock_get.assert_called_with(f"{API_ENDPOINT}/some_station_id")

# Test for handling API errors
@patch.object(APIHelper, 'get')
def test_extract_data_api_error(mock_get):
    # Simuler une réponse API avec une erreur
    mock_response = Mock()
    mock_response.json.return_value = {'error': 'some error'}
    mock_response.status_code = 400
    mock_get.return_value = mock_response
    
    # Vérifier qu'une exception est levée lorsqu'une erreur API est rencontrée
    with pytest.raises(Exception):
        extract_data('some_station_id')

# Additional tests can be added to cover other edge cases and error handling scenarios
