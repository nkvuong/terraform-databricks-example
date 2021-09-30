#!/bin/bash
terraform destroy -var-file='secrets.tfvars' -var-file='workspace.tfvars' -auto-approve