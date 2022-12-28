variable "subnet_id" {
    type = string
    default = ""
    description = "aws subnet id where service is intended to be available"
}

variable ami {
  type        = string
  default     = ""
  description = "valid amazon machine image"
}

variable instance_type {
  type        = string
  default     = ""
  description = "aws ec2 instance type compatible with selected ami"
}

# Module to create a new aws ec2 keypair
variable key_name {
  type        = string
  default     = ""
  description = "aws ec2 key pair name"
}


