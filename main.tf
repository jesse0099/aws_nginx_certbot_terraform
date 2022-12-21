variable "subnet_id" {
    type = string
}

data "aws_subnet" "selected"{
    id = var.subnet_id
}

locals {
  timestamp = formatdate("YYYYMMDD", timestamp())
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "dev-ssmseguridad" {
  ami           = "ami-0b0ea68c435eb488d"
  instance_type = "t2.small"
  key_name = "dev_jese_chavez_20222012"
  subnet_id =  data.aws_subnet.selected.id
  tags = {
    Name = "dev-ssmseguridad-${local.timestamp}",
    Description = "ssmseguridad docker-compose exposing instance.",
    CreatedBy = "jeseabraham.chavez"
  }

  provisioner "local-exec" {
    command = "echo '[server]\n ${self.public_ip} \n' > host"
  }
  # Install nginx and certbot
  provisioner "local-exec" {
    command = "sleep 4 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i host ./nginx_certbot_install_playbook.yml"
  }
  # Install docker engine and compose plugin
  provisioner "local-exec" {
    command = "sleep 4 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i host ./docker_install_playbook.yml"
  }
  # Compose up the apps
  provisioner "local-exec" {
    command = "sleep 4 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i host ./services_up_playbook.yml"
  }
  # Set up nginx server blocks and certbot ssl support
  provisioner "local-exec" {
    command = "sleep 4 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i host ./server_blocks_ssl_playbook.yml"
  }
}