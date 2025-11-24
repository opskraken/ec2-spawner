variable "aws_region" {
description = ""
type        = string
default     = "us-east-2" # Change to your desired region
}

variable "instance_type" {
description = ""
type        = string
default     = "t2.micro"
}

variable "ami_id" {
description = ""
type        = string

default     = "ami-001117ee91f2f35c9"
}

variable "key_pair_name" {
description = ""
type        = string
default     = "kraken" 
}


variable "vpc_cidr_block" {
description = ""
type        = string
default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
description = ""
type        = string
default     = "10.0.1.0/24"
}
