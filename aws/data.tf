data "aws_availability_zones" "available" {}

data "databricks_aws_bucket_policy" "this" {
  provider = databricks.mws  
  bucket = "${local.prefix}-rootbucket"
}

// Get information about the Databricks user that is calling
// the Databricks API (the one associated with "databricks_connection_profile").
data "databricks_current_user" "me" {
  provider = databricks.created_workspace
  depends_on = [module.databricks_mws_workspace]
}

// Get the latest Spark version to use for the cluster.
data "databricks_spark_version" "latest" {
  provider = databricks.created_workspace
  depends_on = [module.databricks_mws_workspace]
}

// Get the smallest node type
data "databricks_node_type" "smallest" {
  provider   = databricks.created_workspace
  local_disk = true
  depends_on = [module.databricks_mws_workspace]
}
