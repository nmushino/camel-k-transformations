#!/bin/bash

## Create Project
PRJ[0]="integration-demo"

sleep 5

helm uninstall openmetadata
helm uninstall openmetadata-dependencies

oc adm policy add-scc-to-group anyuid system:authenticated

sleep 5

kubectl create secret generic mysql-secrets --from-literal=openmetadata-mysql-password=openmetadata_password
kubectl create secret generic airflow-secrets --from-literal=openmetadata-airflow-password=admin
kubectl create secret generic airflow-mysql-secrets --from-literal=airflow-mysql-password=airflow_pass

sleep 5

helm repo add open-metadata https://helm.open-metadata.org/

sleep 5

#helm install openmetadata-dependencies open-metadata/openmetadata-dependencies --values openshift/openmetadata-helm-charts/charts/openmetadata/values.yaml
helm install openmetadata-dependencies open-metadata/openmetadata-dependencies

sleep 1800

helm install openmetadata open-metadata/openmetadata