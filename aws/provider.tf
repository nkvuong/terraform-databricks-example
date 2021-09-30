terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.3.7"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "3.60.0"
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
