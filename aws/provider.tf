terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
    }
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.region
}

provider "databricks" {
  alias    = "mws"
  host     = "https://accounts.cloud.databricks.com"
  username = var.databricks_account_username
  password = var.databricks_account_password
}

// initialize provider in normal mode
provider "databricks" {
  // in normal scenario you won't have to give providers aliases
  alias    = "created_workspace"
  host     = module.databricks_mws_workspace.workspace_url
  username = var.databricks_account_username
  password = var.databricks_account_password
}
