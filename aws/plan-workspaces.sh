#!/bin/bash

terraform plan -var-file='secrets.tfvars' -var-file='workspace.tfvars'
