from airflow.models import BaseOperator
from airflow.utils.decorators import apply_defaults
from helpers.storage_helper import StorageHelper

class CustomGCSOperator(BaseOperator):
    @apply_defaults
    def __init__(self, bucket, object_name, local_file, *args, **kwargs):
        super(CustomGCSOperator, self).__init__(*args, **kwargs)
        self.bucket = bucket
        self.object_name = object_name
        self.local_file = local_file

    def execute(self, context):
        storage_helper = StorageHelper()
        storage_helper.upload_file(
            bucket_name=self.bucket, 
            object_name=self.object_name, 
            local_file=self.local_file
        )
