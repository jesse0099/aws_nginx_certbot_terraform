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

  provisioner "local-exec" {
    command = "echo '[server]\n ${self.public_ip} \n' > ./Playbooks/host"
  }
  # # Install all necessary packages
  provisioner "local-exec" {
    command = "sleep 4 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ./Playbooks/host ./Playbooks/apt_install_playbook.yml"
  }
  # # Set up nginx server blocks 
  provisioner "local-exec" {
    command = "sleep 4 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ./Playbooks/host ./Playbooks/nginx_virtual_hosts_playbook.yml"
  }

  # # Certify domains 
  provisioner "local-exec" {
    command = "sleep 4 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ./Playbooks/host ./Playbooks/certbot_certify_domains_playbook.yml"
  }

  # # Execute services
  provisioner "local-exec" {
    command = "sleep 4 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ./Playbooks/host ./Playbooks/services_up_playbook.yml"
  }  

  # # Portainer agent
  provisioner "local-exec" {
    command = "sleep 4 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ./Playbooks/host ./Playbooks/portainer_agent_playbook.yml"
  }  
}