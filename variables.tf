variable "subnet_id" {
  type        = string
  description = "aws subnet id where services are intended to be available."
}

variable name {
  type        = string
  description = "description"
}

variable "use_existing_ssh_key" {
  type        = string
  description = "Decide if the 'terraform apply' creates a new SSH key, or use an existing one."
}

variable "ami" {
  type        = string
  description = "Valid amazon machine image."
}

variable "instance_type" {
  type        = string
  description = "aws ec2 instance type compatible with selected ami"
}

# Next iteration: module to create a new aws ec2 keypair
variable "key_name" {
  type        = string
  description = "existing aws ec2 key pair name"
}

variable "ssh_key_name" {
  type        = string
  description = "New SSH key name."
}


# Next iteration: default tags based on the local aws cli profile
variable "ec2_instance_tags" {
  type        = map(string)
  default     = {}
  description = "ec2 instance tags map(key:value)"
}

variable "region" {
  type        = string
  default     = ""
  description = "aws region to allocate the ec2 instance."
}

variable "local_provider_host_key_check" {
  type        = bool
  default     = false
  description = "local  provider host key checking."
}

variable "ansible_playbooks_path" {
  type        = string
  default     = "./Playbooks"
  description = "local ansible-playbooks path (can be relative)."
}

variable "ansible_inventory_path" {
  type        = string
  default     = "./Playbooks"
  description = "local ansible-inventory path (can be relative)."
}

variable "white_space" {
  type        = string
  default     = " "
  description = "white space."
}

variable "yml_extension" {
  type        = string
  default     = "yml"
  description = "yml extension."
}

variable "to_execute_playbooks" {
  type        = list(string)
  default     = []
  description = "list of ansible-playbook names (without extension) to be executed."
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "Instance VPC attached security groups."
}

variable "environment" {
  type        = string
  description = "Project environment. (dev, test, stage, prod...)"
}

variable "project" {
  type        = string
  description = "Project name."
}

variable "terraform_location" {
  type        = string
  description = "Terraform project location to use on AWS tagging."
}

variable "pem_path" {
  type        = string
  description = "Path to local pem copy."
}
