#!/bin/bash


#TODO install special version of CLI (with metastore API) if not present

# check if terraform is installed, install using brew if not
# TODO need to install brew if brew not available...

if ! command -v terraform &> /dev/null
then
    echo "terraform could not be found. installing using brew"
    brew install terraform
fi

#initialize terraform
terraform init -upgrade

SECRETS="secrets.tfvars"

if test -f "$SECRETS"; then
    echo "$SECRETS exists. Overwrite? "
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) break;;
            No ) exit;;
        esac
        break
    done
fi

echo "Populating secrets.tfvars"
read -p "Enter resource group name : " resource_group_name
read -p "Enter AAD tenant id : " aad_tenant_id
echo

cat << EOF > secrets.tfvars
resource_group_name = "$resource_group_name"
aad_tenant_id = "$aad_tenant_id"
EOF