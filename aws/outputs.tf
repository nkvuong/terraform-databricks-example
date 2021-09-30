// export host to be used by other modules
output "databricks_host" {
  value = module.databricks_mws_workspace.workspace_url
}

// export token for integration tests to run on
output "databricks_token" {
  value     = databricks_token.pat.token_value
  sensitive = true
}