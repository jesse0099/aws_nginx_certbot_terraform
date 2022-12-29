locals {
  ami               = var.ami
  instance_type     = var.instance_type
  key_name          = var.key_name
  subnet_id         = var.subnet_id
  ec2_instance_tags = var.ec2_instance_tags
  # timestamp     = formatdate("YYYYMMDD", timestamp())
  region = var.region
}

provider "aws" {
  region = local.region
}

resource "aws_instance" "dev-ssmseguridad" {
  ami           = local.ami
  instance_type = local.instance_type
  key_name      = local.key_name
  subnet_id     = local.subnet_id
  tags          = local.ec2_instance_tags

  # provisioner "local-exec" {
  #   command = "echo '[server]\n ${self.public_ip} \n' > host"
  # }
  # # Install nginx and certbot
  # provisioner "local-exec" {
  #   command = "sleep 4 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i host ./nginx_certbot_install_playbook.yml"
  # }
  # # Install docker engine and compose plugin
  # provisioner "local-exec" {
  #   command = "sleep 4 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i host ./docker_install_playbook.yml"
  # }
  # # Compose up the apps
  # provisioner "local-exec" {
  #   command = "sleep 4 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i host ./services_up_playbook.yml"
  # }
  # # Set up nginx server blocks and certbot ssl support
  # provisioner "local-exec" {
  #   command = "sleep 4 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i host ./server_blocks_ssl_playbook.yml"
  # }
}