terraform {
  backend "s3" {
    bucket       = "terraform-bucket-virajitha"  #bucket where you want to store the state file which already exists in the environment
    key          = "ec2-basics/project1/terraform.tfstate"      #prefix of the s3 bucket where u want to store the state file
    use_lockfile = true
    region       = "us-east-1"
    profile = "terraform"
  }
}