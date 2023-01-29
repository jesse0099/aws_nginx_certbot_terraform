locals {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  ec2_instance_tags      = var.ec2_instance_tags
  to_execute_playbooks   = var.to_execute_playbooks
  local_provider_shebang = var.local_provider_shebang
  playbooks_script       = <<EOT 
${local_provider_shebang}\n
%{~for playbook, execute_it in local.to_execute_playbooks~}
${playbook}
%{~endfor~}
  EOT
  # timestamp     = formatdate("YYYYMMDD", timestamp())
  region = var.region
}

output "playbooks_script" {
  value = local.playbooks_script
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

  # # Get assigned public IP to set an Ansible inventory
  provisioner "local-exec" {
    command = "echo '[server]\n ${self.public_ip} \n' > ./Playbooks/host"
  }

  # # Create bash script to execute ansible playbooks



}