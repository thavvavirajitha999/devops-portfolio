"# Ec2 Basic Module" 

# Creating a eimple Ec2 instance in dev and qa environments
# Dev environment terraform lifecycle commands


terraform init -backend-config=backend-dev.hcl


terraform validate

terraform fmt

terraform plan --var-file="dev.tfvars"
terraform apply --var-file="dev.tfvars"

terraform state list

terraform destroy --var-file="dev.tfvars"
===============================================================
# Qa environments terraform lifecycle commands

terraform init -reconfigure -backend-config=backend-qa.hcl

terraform validate 

terraform fmt

terraform plan --var-file="qa.tfvars"
terraform apply --var-file="qa.tfvars"

terraform state list

terraform destroy --var-file="qa.tfvars"

================================================================

# migrate vs reconfigure
1. terraform init -migrate-state
Think of this as moving your house to a new address.

You already have a state file (your “house contents”) in one backend (say, an old S3 bucket).

If you change the backend config (new bucket, new region, etc.), Terraform says: “Okay, I’ll pick up your state and move it to the new place.”

Use this when you want to keep your existing resources tracked but just change where the state is stored.

Example: You deployed EC2 instances already, and now you want the state file to live in a different S3 bucket. You don’t want Terraform to forget those instances, so you migrate the state.

2. terraform init -reconfigure
Think of this as starting fresh with a new address but leaving your old house behind.

Terraform won’t move the old state; it just reconfigures itself to use the new backend.

Use this when you’re setting up a new environment (like QA vs Prod) and you don’t want to carry over the old state.

Example: You’re spinning up a QA environment with its own bucket and state file. You don’t care about the Prod state, so you reconfigure instead of migrating.