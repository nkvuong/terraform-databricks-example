output "storage_cmk" {
  value = {
    key_alias = aws_kms_alias.storage_customer_managed_key_alias.name
    key_arn = aws_kms_key.storage_customer_managed_key.arn
  }
}

output "managed_services_cmk" {
  value = {
    key_alias = aws_kms_alias.managed_services_customer_managed_key_alias.name
    key_arn = aws_kms_key.managed_services_customer_managed_key.arn
  }
}