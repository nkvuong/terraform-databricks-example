# Databricks Terraform example

This repo contains everything needed to deploy a Databricks workspace and a Unity Catalog metastore

## Preparing Environment

This project uses **Teraform** to setup and teardown the demo environment.

### Prereqs

* If you do not already have Teraform installed on your machine, you will need to
    1. [Download and Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
    2. Unzip and copy binary to a place in the path such as `/usr/local/bin/terraform`
    3. Verify that Terraform is installed by running `terraform — version`
  * Alternatively, install Terraform from brew `brew install terraform`

* Local Azure credentials should be set up, following instructions [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#authenticating-to-azure)

### Deploy Environment

This project will deploy all required Azure resources, before creating a Databricks workspace with a Unity Catalog metastore assigned

1. Run `./scripts/deploy.sh`
2. The script will first run `./init.sh` which does the following
    * install Terraform using `brew` if Terraform is not installed
    * initialize the Terraform modules
    * prompt for Resource Group Name and AAD tenant Id to populate `secret.tfvars` file.
3. The script then gives options to whether plan, apply or destroy the Terraform stack
