#!/bin/bash
# Variáveis
RESOURCE_GROUP="rg-api-mottu-mottion"
ACR_NAME="acrapimottumottion"
ACI_NAME="aci-api-mottu-mottion"
IMAGE_NAME="dotnet-api-mottu-mottion:v1"
DNS_LABEL="mottu-mottion-api"
POSTGRES_SERVER="postgres-mottu-mottion"
POSTGRES_DB="apidb"
POSTGRES_USER="adminuser"
POSTGRES_PASSWORD="adminpassword"

# Criar ACR
az acr create \
  --resource-group $RESOURCE_GROUP \
  --name $ACR_NAME \
  --sku Basic \
  --admin-enabled true

# Login no ACR
az acr login --name $ACR_NAME

# Build e push da imagem
docker build -t $ACR_NAME.azurecr.io/$IMAGE_NAME ./Sprint3-API
docker push $ACR_NAME.azurecr.io/$IMAGE_NAME

# Pegar credenciais do ACR
ACR_LOGIN_SERVER=$(az acr show --name $ACR_NAME --resource-group $RESOURCE_GROUP --query "loginServer" --output tsv)
ACR_PASSWORD=$(az acr credential show --name $ACR_NAME --resource-group $RESOURCE_GROUP --query "passwords[0].value" --output tsv)

# Criar ACI
az container create \
  --resource-group $RESOURCE_GROUP \
  --name $ACI_NAME \
  --image $ACR_LOGIN_SERVER/$IMAGE_NAME \
  --registry-login-server $ACR_LOGIN_SERVER \
  --os-type Linux \
  --registry-username $ACR_NAME \
  --registry-password $ACR_PASSWORD \
  --dns-name-label $DNS_LABEL \
  --ports 8080 \
  --environment-variables \
    ASPNETCORE_URLS="http://+:8080" \
    ConnectionStrings__PostgreConnection="Host=$POSTGRES_SERVER.postgres.database.azure.com;Database=$POSTGRES_DB;Username=$POSTGRES_USER;Password=$POSTGRES_PASSWORD;SSL Mode=Require;Trust Server Certificate=true" \
  --cpu 1 \
  --memory 1.5