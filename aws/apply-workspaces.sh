#!/bin/bash

terraform apply -var-file='secrets.tfvars' -var-file='workspace.tfvars' -auto-approve
