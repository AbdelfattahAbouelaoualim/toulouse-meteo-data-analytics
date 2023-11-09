from airflow.sensors.base_sensor_operator import BaseSensorOperator
from airflow.utils.decorators import apply_defaults
from helpers.storage_helper import StorageHelper

class CustomGCSSensor(BaseSensorOperator):
    @apply_defaults
    def __init__(self, bucket, object_name, *args, **kwargs):
        super(CustomGCSSensor, self).__init__(*args, **kwargs)
        self.bucket = bucket
        self.object_name = object_name

    def poke(self, context):
        storage_helper = StorageHelper()
        return storage_helper.check_file_exists(
            bucket_name=self.bucket, 
            object_name=self.object_name
        )
