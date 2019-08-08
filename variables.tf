variable "vpc_region" {
    default = "us-east-2"  
}

variable "vpc-id" {
  default = ""
}

data "aws_subnet_ids" "public-1" {
  vpc_id = "${var.vpc_id}"
  filter {
    name   = "tag:Name"
    values = ["barclays-public-subnets-1"]       
  }
}
