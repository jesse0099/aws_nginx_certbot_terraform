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

  # Creating commands sequence to execute the playbooks
  playbook_command_sequences = <<EOT
%{~for i, playbook in local.to_execute_playbooks~}
ANSIBLE_HOST_KEY_CHECKING=${local.local_provider_host_key_check~}
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
}

resource "aws_instance" "ec2_instance" {
  ami           = local.ami
  instance_type = local.instance_type
  key_name      = local.key_name
  subnet_id     = local.subnet_id
  tags          = local.ec2_instance_tags

  # # Get assigned public IP to set an Ansible inventory
  provisioner "local-exec" {
    command = "echo '[server]\n ${self.public_ip} \n' > ${local.ansible_inventory_path}/host"
  }

  # # Execute ansible-playbooks 
  provisioner "local-exec" {
    command = local.playbook_command_sequences
  }

}