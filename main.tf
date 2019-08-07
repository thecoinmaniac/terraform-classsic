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
  total-nat-gateway-required = "3"
  eip-for-nat-gateway-name = "barclays-eip-nat-gateway"
  nat-gateway-name = "barclays-nat-gateway"
  private-route-cidr = "0.0.0.0/0"
  private-route-name = "barclays-private-route"
  vpc-cidr = "10.11.0.0/16"
  vpc-public-subnet-cidr = ["10.11.1.0/24","10.11.2.0/24","10.11.3.0/24"]
  vpc-private-subnet-cidr = ["10.11.4.0/24","10.11.5.0/24","10.11.6.0/24"]
}

module "sg-bastion" {
  source = "./modules/sg-bastion"
  region = "us-east-2"
  vpc-id = "${module.vpc.vpc-id}"
  ec2-sg-name = "bastion-sg"

  ###SECURITY INBOUND GROUP RULES###
  #RULE-1-INBOUND-RULES
  rule-1-from-port = 22
  rule-1-protocol = "tcp"
  rule-1-to-port = 22
  rule-1-cidr_blocks = "0.0.0.0/0"


  ###SECURITY GROUP OUTBOUND RULES###
  #RULE-1-OUTBOUND-RULES
  outbound-rule-1-from-port = 0
  outbound-rule-1-protocol = "-1"
  outbound-rule-1-to-port = 0
  outbound-rule-1-cidr_blocks = "0.0.0.0/0"

  #NOTE: ONLY ALL PORTS WILL BE "" & CIDR BLOCK WILL IN COMMAS ""
}

module "bastion-server" {
  source = "./modules/bastion-server"
  region = "us-east-2"
  key-name = "bastion-key"
  ami-id = "ami-08935252a36e25f85"
  instance-type = "t2.micro"
  number-of-ec2-instances-required = "1"
  public-key-file-name = "${file("./modules/bastion-server/bastion-key.pub")}"

  instance-name-taq = "bastion-server"
  associate-public-ip-address = "true"

  vpc-security-group-ids = "${module.sg-bastion.ec2-sg-security-group}"
  ec2-subnets-ids = ["${module.vpc.public-subnet-ids}"]

  #IN CASE OF LAUNCHING EC2 IN SPECIFIC SUBNETS OR PRIVATE SUBNETS, PLEASE UN-COMMENT BELOW"
  #ec2-subnets-ids = ["${module.cloudelligent-vpc.private-subnet-ids}"]
  #ec2-subnets-ids = ["","","","","",""]
  #user-data = "${file("./modules/ec2/httpd.sh")}"


}