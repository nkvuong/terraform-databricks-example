variable "databricks_account_username" {
  type = string
}
variable "databricks_account_password" {
  type = string
}
variable "databricks_account_id" {
  type = string
}

variable "tags" {
}

variable "cidr_block" {
  type = string
}

variable "region" {
  type = string
}

variable "aws_profile" {
  type = string
}

variable "cross_account_role" {
  type = string
}

variable "prefix" {
  type = string  
}

variable "private_dns_enabled" { 
  default = true 
}

variable "workspace_vpce_service" {

}
variable "relay_vpce_service" {

}