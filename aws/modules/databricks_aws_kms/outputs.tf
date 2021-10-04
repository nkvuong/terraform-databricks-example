output "storage_cmk" {
  value = {
    key_alias = aws_kms_alias.dbfs_customer_managed_key_alias.name
    key_arn = aws_kms_key.dbfs_customer_managed_key.arn
  }
}

output "managed_services_cmk" {
  value = {
    key_alias = aws_kms_alias.cp_customer_managed_key_alias.name
    key_arn = aws_kms_key.cp_customer_managed_key.arn
  }
}