resource "databricks_grants" "catalog" {
  for_each = { for access in local.catalog_access : access.catalog_name => access }
  catalog  = each.value.catalog_name
  dynamic "grant" {
    for_each = each.value.grants
    content {
      principal  = grant.value.group_name
      privileges = grant.value.catalog_privileges
    }
  }
}

resource "databricks_grants" "schema" {
  for_each = { for access in local.schema_access : access.schema_name => access }
  schema   = each.value.schema_name
  dynamic "grant" {
    for_each = each.value.grants
    content {
      principal  = grant.value.group_name
      privileges = grant.value.schema_privileges
    }
  }
}
resource "databricks_grants" "table" {
  for_each = { for access in local.table_access : access.table_name => access }
  table    = each.value.table_name
  dynamic "grant" {
    for_each = each.value.grants
    content {
      principal  = grant.value.group_name
      privileges = grant.value.table_privileges
    }
  }
}
