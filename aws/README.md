# Databricks Terraform example

This repo contains everything needed to deploy a Databricks workspace.

## Preparing Environment

This project uses **Teraform** to setup and teardown the demo environment.

### Prereqs
If you do not already have Teraform installed on your machine, you will need to
1. [Download and Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
2. Unzip and copy binary to a place in the path such as `/usr/local/bin/terraform`
3. Verify that Terraform is installed by running `terraform — version`

Alternatively, install Terraform from brew `brew install terraform`

Local AWS credentials should be set up, following instructions [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication)

A Databricks account has been set up

### Deploy Environment
This project will deploy all required AWS resources, before creating a Databricks workspace with sample cluster and notebook

1. Modify the `workspace.tfvars` file 
    * Use your own username for the users
2. Run `./scripts/deploy.sh`
3. The script will first run `./init.sh` which does the following
    * install Terraform using `brew` if Terraform is not installed
    * initialize the Terraform modules
    * prompt for AccountId, Username, and Password to populate `secret.tfvars` file.