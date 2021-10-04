resource "aws_kms_key" "storage_customer_managed_key" {
  policy = data.aws_iam_policy_document.databricks_storage_cmk.json
  tags = var.tags
}

resource "aws_kms_alias" "storage_customer_managed_key_alias" {
  name_prefix   = "alias/${var.prefix}-databricks-storage"
  target_key_id = aws_kms_key.storage_customer_managed_key.key_id
}

resource "aws_kms_key" "managed_services_customer_managed_key" {
  policy = data.aws_iam_policy_document.databricks_managed_services_cmk.json
  tags = var.tags
}

resource "aws_kms_alias" "managed_services_customer_managed_key_alias" {
  name_prefix   = "alias/${var.prefix}-databricks-managed-services"
  target_key_id = aws_kms_key.managed_services_customer_managed_key.key_id
}
