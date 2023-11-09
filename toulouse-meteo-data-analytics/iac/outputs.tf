output "project_id" {
  value       = var.project_id
  description = "The project ID used for the resources"
}

output "composer_environment_name" {
  value       = google_composer_environment.meteo_data_composer.name
  description = "The name of the Cloud Composer environment"
}

output "composer_environment_gcs_bucket" {
  value       = google_composer_environment.meteo_data_composer.config.0.gcs_bucket
  description = "The GCS bucket associated with the Cloud Composer environment"
}

output "bigquery_dataset_id" {
  value       = google_bigquery_dataset.meteo_data_dataset.dataset_id
  description = "The ID of the BigQuery dataset created for the project"
}

output "data_bucket_name" {
  value       = google_storage_bucket.meteo_data_bucket.name
  description = "The name of the GCS bucket used for storing raw data"
}

# Si vous avez créé d'autres ressources et souhaitez exposer leurs propriétés comme des sorties, ajoutez-les ici de manière similaire.

# Note: Les ressources comme `google_composer_environment.meteo_data_composer` et `google_bigquery_dataset.meteo_data_dataset` doivent être définies dans votre `main.tf` ou d'autres fichiers de configuration pour que cela fonctionne.

