variable "vpc_region" {
    default = "us-east-2"  
}

variable "vpc-id" {
  default = ""
}

data "aws_subnet_ids" "public-1" {
  vpc_id = "${var.vpc-id}"
  filter {
    name   = "tag:Name"
    values = ["barclays-public-subnets-1"]       
  }
}
