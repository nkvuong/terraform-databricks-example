aws_profile        = "aws-sandbox-flight-school_databricks-power-user"
region             = "us-west-2"
cross_account_role = "e2-deploy-cert-vuong-nguyen"
tags = {
  Owner = "vuong.nguyen@databricks.com"
}
cidr_block             = "10.4.0.0/16"
prefix                 = "vn-demo"
workspace_vpce_service = "com.amazonaws.vpce.us-west-2.vpce-svc-0129f463fcfbc46c5"
relay_vpce_service     = "com.amazonaws.vpce.us-west-2.vpce-svc-0158114c0c730c3bb"
