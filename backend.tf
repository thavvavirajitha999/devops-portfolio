terraform {
  backend "s3" {
    use_lockfile = true
    profile = "terraform"
    bucket = "terraform-bucket-virajitha"
    key = "vpc/terraform.tfstate"
    region = "us-east-1"
  }
}