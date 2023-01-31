ami           = "ami-0b0ea68c435eb488d"
instance_type = "t2.small"
key_name      = "chris_temp"
subnet_id     = "subnet-00f250128e8ac461f"
ec2_instance_tags = {
  Name        = "percy-tailscale-vpn-EC2",
  Description = "Tailscale exit node/relay for percy-laravel-forge VPC.",
  CreatedBy   = "jesse.chavez"
}
region               = "us-east-1"
to_execute_playbooks = ["apt_install_playbook", "tailscale_playbook"]
