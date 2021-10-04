output "cmk_alias" {
  value = aws_kms_alias.customer_managed_key_alias.name
}

output "cmk_arn" {
  value = aws_kms_key.customer_managed_key.arn
}
