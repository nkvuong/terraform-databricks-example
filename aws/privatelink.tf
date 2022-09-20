// this subnet houses the data plane VPC endpoints
resource "aws_subnet" "dataplane_vpce" {
  vpc_id     = module.vpc.vpc_id
  cidr_block = local.subnets[4]

  tags = merge(var.tags, {
    Name = "${local.prefix}-${module.vpc.vpc_id}-pl-vpce"
  })
}

resource "aws_route_table" "this" {
  vpc_id = module.vpc.vpc_id

  tags = merge(var.tags, {
    Name = "${local.prefix}-${module.vpc.vpc_id}-pl-local-route-tbl"
  })
}

resource "aws_route_table_association" "dataplane_vpce_rtb" {
  subnet_id      = aws_subnet.dataplane_vpce.id
  route_table_id = aws_route_table.this.id
}

resource "aws_security_group" "dataplane_vpce" {
  name        = "Data Plane VPC endpoint security group"
  description = "Security group shared with relay and workspace endpoints"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Inbound rules"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = concat([local.subnets[4]], local.private_subnets)
  }

  ingress {
    description = "Inbound rules"
    from_port   = 6666
    to_port     = 6666
    protocol    = "tcp"
    cidr_blocks = concat([local.subnets[4]], local.private_subnets)
  }

  egress {
    description = "Outbound rules"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = concat([local.subnets[4]], local.private_subnets)
  }

  egress {
    description = "Outbound rules"
    from_port   = 6666
    to_port     = 6666
    protocol    = "tcp"
    cidr_blocks = concat([local.subnets[4]], local.private_subnets)
  }

  tags = merge(var.tags, {
    Name = "${local.prefix}-${module.vpc.vpc_id}-pl-vpce-sg-rules"
  })
}

resource "aws_vpc_endpoint" "backend_rest" {
  vpc_id              = module.vpc.vpc_id
  service_name        = var.workspace_vpce_service
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.dataplane_vpce.id]
  subnet_ids          = [aws_subnet.dataplane_vpce.id]
  private_dns_enabled = var.private_dns_enabled
}

resource "aws_vpc_endpoint" "relay" {
  vpc_id              = module.vpc.vpc_id
  service_name        = var.relay_vpce_service
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.dataplane_vpce.id]
  subnet_ids          = [aws_subnet.dataplane_vpce.id]
  private_dns_enabled = var.private_dns_enabled
}
