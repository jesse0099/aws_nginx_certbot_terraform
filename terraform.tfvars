ami           = "ami-0b0ea68c435eb488d"
instance_type = "t2.small"
key_name      = "chris_temp"
subnet_id     = "subnet-0e76845edaa2b9bda"
ec2_instance_tags = {
  Name        = "template-test",
  Description = "Terraform ec2 instance template",
  CreatedBy   = "jesse.chavez"
}
region               = "us-east-1"
to_execute_playbooks = ["apt_install_playbook", "portainer_agent_playbook"]
