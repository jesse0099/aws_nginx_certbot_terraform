data "aws_caller_identity" "current" {}

locals {
  ami                           = var.ami
  instance_type                 = var.instance_type
  key_name                      = var.key_name
  subnet_id                     = var.subnet_id
  ec2_instance_tags             = var.ec2_instance_tags
  to_execute_playbooks          = var.to_execute_playbooks
  local_provider_host_key_check = var.local_provider_host_key_check
  ansible_playbooks_path        = var.ansible_playbooks_path
  ansible_inventory_path        = var.ansible_inventory_path
  white_space                   = var.white_space
  region                        = var.region
  yml_extension                 = var.yml_extension
  project                       = var.project
  environment                   = var.environment
  terraform_location            = var.terraform_location
  security_group_ids            = var.security_group_ids
  pem_path                      = var.pem_path
  ssh_key_name  = var.ssh_key_name
  # Creating commands sequence to execute the playbooks
  playbook_command_sequences = <<EOT
%{~for i, playbook in local.to_execute_playbooks~}
sleep 4 && ANSIBLE_HOST_KEY_CHECKING=${local.local_provider_host_key_check~}
${local.white_space}ansible-playbook -i ${local.ansible_inventory_path}/host${local.white_space~}
${local.ansible_playbooks_path}/${playbook}.${local.yml_extension~} 
%{if i < length(local.to_execute_playbooks) - 1} && %{endif}
%{~endfor~}
EOT
}

output "playbooks_script" {
  value = local.playbook_command_sequences
}

provider "aws" {
  region = local.region

  default_tags {
    tags = {
      Project     = local.project
      Environment = local.environment
      CostCode    = local.project
      Terraform   = local.terraform_location
    }
  }
}


resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

output "private_key" {
  value     = tls_private_key.private_key.private_key_pem
  sensitive = true
}

resource "aws_key_pair" "key_pair" {
  key_name   = local.ssh_key_name
  public_key = tls_private_key.private_key.public_key_openssh
}

resource "aws_instance" "ec2_instance" {
  ami                    = local.ami
  instance_type          = local.instance_type
  key_name               = local.key_name
  subnet_id              = local.subnet_id
  tags                   = local.ec2_instance_tags
  vpc_security_group_ids = local.security_group_ids
  associate_public_ip_address = true
  # # Get assigned public IP to set an Ansible inventory
  provisioner "local-exec" {
    command = "sleep 4 && echo '[server]\n ${self.private_ip} \n' > ${local.ansible_inventory_path}/host"
  }

  # # Execute ansible-playbooks 
  provisioner "local-exec" {
    command = local.playbook_command_sequences != "" ? "${local.playbook_command_sequences}" : "echo 'No playbooks selected.'"
  }

}

# # Write private key to file
resource "local_file" "private_key_file" {
  filename = local.pem_path
  content  = tls_private_key.private_key.private_key_pem
}
