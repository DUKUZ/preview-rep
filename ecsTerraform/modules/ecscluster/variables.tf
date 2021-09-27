variable "vpc_id" {
  default = "vpc-09de1b6e"
}

variable "ecs_instance_keyname" {
  default = "nexant-tf"
}

variable "subnet_private_id" {
  default = "subnet-523c8a09"
}

variable "alb_security_group" {
  type    = list(string)
  default = ["sg-f3059e8a"]
}

variable "ECS_instance_type" {
  default = "t2.micro"
}

variable "ecs_instance_keyname" {
  default = "nexant-tf"
}
