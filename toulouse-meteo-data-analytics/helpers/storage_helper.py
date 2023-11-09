# Ce fichier propose des outils pour interagir avec Google Cloud Storage, 
# par exemple pour écrire et lire des fichiers dans des buckets GCS.

from google.cloud import storage
from typing import BinaryIO

class StorageHelper:
    def __init__(self, bucket_name: str):
        self.client = storage.Client()
        self.bucket = self.client.get_bucket(bucket_name)

    def upload_blob_from_file(self, file_obj: BinaryIO, destination_blob_name: str) -> None:
        """
        Uploads a file to the bucket.

        :param file_obj: File object to upload.
        :param destination_blob_name: Destination blob name.
        """
        blob = self.bucket.blob(destination_blob_name)
        blob.upload_from_file(file_obj)

    def upload_blob_from_string(self, data: str, destination_blob_name: str, content_type: str = 'text/plain') -> None:
        """
        Uploads a string to the bucket.

        :param data: String of data to upload.
        :param destination_blob_name: Destination blob name.
        :param content_type: Content type of the upload.
        """
        blob = self.bucket.blob(destination_blob_name)
        blob.upload_from_string(data, content_type=content_type)

    def download_blob_to_file(self, source_blob_name: str, file_obj: BinaryIO) -> None:
        """
        Downloads a blob to a file.

        :param source_blob_name: Source blob name to download.
        :param file_obj: File object where the blob will be written to.
        """
        blob = self.bucket.blob(source_blob_name)
        blob.download_to_file(file_obj)

    def delete_blob(self, blob_name: str) -> None:
        """
        Deletes a blob from the bucket.

        :param blob_name: Name of the blob to delete.
        """
        blob = self.bucket.blob(blob_name)
        blob.delete()

# Example usage:
# storage_helper = StorageHelper('your_bucket_name')
# with open('path/to/local/file.txt', 'rb') as file_obj:
#     storage_helper.upload_blob_from_file(file_obj, 'remote/destination/file.txt')
# storage_helper.upload_blob_from_string('Hello, World!', 'remote/destination/hello.txt')
# with open('path/to/download/to/file.txt', 'wb') as file_obj:
#     storage_helper.download_blob_to_file('remote/source/file.txt', file_obj)
# storage_helper.delete_blob('remote/destination/to/delete.txt')
