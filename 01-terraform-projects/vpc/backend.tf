terraform {
  backend "s3" {
    use_lockfile = true
    profile = "terraform"
    bucket = var.bucket
    key = "vpc/terraform.tfstate"
    region = var.region
  }
}