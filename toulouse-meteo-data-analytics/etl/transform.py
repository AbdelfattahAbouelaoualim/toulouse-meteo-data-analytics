# Ce fichier gère la transformation des données extraites, 
# telles que le nettoyage, le formatage, ou l'application de règles métier 
# pour préparer les données pour le chargement.

from typing import List, Dict
import dateutil.parser

def transform_record(record: Dict) -> Dict:
    """
    Transforme un enregistrement unique en conformité avec le schéma de la table BigQuery.
    Effectue les conversions de types nécessaires, renomme les champs, etc.
    
    :param record: Un dictionnaire représentant un enregistrement brut de l'API.
    :return: Un dictionnaire représentant l'enregistrement transformé.
    """
    # Ici, nous supposons que les champs de l'API sont directement mappables aux champs de BigQuery
    # et que certains champs comme les timestamps sont convertis au format ISO 8601.
    transformed = {
        "station_id": record.get("station_id"),
        "temperature_en_degre_c": record.get("temperature"),
        "heure_de_paris": record.get("heure_paris").isoformat() if record.get("heure_paris") else None,
        "force_rafale_max": record.get("rafale_max"),
        "data": record.get("data"),
        "pluie": record.get("pluie"),
        "type_de_station": record.get("type_station"),
        "direction_du_vecteur_vent_moyen": record.get("direction_vent_moyen"),
        "heure_utc": record.get("heure_utc").isoformat() if record.get("heure_utc") else None,
        "pression": record.get("pression"),
        "pluie_intensite_max": record.get("intensite_pluie_max"),
        "humidite": record.get("humidite"),
        "force_moyenne_du_vecteur_vent": record.get("force_vent_moyen"),
        "direction_du_vecteur_de_vent_max_en_degres": record.get("direction_vent_max"),
        "direction_du_vecteur_de_vent_max": record.get("direction_vent_max"),
        "id": record.get("id"),
        "timestamp": dateutil.parser.parse(record.get("timestamp")).isoformat() if record.get("timestamp") else None
    }

    return transformed

def transform_data(records: List[Dict]) -> List[Dict]:
    """
    Transforme les données extraites de l'API pour qu'elles correspondent au schéma de la table BigQuery.
    
    :param records: Une liste de dictionnaires, chaque dictionnaire représentant un enregistrement brut de l'API.
    :return: Une liste de dictionnaires, chaque dictionnaire représentant un enregistrement transformé.
    """
    return [transform_record(record) for record in records]

# Si nécessaire, vous pouvez ajouter d'autres fonctions de transformation ici
