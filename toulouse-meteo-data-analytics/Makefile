# Makefile pour le projet toulouse-meteo-data-analytics

# Variables de projet
PROJECT := toulouse-meteo-data-analytics
IMAGE_NAME := toulouse-meteo-etl
TAG := latest

# Commande pour construire l'image Docker
build:
	docker build -t $(PROJECT)/$(IMAGE_NAME):$(TAG) .

# Commande pour exécuter les tests unitaires
test:
	pytest tests/

# Commande pour pousser l'image Docker sur un registre d'images
push:
	docker push $(PROJECT)/$(IMAGE_NAME):$(TAG)

# Commande pour déployer l'infrastructure avec Terraform
deploy-infra:
	cd iac && terraform init && terraform apply -auto-approve

# Commande pour détruire l'infrastructure avec Terraform
destroy-infra:
	cd iac && terraform destroy -auto-approve

# Commande pour planifier les changements d'infrastructure avec Terraform
plan-infra:
	cd iac && terraform plan

# Commande pour appliquer les changements d'infrastructure spécifiques avec Terraform
apply-specific-infra:
	cd iac && terraform apply -var-file="envs/prod.tfvars"

# Commande pour initialiser Airflow localement
init-airflow:
	airflow db init
	airflow users create --role Admin --username admin --email admin@example.com --firstname admin --lastname user --password admin

# Commande pour démarrer Airflow localement
start-airflow:
	airflow webserver -p 8080 & airflow scheduler

# Commande pour arrêter Airflow localement
stop-airflow:
	pkill -f "airflow webserver" && pkill -f "airflow scheduler"

# Commande pour nettoyer les fichiers et images non nécessaires
clean:
	docker system prune -af
	rm -rf __pycache__
	rm -rf *.pyc
	rm -rf .pytest_cache

# La cible par défaut si aucune n'est spécifiée
all: build test push deploy-infra
