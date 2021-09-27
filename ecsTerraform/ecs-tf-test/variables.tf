variable "name" {
  default = "test-tf-ecs"
}

variable "vpc_id" {
  default = "vpc-09de1b6e"
}

variable "subnet_private_id" {
  default = "subnet-523c8a09"
}

variable "alb_security_group" {
  type    = list(string)
  default = ["sg-f3059e8a"]
}

variable "aws_region" {
  default = "us-west-1"
}
