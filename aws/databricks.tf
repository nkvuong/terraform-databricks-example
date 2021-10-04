resource "databricks_cluster" "single_node" {
  provider                = databricks.created_workspace
  cluster_name            = "Single Node"
  spark_version           = data.databricks_spark_version.latest.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 20

  spark_conf = {
    # Single-node
    "spark.databricks.cluster.profile" : "singleNode"
    "spark.master" : "local[*]"
  }

  custom_tags = {
    "ResourceClass" = "SingleNode"
  }
}

// Create a simple, sample notebook. Store it in a subfolder within
// the Databricks current user's folder. The notebook contains the
// following basic Spark code in Python.
resource "databricks_notebook" "this" {
  provider = databricks.created_workspace
  path     = "${data.databricks_current_user.me.home}/Terraform/${local.prefix}-test-notebook"
  language = "PYTHON"
  source = "${path.module}/demo-notebook.py"
}
