resource "aws_kms_key" "dbfs_customer_managed_key" {
  policy = data.aws_iam_policy_document.databricks_dbfs_cmk.json
  tags = var.tags
}

resource "aws_kms_alias" "dbfs_customer_managed_key_alias" {
  name_prefix   = "alias/${var.prefix}-dbfs"
  target_key_id = aws_kms_key.dbfs_customer_managed_key.key_id
}

resource "aws_kms_key" "cp_customer_managed_key" {
  policy = data.aws_iam_policy_document.databricks_cp_cmk.json
  tags = var.tags
}

resource "aws_kms_alias" "cp_customer_managed_key_alias" {
  name_prefix   = "alias/${var.prefix}-cp"
  target_key_id = aws_kms_key.cp_customer_managed_key.key_id
}
