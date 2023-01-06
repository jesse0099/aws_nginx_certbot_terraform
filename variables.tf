variable "subnet_id" {
  type        = string
  default     = ""
  description = "aws subnet id where services are intended to be available"
}

variable "ami" {
  type        = string
  default     = ""
  description = "valid amazon machine image"
}

variable "instance_type" {
  type        = string
  default     = ""
  description = "aws ec2 instance type compatible with selected ami"
}

# Next iteration: module to create a new aws ec2 keypair
variable "key_name" {
  type        = string
  default     = ""
  description = "existing aws ec2 key pair name"
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
  description = "aws region to allocate the ec2 instance"
}