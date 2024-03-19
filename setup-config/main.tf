# VPC

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "Jenkins-vpc"
  cidr = var.vpc_cidr

  azs                     = data.aws_availability_zones.azs.names
  public_subnets          = var.vpc_public_subnets
  map_public_ip_on_launch = true

  enable_dns_hostnames = true

  tags = {
    Name        = "Jenkins-vpc"
    Terraform   = "true"
    Environment = "dev"
  }

  public_subnet_tags = {
    Name = "Jenkins-subnet"
  }
}

# Security group 
module "sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "Jenkins-sg"
  description = "Security group for Jenkins Server"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Name = "Jenkins-sg"
  }
}


# EC2 instance
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "Jenkins-Eks"

  instance_type               = var.instance_type
  ami                         = data.aws_ami.example.id
  key_name                    = var.key_name
  monitoring                  = true
  vpc_security_group_ids      = [module.sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true

  user_data = file("server-script.sh")

  tags = {
    Name        = "Jenkins-server"
    Terraform   = "true"
    Environment = "dev"
  }
}