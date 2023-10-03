ami           = "ami-0b0ea68c435eb488d"
instance_type = "t2.micro"
key_name      = "chris_temp"
ssh_key_name = ""
subnet_id     = "subnet-1c7f907b" #Primary VPC
pem_path      = "./ssh_key.pem"

ec2_instance_tags = {
  Name        = "signals-frontend-test-ec2"
  Description = "Signals test environment instance(FrontEnd)."
}

security_group_ids = [
  "sg-0465700b6dbe402d5", #Tailscale SG Primary VPC
  "sg-49b70033"           #AllowWebAccess
]

environment        = "test"
project            = "signals-frontend"
terraform_location = "https://github.com/jesse0099/aws_nginx_certbot_terraform"

region               = "us-east-1"
to_execute_playbooks = []
