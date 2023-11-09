# Ce fichier contient la définition du DAG Airflow pour l'orchestration 
# de l'ETL. Il définit la séquence et la logique des tâches qui doivent 
# être exécutées, les dépendances entre elles, la fréquence d'exécution, 
# et d'autres configurations liées à l'exécution du workflow.

from datetime import timedelta, datetime
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from etl.extract import extract_data
from etl.transform import transform_data
from etl.load import load_data
from airflow.providers.google.cloud.operators.bigquery import BigQueryExecuteQueryOperator

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2023, 1, 1),
    'email': ['your-email@example.com'],
    'email_on_failure': True,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
    'schedule_interval': '15 * * * *',
}

dag = DAG(
    'meteo_data_pipeline',
    default_args=default_args,
    description='DAG for Toulouse Meteo Data Analytics ETL',
    schedule_interval=timedelta(minutes=15),
    catchup=False,
)

get_station_ids = BigQueryExecuteQueryOperator(
    task_id='get_station_ids',
    sql='SELECT DISTINCT station_id FROM `your_project.your_dataset.tb_stations`;',
    use_legacy_sql=False,
    bigquery_conn_id='your_bigquery_conn_id',
    dag=dag,
)

def etl_sequence(station_id: str):
    # Extract
    raw_data = extract_data(station_id)
    # Transform
    transformed_data = transform_data(raw_data)
    # Load
    load_data(transformed_data)

with dag:
    # Assuming you have a list of station IDs
    station_ids = ['station_1', 'station_2', 'station_3']  # Replace with actual IDs
    for station_id in station_ids:
        etl_task = PythonOperator(
            task_id=f'etl_{station_id}',
            python_callable=etl_sequence,
            op_kwargs={'station_id': station_id},
            dag=dag,
        )


