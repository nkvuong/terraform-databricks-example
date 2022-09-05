terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }

    azapi = {
      source = "azure/azapi"
    }

    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azapi" {
  subscription_id = var.aad_tenant_id
}

provider "azurerm" {
  subscription_id = var.aad_tenant_id
  features {}
}

provider "databricks" {
  host = azurerm_databricks_workspace.this.workspace_url
}
