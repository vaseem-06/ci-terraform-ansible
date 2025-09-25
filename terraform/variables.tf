variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "key_name" {
  type        = string
  description = "Name of EC2 keypair (must already exist in the region)"
  default     = "new"
}

variable "ami_amazon_linux" {
  type        = string
  description = "AMI ID for Amazon Linux (c8.local). If blank, supply via -var."
  default     = "ami-0886832e6b5c3b9e2"
}

variable "ami_ubuntu" {
  type        = string
  description = "AMI ID for Ubuntu 21.04 (u21.local). If blank, supply via -var."
  default     = "ami-0bbdd8c17ed981ef9"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}
