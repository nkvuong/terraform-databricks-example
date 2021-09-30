#!/bin/bash

####################################################
# init terraform, and populate secret vars
####################################################
./init.sh

########################################################################
#deploy Terraform stack (aws metastore resources and 2 workspaces)
########################################################################
echo "Plan, Apply or Destroy the Terraform stack: "
select tf in "Plan" "Apply" "Destroy"; do
  case $tf in  
    Plan ) ./plan-workspaces.sh ;;
    Apply ) ./apply-workspaces.sh ;;
    Destroy ) ./destroy-workspaces.sh ;;
  esac
  break
done

retVal=$?
if [ $retVal -ne 0 ]; then
    echo "Terraform Module databricks-workspaces did not complete successfully"
    exit $retVal
fi