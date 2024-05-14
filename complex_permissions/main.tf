terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
    }
  }
}

variable "dbw_permissions_filepath" {
  default = "groups.json"
}

locals {
  permissions_json = jsondecode(file("${path.module}/${var.dbw_permissions_filepath}"))
  groups           = local.permissions_json.groups
  groups_clusters = flatten([
    for group in local.groups : [
      for cluster_perm in group.cluster_permissions : {
        cluster_name     = cluster_perm.cluster_name
        group_name       = group.name
        permission_level = cluster_perm.permission_level
      }
    ]
  ])
}

resource "databricks_permissions" "cluster_permissions" {
  for_each = {for perm in local.groups_clusters: perm.cluster_name => perm...}

  cluster_id = each.key

  dynamic "access_control" {
    for_each = toset(each.value)

    content {
      group_name       = access_control.value.group_name
      permission_level = access_control.value.permission_level
    }
  }
}