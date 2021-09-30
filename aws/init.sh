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
read -p "Enter Databricks account id : " account_id
read -p "Enter Databricks account username : " username
read -s -p "Enter Databricks account password : " password
echo

cat << EOF > secrets.tfvars
databricks_account_username = "$username"
databricks_account_password = "$password"
databricks_account_id = "$account_id"
EOF