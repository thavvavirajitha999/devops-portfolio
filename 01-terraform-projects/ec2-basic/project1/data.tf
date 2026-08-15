data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["default"] #Fetches vpc is with name=default tag from console
  }
}

data "aws_subnets" "subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}