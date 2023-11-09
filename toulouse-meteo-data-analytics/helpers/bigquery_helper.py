# Ce fichier contient des classes et des fonctions pour faciliter 
# l'interaction avec Google BigQuery, comme exécuter des requêtes SQL 
# ou gérer des tables.

from google.cloud import bigquery
from typing import List

class BigQueryHelper:
    def __init__(self, project_id: str):
        self.client = bigquery.Client(project=project_id)

    def insert_data(self, dataset_id: str, table_id: str, data: List[dict]) -> None:
        """
        Insère des données dans une table BigQuery.

        :param dataset_id: ID du dataset contenant la table.
        :param table_id: ID de la table où insérer les données.
        :param data: Les données à insérer.
        """
        table_ref = self.client.dataset(dataset_id).table(table_id)
        errors = self.client.insert_rows_json(table_ref, data)
        if errors:
            raise Exception(f"Errors occurred while inserting rows: {errors}")

    def query_data(self, query: str) -> bigquery.table.RowIterator:
        """
        Exécute une requête SQL et retourne les résultats.

        :param query: La requête SQL à exécuter.
        :return: Un itérateur sur les résultats.
        """
        query_job = self.client.query(query)
        results = query_job.result()
        return results

    def update_data(self, query: str) -> None:
        """
        Exécute une requête de mise à jour.

        :param query: La requête SQL de mise à jour.
        """
        self.client.query(query).result()

    def delete_data(self, dataset_id: str, table_id: str, condition: str) -> None:
        """
        Supprime des données d'une table selon une condition donnée.

        :param dataset_id: ID du dataset contenant la table.
        :param table_id: ID de la table à mettre à jour.
        :param condition: La condition à respecter pour la suppression.
        """
        full_table_id = f"{self.client.project}.{dataset_id}.{table_id}"
        query = f"DELETE FROM `{full_table_id}` WHERE {condition}"
        self.client.query(query).result()

# Exemple d'utilisation :
# bqh = BigQueryHelper('your_project_id')
# bqh.insert_data('your_dataset_id', 'your_table_id', [{'name': 'John Doe', 'age': 30}])
# for row in bqh.query_data('SELECT name, age FROM `your_dataset_id.your_table_id`'):
#     print(row.name, row.age)
# bqh.update_data('UPDATE `your_dataset_id.your_table_id` SET age = age + 1 WHERE name = "John Doe"')
# bqh.delete_data('your_dataset_id', 'your_table_id', 'age > 65')
