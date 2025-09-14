#!/bin/bash

RESOURCE_GROUP="rg-api-mottu-mottion"
LOCATION="brazilsouth"
POSTGRES_SERVER="postgres-mottu-mottion"
POSTGRES_DB="apidb"
POSTGRES_USER="adminuser"
POSTGRES_PASSWORD="adminpassword"
ACR_NAME="acr-api-mottu-mottion"

az group create --name $RESOURCE_GROUP --location $LOCATION

az postgres flexible-server create \
  --resource-group $RESOURCE_GROUP \
  --name $POSTGRES_SERVER \
  --location $LOCATION \
  --admin-user $POSTGRES_USER \
  --admin-password $POSTGRES_PASSWORD \
  --sku-name Standard_B1ms \
  --tier Burstable \
  --public-access All \
  --storage-size 32 \
  --version 14

az postgres flexible-server wait \
  --resource-group $RESOURCE_GROUP \
  --name $POSTGRES_SERVER \
  --created

echo "Servidor PostgreSQL criado com sucesso!"

az postgres flexible-server firewall-rule create \
    --resource-group $RESOURCE_GROUP \
    --server-name $POSTGRES_SERVER \
    --name "AllowAll" \
    --start-ip-address 0.0.0.0 \
    --end-ip-address 255.255.255.255

az postgres flexible-server db create \
  --resource-group $RESOURCE_GROUP \
  --server-name $POSTGRES_SERVER \
  --database-name $POSTGRES_DB

