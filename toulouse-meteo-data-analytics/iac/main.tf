provider "google" {
  credentials = file("<PATH_TO_YOUR_SERVICE_ACCOUNT_KEY>.json")
  project     = "<YOUR_GCP_PROJECT_ID>"
  region      = "<YOUR_GCP_REGION>"
}

# Configuration pour le bucket Google Cloud Storage pour les fichiers d'export
resource "google_storage_bucket" "data_export_bucket" {
  name     = "meteo-data-export-bucket"
  location = "EU"
  # Ajoutez d'autres configurations selon les besoins, comme la politique de cycle de vie
}

# Configuration pour le dataset BigQuery
resource "google_bigquery_dataset" "meteo_dataset" {
  dataset_id                  = "meteo_data"
  location                    = "EU"
  default_table_expiration_ms = 3600000 # Expiration d'une heure pour les nouvelles tables

  # Plus d'options de configuration peuvent être ajoutées ici
}

# Configuration pour les tables BigQuery
resource "google_bigquery_table" "meteo_stations" {
  dataset_id = google_bigquery_dataset.meteo_dataset.dataset_id
  table_id   = "tb_stations"

  schema = file("schemas/tb_stations.json") # Supposons que vous avez un fichier de schéma JSON
}

resource "google_bigquery_table" "meteo_telemetry" {
  dataset_id = google_bigquery_dataset.meteo_dataset.dataset_id
  table_id   = "tb_telemetry"

  schema = file("schemas/tb_telemetry.json") # Supposons que vous avez un fichier de schéma JSON
}

# Définir d'autres ressources comme les fonctions Cloud, les VMs, les réseaux, etc.

# Si vous utilisez Airflow (Cloud Composer) pour l'orchestration ETL
resource "google_composer_environment" "composer_env" {
  name   = "meteo-data-composer"
  region = "europe-west1"

  config {
    node_count = 3

    node_config {
      zone         = "europe-west1-b"
      machine_type = "n1-standard-1"
    }

    software_config {
      airflow_config_overrides = {
        core-load_example = "False"
      }

      # Définir d'autres configurations d'Airflow si nécessaire
    }
  }
}

# Notez que ce fichier doit être adapté à vos besoins spécifiques.
# Vous devrez remplacer les valeurs de placeholder par celles qui sont pertinentes pour votre projet.

# N'oubliez pas de définir les outputs si nécessaire pour faciliter l'accès aux ID des ressources créées.
