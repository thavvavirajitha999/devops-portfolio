# Simple VPC Module 
Creating simple vpc module with
    2 public subnets
    2 private subnets
    igw if we give true
    nat based on the input
    public route based on the input
    private routes for internet connectivity using NAT
    one security group allwoing ssh from my ip
    one ec2 instance in each az for high availablity

Utilized workspaces to isolate the dev and qa environments using tfvars file.

# Initialization

1. Initialize with backend config from .tfvars:

terraform init -backend-config="bucket=terraform-bucket-virajitha" -backend-config="region=us-east-1" 
This wires up the backend (S3 bucket, region, key) for state storage.

2. Create/select workspace:


terraform workspace new dev   # if workspace doesnt exist creates and switches to new workspace
terraform workspace select dev


3. Apply with environment variables:

terraform workspace show
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"

3. Destroying the deployment

terraform destroy -var-file="dev.tfvars"

# Points to be noted
* All the module.******** values u are using while calling the module should exits in the output section of the module
* The description for dynamic values will be shown from main.tf file

# Verifying workspace

In the s3 storing the state file there will env created for your workspace each carrying different state file isolating the dev and qa environments.
