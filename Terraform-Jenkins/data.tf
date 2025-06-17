data "aws_ami" "ubuntu" {
  owners = ["self", "amazon", "aws-marketplace", "099720109477"]  # Include common owners

  filter {
    name   = "image-id"
    values = ["ami-05f991c49d264708f"]  # AMI ID goes here
  }


  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_availability_zones" "azs" {}