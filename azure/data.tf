data "azurerm_client_config" "current" {
}

data "external" "me" {
  program = ["az", "account", "show", "--query", "user"]
}

data "azurerm_resource_group" "this" {
  name     = var.resource_group_name
}

locals {
  prefix = "databricksdemo${random_string.naming.result}"
  tags = {
    Environment = "Demo"
    Owner       = lookup(data.external.me.result, "name")
  }
}