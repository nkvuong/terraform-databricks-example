variable "bucket_name" {
  type = string
}

variable "cross_account_role_arn" {
  type = string
}

variable "managed_services_cmk" {
}

variable "storage_cmk" {
}

variable "databricks_account_id" {
  type = string
}

variable "prefix" {
  type = string
}

variable "region" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "relay_id" {
  type = string
}

variable "backend_rest_id" {
  type = string
}
