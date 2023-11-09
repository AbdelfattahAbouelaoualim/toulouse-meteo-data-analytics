# Ici se trouve la logique pour charger les données transformées 
# dans la destination finale, comme une table BigQuery.

from google.cloud import bigquery
from typing import List, Dict

# Configurez ici votre client BigQuery (le faire une seule fois de préférence en dehors des fonctions si vous utilisez ce code dans un contexte d'exécution continu)
client = bigquery.Client()

def load_to_bigquery(table_id: str, records: List[Dict]):
    """
    Charge une liste d'enregistrements dans BigQuery.

    :param table_id: L'identifiant complet de la table BigQuery.
    :param records: Une liste de dictionnaires, chaque dictionnaire étant un enregistrement à charger.
    """
    errors = client.insert_rows_json(table_id, records)  # Make an API request.
    if errors == []:
        print("New rows have been added.")
    else:
        print("Encountered errors while inserting rows: {}".format(errors))


def load_from_gcs_to_bigquery(table_id: str, gcs_uri: str):
    """
    Charge des données depuis un fichier dans Google Cloud Storage vers BigQuery.

    :param table_id: L'identifiant complet de la table BigQuery.
    :param gcs_uri: L'URI du fichier dans Google Cloud Storage.
    """
    job_config = bigquery.LoadJobConfig(
        source_format=bigquery.SourceFormat.NEWLINE_DELIMITED_JSON,
        autodetect=True,
    )

    load_job = client.load_table_from_uri(
        gcs_uri,
        table_id,
        job_config=job_config
    )

    # Attendez la fin du job de chargement
    load_job.result()

    destination_table = client.get_table(table_id)
    print("Loaded {} rows.".format(destination_table.num_rows))

# Exemple d'utilisation :
# Chargez directement des enregistrements dans BigQuery
# load_to_bigquery("your-project.your_dataset.your_table", records)

# Chargez des enregistrements depuis un fichier JSON dans GCS
# load_from_gcs_to_bigquery("your-project.your_dataset.your_table", "gs://your_bucket/your_file.json")
