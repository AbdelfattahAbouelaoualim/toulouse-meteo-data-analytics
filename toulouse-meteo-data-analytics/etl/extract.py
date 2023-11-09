# Ce fichier contient la logique pour extraire les données de la source API, 
# pour récupérer des données météorologiques.

import requests
from typing import Optional, List, Dict

def extract_data_from_api(base_url: str, endpoint: str, params: Optional[Dict] = None) -> List[Dict]:
    """
    Cette fonction extrait des données depuis une API REST.
    :param base_url: L'URL de base de l'API.
    :param endpoint: Le point de terminaison spécifique à partir duquel extraire les données.
    :param params: Les paramètres de la requête pour la pagination ou le filtrage.
    :return: Liste de dictionnaires représentant les données extraites.
    """
    if params is None:
        params = {}

    # Ajoutez ici votre logique pour la pagination si nécessaire
    # Par exemple, vous pouvez boucler jusqu'à ce que vous ne receviez plus de données

    # Initiez la requête à l'API
    response = requests.get(f"{base_url}{endpoint}", params=params)

    # Vérifiez que la requête a réussi
    if response.status_code == 200:
        # Parsez la réponse JSON
        data = response.json()
        # Retournez les données extraites
        return data
    else:
        # Gestion d'erreur - vous pouvez choisir de renvoyer une liste vide,
        # de lever une exception ou de tenter une nouvelle requête après un délai
        raise Exception(f"Error {response.status_code} during data extraction: {response.text}")

# Vous pouvez ajouter ici une fonction principale ou des fonctions auxiliaires supplémentaires
# si nécessaire, par exemple pour gérer la pagination ou pour transformer la réponse de l'API
# en un format plus adapté à votre pipeline ETL.
