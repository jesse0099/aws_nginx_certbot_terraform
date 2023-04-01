ami           = "ami-0b0ea68c435eb488d"
instance_type = "t2.micro"
key_name      = "chris_temp"
subnet_id     = "subnet-06f4689f155cc7232" #PERCY-INFRA-PUBLIC-US-EAST-1A

ec2_instance_tags = {
    Name = ""
    Description = "Signals test environment instance."
}

security_group_ids = [
    "sg-08f4e9d8f63b4a0e1", #Tailscale SG for Percy infra
    "sg-49b70033"  #AllowWebAccess
]

environment        = "prod"
project            = "signals-backend"
terraform_location = "https://github.com/jesse0099/aws_nginx_certbot_terraform"

region               = "us-east-1"
to_execute_playbooks = ["apt_install_playbook", "tailscale_playbook"]
