variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.large"
}

variable "instance_count" {
  description = "Number of EC2 instances to provision"
  type        = number
  default     = 1
}

variable "volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 10
}
