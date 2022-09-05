#!/bin/bash
terraform destroy -var-file='secrets.tfvars' -auto-approve