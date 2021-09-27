
# Add AWS provider

provider "aws" {
  region = "us-west-1"
}


# create an S3 bucket to store the state file in

terraform {
  backend "s3" {
    bucket = "nexanttfstate"
    key    = "nexant/test-tf-ECS/state/terraform.tfstate"
    region = "us-west-1"
  }
}

module "test-tf-ecs" {
  source = "./modules/ecscluster"

  ecs_cluster_target_capacity = "100"
  ecs_instance_ami            = ""
  ecs_instance_type           = ""
  ecs_instance_keyname        = ""
  ecs_instance_spot_bid_price = ""
  ecs_management_cidrs        = []




}
