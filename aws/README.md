# Databricks Terraform example

This repo contains everything needed to deploy a Databricks workspace.

## Preparing Environment

This project uses **Teraform** to setup and teardown the demo environment.

### Prereqs
* If you do not already have Teraform installed on your machine, you will need to
    1. [Download and Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
    2. Unzip and copy binary to a place in the path such as `/usr/local/bin/terraform`
    3. Verify that Terraform is installed by running `terraform — version`
    * Alternatively, install Terraform from brew `brew install terraform`

* Local AWS credentials should be set up, following instructions [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication)

* A Databricks account has been set up

### Deploy Environment
This project will deploy all required AWS resources, before creating a Databricks workspace with a sample cluster and notebook

1. Modify the `workspace.tfvars` file 
    * Update the `aws_profile` (for the aws provider), `tags` (for aws resources), `cidr` (for the vpc) and `prefix` (to set name of resources) variables
2. Modify the `iam.tf` file **if** you can create a [cross-account IAM role](https://docs.databricks.com/administration-guide/account-api/iam-role.html) using Terraform. Otherwise, add an existing role to the `cross_account_role` variable.
3. Run `./scripts/deploy.sh`
4. The script will first run `./init.sh` which does the following
    * install Terraform using `brew` if Terraform is not installed
    * initialize the Terraform modules
    * prompt for AccountId, Username, and Password to populate `secret.tfvars` file.
5. The script then gives options to whether plan, apply or destroy the Terraform stack