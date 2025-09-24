variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "key_name" {
  default = "my-keypair"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-0c94855ba95c71c99" # Change this to a region-appropriate latest Ubuntu AMI
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr
  availability_zone = "${var.region}a"
}

resource "aws_key_pair" "main" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub") # Update with your public key path
}

resource "aws_instance" "main" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.main.id
  key_name      = aws_key_pair.main.key_name

  root_block_device {
    volume_size = 10 # 10GB root volume
    volume_type = "gp2"
  }

  tags = {
    Name = "Terraform-EC2"
  }
}

resource "aws_ebs_volume" "extra" {
  availability_zone = aws_instance.main.availability_zone
  size              = 10 # 10GB EBS
  tags = {
    Name = "Terraform-EBS"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.extra.id
  instance_id = aws_instance.main.id
  force_detach = true
}

output "instance_public_ip" {
  value = aws_instance.main.public_ip
}

output "ebs_volume_id" {
  value = aws_ebs_volume.extra.id
}

output "subnet_id" {
  value = aws_subnet.main.id
}

resource "aws_instance" "tbd-instances" {
  count         = 2
  ami           = "ami-0360c520857e3138f"  # Ubuntu 24.04 LTS AMI (example ID)
  instance_type = "t2.micro"               # Default instance type

  key_name      = "demokey.pem"

  tags = {
    Name = "tbd-${count.index + 1}"
  }
}