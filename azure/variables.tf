variable "resource_group_name" {
  type = string
  description = "Name of the resource group where all Databricks resources will be deployed in"
}

variable "aad_tenant_id" {
  type = string
  description = "The AAD tenant ID where the Databricks Unity Catalog metastore will be deployed in"
}