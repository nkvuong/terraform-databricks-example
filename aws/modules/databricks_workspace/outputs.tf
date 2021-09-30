// export host to be used by other modules
output "workspace_url" {
  value = databricks_mws_workspaces.this.workspace_url
}
