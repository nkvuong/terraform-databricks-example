#!/bin/bash

terraform apply -var-file='secrets.tfvars' -auto-approve
