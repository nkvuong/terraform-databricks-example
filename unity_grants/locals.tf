locals {
  catalog_access = [
    {
      catalog_name = "vuong_nguyen"
      grants = [
        { group_name = "dataengineers", catalog_privileges = ["SELECT", "USE_CATALOG", "USE_SCHEMA"] },
        { group_name = "admins_demo", catalog_privileges = ["ALL_PRIVILEGES"] }
      ]
    }
  ]
  schema_access = [
    {
      schema_name = "vuong_nguyen.default"
      grants = [
        { group_name = "dataengineers", schema_privileges = ["CREATE_TABLE", "MODIFY"] },
        { group_name = "admins_demo", schema_privileges = ["ALL_PRIVILEGES"] }
      ]
  }
  ]
  table_access = [
    {
    table_name = "vuong_nguyen.default.student"
    grants = [
      { group_name = "dataengineers", table_privileges = ["MODIFY", "SELECT"] },
      { group_name = "admins_demo", table_privileges = ["ALL_PRIVILEGES"] }
    ]
  }
  ]
}
