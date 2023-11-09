from airflow.models import BaseOperator
from airflow.utils.decorators import apply_defaults
from helpers.bigquery_helper import BigQueryHelper

class CustomBigQueryOperator(BaseOperator):
    @apply_defaults
    def __init__(self, sql, destination_dataset_table, write_disposition='WRITE_TRUNCATE', *args, **kwargs):
        super(CustomBigQueryOperator, self).__init__(*args, **kwargs)
        self.sql = sql
        self.destination_dataset_table = destination_dataset_table
        self.write_disposition = write_disposition

    def execute(self, context):
        bq_helper = BigQueryHelper()
        bq_helper.run_query(
            sql=self.sql, 
            destination_dataset_table=self.destination_dataset_table, 
            write_disposition=self.write_disposition
        )
