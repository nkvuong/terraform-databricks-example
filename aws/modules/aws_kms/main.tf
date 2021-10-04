resource "aws_kms_key" "customer_managed_key" {
  policy = data.aws_iam_policy_document.databricks_cmk.json
  tags = var.tags
}

resource "aws_kms_alias" "customer_managed_key_alias" {
  name_prefix   = "alias/${var.prefix}"
  target_key_id = aws_kms_key.customer_managed_key.key_id
}
