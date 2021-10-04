variable "bucket_name" {
  type = string
}

variable "cross_account_role_arn" {
  type = string
}

variable "cmk_alias" {
  type = string  
}

variable "cmk_arn" {
  type = string
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
