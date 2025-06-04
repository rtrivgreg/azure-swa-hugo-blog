# Navigate to the infrastructure directory

# Store website name in a variable for naming, no capitals or punctuation
#website_name=YOUR_WEBSITE_DOMAIN_NAME # e.g. 10bitpodcastcom
#region=AZURE_REGION_TO_USE # e.g. eastus
website_name=raymondgregoirecom # e.g. 10bitpodcastcom
region=eastus2 # e.g. eastus
#fred
## Log in with Azure CLI and select a subscription
#az login
az account set -s ed48e3e9-0fad-4a16-bbf6-0b51cdfd529a

## Create an resource group
az group create -n "${website_name}tfdata" -l $region

## Create a storage account
az storage account create --name "${website_name}tfdata" --resource-group "${website_name}tfdata" \
  --location $region --sku Standard_LRS

## Create a storage account container
az storage container create -n tfdata --account-name "${website_name}tfdata" \
 --resource-group "${website_name}tfdata"

## Set up backend config file
cat << EOF > backend-config.txt
resource_group_name="${website_name}tfdata"
storage_account_name="${website_name}tfdata"
container_name="tfdata"
EOF

