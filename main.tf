provider "aws" {
 region = "us-east-2"
}


# resource "aws_instance" "example" {
#  ami = "ami-0b4624933067d393a"
#  instance_type = "t2.micro"
# }


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "owner-id"
    values = ["137112412989"]  # Amazon's owner ID for Amazon Linux
  }
}

# Use the dynamically found AMI in your EC2 instance
resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  tags = {
    Name = "terraform-example"
  }
}
