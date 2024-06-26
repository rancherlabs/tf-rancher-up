data "aws_availability_zones" "available" {}

# TODO: Make the Ubuntu OS version configurable
# TODO: Add support for ARM architecture
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Save the private SSH key in the Terraform data source for later use
data "local_file" "ssh-private-key" {
  depends_on = [local_file.private_key_pem]
  filename   = local.private_ssh_key_path
}
