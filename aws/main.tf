resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}

locals {
  prefix = "${var.prefix}-${random_string.naming.result}"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.7.0"

  name = local.prefix
  cidr = var.cidr_block
  azs  = data.aws_availability_zones.available.names
  tags = var.tags

  enable_dns_hostnames = true
  enable_nat_gateway   = true
  create_igw           = true

  public_subnets = [cidrsubnet(var.cidr_block, 4, 0)]
  private_subnets = [
    cidrsubnet(var.cidr_block, 4, 1),
    cidrsubnet(var.cidr_block, 4, 2),
    cidrsubnet(var.cidr_block, 4, 3)
  ]

  manage_default_security_group = true
  default_security_group_name   = "${local.prefix}-sg"

  default_security_group_egress = [{
    cidr_blocks = "0.0.0.0/0"
  }]

  default_security_group_ingress = [{
    description = "Allow all internal TCP and UDP"
    self        = true
  }]
}

module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "3.7.0"

  vpc_id             = module.vpc.vpc_id
  security_group_ids = [module.vpc.default_security_group_id]

  endpoints = {
    s3 = {
      service         = "s3"
      service_type    = "Gateway"
      route_table_ids = flatten([module.vpc.private_route_table_ids, module.vpc.public_route_table_ids])
      tags = {
        Name = "${local.prefix}-s3-vpc-endpoint"
      }
    },
    sts = {
      service             = "sts"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = "${local.prefix}-sts-vpc-endpoint"
      }
    },
    kinesis-streams = {
      service             = "kinesis-streams"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = "${local.prefix}-kinesis-vpc-endpoint"
      }
    },
  }

  tags = var.tags
}
module "s3_root_bucket" {
  source             = "terraform-aws-modules/s3-bucket/aws"
  version            = "2.9.0"
  bucket             = "${local.prefix}-rootbucket"
  ignore_public_acls = true
  attach_policy      = true
  policy             = data.databricks_aws_bucket_policy.this.json

  # Allow deletion of non-empty bucket
  force_destroy = true

  tags = var.tags
}

module "aws_kms" {
  source = "./modules/aws_kms"

  cross_account_role_arn = data.aws_iam_role.cross_account_role.arn
  prefix                 = local.prefix
  tags                   = var.tags
}
module "databricks_mws_workspace" {
  source = "./modules/databricks_workspace"
  providers = {
    databricks = databricks.mws
  }

  databricks_account_id  = var.databricks_account_id
  prefix                 = local.prefix
  security_group_ids     = [module.vpc.default_security_group_id]
  subnet_ids             = module.vpc.private_subnets
  vpc_id                 = module.vpc.vpc_id
  cross_account_role_arn = data.aws_iam_role.cross_account_role.arn
  bucket_name            = module.s3_root_bucket.s3_bucket_id
  cmk_alias              = module.aws_kms.cmk_alias
  cmk_arn                = module.aws_kms.cmk_arn
  region                 = var.region
}

// create PAT token to provision entities within workspace
resource "databricks_token" "pat" {
  provider         = databricks.created_workspace
  comment          = "Terraform Provisioning"
  lifetime_seconds = 86400
}
