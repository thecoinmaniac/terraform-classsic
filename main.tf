module "vpc" {
  source = "./modules/vpc"

  instance-tenancy = "default"
  enable-dns-support = "true"
  enable-dns-hostnames = "true"
  vpc-name = "barclays-vpc"
  vpc-location = "Ohio"
  region = "us-east-2"
  internet-gateway-name = "barclays-igw"
  map_public_ip_on_launch = "true"
  public-subnets-name = "barclays-public-subnets"
  public-subnets-location = "Ohio"
  public-subnet-routes-name = "barclays-public-subnet-routes"
  private-subnets-location-name = "Ohio"
  private-subnet-name = "barclays-private-subnets"
  total-nat-gateway-required = "1"
  eip-for-nat-gateway-name = "barclays-eip-nat-gateway"
  nat-gateway-name = "barclays-nat-gateway"
  private-route-cidr = "0.0.0.0/0"
  private-route-name = "barclays-private-route"
  vpc-cidr = "10.11.0.0/16"
  vpc-public-subnet-cidr = ["10.11.1.0/24","10.11.2.0/24","10.11.3.0/24"]
  vpc-private-subnet-cidr = ["10.11.4.0/24","10.11.5.0/24","10.11.6.0/24"]
}
