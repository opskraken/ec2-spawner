variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance (Amazon Linux 2023 recommended)"
  type        = string
  default     = "ami-001117ee91f2f35c9"
}

variable "instance_count" {
  description = "Number of EC2 instances to provision"
  type        = number
  default     = 5
}

variable "public_key_path" {
  description = "Path to the public SSH key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 10
}
