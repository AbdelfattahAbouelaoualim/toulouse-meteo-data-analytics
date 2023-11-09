import requests
from typing import Dict, Any

class APIHelper:
    def __init__(self, base_url: str):
        self.base_url = base_url

    def get(self, endpoint: str, params: Dict[str, Any] = None) -> requests.Response:
        """
        Send a GET request to the API.

        :param endpoint: API endpoint to hit.
        :param params: Query parameters for the request.
        :return: Response object.
        """
        response = requests.get(f"{self.base_url}/{endpoint}", params=params)
        response.raise_for_status()  # Will raise an exception for HTTP error codes
        return response

    def post(self, endpoint: str, data: Dict[str, Any] = None, json: Dict[str, Any] = None) -> requests.Response:
        """
        Send a POST request to the API.

        :param endpoint: API endpoint to hit.
        :param data: Data to send in the form of a dictionary.
        :param json: JSON payload to send in the request.
        :return: Response object.
        """
        response = requests.post(f"{self.base_url}/{endpoint}", data=data, json=json)
        response.raise_for_status()  # Will raise an exception for HTTP error codes
        return response

# Example usage:
# api_helper = APIHelper('https://api.meteo.toulouse.fr')
# response = api_helper.get('weather', params={'station_id': '12345'})
# weather_data = response.json()
