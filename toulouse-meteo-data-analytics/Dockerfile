# Utiliser une image de base officielle Python
FROM python:3.9-slim

# Définir le répertoire de travail dans le conteneur
WORKDIR /etl

# Copier seulement les fichiers nécessaires à l'installation des dépendances
COPY requirements.txt .

# Installer les dépendances
RUN pip install --no-cache-dir -r requirements.txt

# Copier les scripts ETL dans le conteneur
COPY . .

# Vous pouvez exécuter une commande de vérification de l'intégrité ou un script d'initialisation ici, si nécessaire
# CMD ["python", "some-initialization-script.py"]

# Notez que CMD n'est pas nécessaire si le conteneur est exécuté via Airflow en tant que tâche
