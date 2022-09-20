resource "databricks_mws_networks" "this" {
  account_id         = var.databricks_account_id
  network_name       = "${var.prefix}-network"
  security_group_ids = var.security_group_ids
  subnet_ids         = var.subnet_ids
  vpc_id             = var.vpc_id
}

resource "databricks_mws_credentials" "this" {
  account_id       = var.databricks_account_id
  role_arn         = var.cross_account_role_arn
  credentials_name = "${var.prefix}-creds"
}

resource "databricks_mws_storage_configurations" "this" {
  account_id                 = var.databricks_account_id
  bucket_name                = var.bucket_name
  storage_configuration_name = "${var.prefix}-storage"
}

resource "databricks_mws_customer_managed_keys" "storage" {
  account_id = var.databricks_account_id
  aws_key_info {
    key_arn   = var.storage_cmk.key_arn
    key_alias = var.storage_cmk.key_alias
  }
  use_cases = ["STORAGE"]
}

resource "databricks_mws_customer_managed_keys" "managed_services" {
  account_id = var.databricks_account_id
  aws_key_info {
    key_arn   = var.managed_services_cmk.key_arn
    key_alias = var.managed_services_cmk.key_alias
  }
  use_cases = ["MANAGED_SERVICES"]
}
resource "databricks_mws_workspaces" "this" {
  account_id      = var.databricks_account_id
  aws_region      = var.region
  workspace_name  = var.prefix
  deployment_name = var.prefix

  credentials_id                           = databricks_mws_credentials.this.credentials_id
  storage_configuration_id                 = databricks_mws_storage_configurations.this.storage_configuration_id
  network_id                               = databricks_mws_networks.this.network_id
  storage_customer_managed_key_id          = databricks_mws_customer_managed_keys.storage.customer_managed_key_id
  managed_services_customer_managed_key_id = databricks_mws_customer_managed_keys.managed_services.customer_managed_key_id
}

resource "databricks_mws_vpc_endpoint" "backend_rest_vpce" {
  account_id          = var.databricks_account_id
  aws_vpc_endpoint_id = var.backend_rest_id
  vpc_endpoint_name   = "${var.prefix}-vpc-backend-${var.vpc_id}"
  region              = var.region
}

resource "databricks_mws_vpc_endpoint" "relay" {
  account_id          = var.databricks_account_id
  aws_vpc_endpoint_id = var.relay_id
  vpc_endpoint_name   = "${var.prefix}-vpc-relay-${var.vpc_id}"
  region              = var.region
}
