terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "GuyGamliel-dev-vpc" {
  cidr_block = "192.168.1.0/24"
  tags = {
    Name = "GuyGamliel-dev-vpc"
  }
}

resource "aws_subnet" "GuyGamliel-k8s-subnet" {
  vpc_id     = aws_vpc.GuyGamliel-dev-vpc.id
  cidr_block = "192.168.1.0/27"
  availability_zone = "us-east-1f"

  tags = {
    Name = "GuyGamliel-k8s-subnet"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.GuyGamliel-dev-vpc.id

  tags = {
    Name = "gateway"
  }
}

resource "aws_route" "routeIGW" {
  route_table_id         = aws_vpc.GuyGamliel-dev-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

