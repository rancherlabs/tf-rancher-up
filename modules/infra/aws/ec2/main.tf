locals {
  new_key_pair_path    = var.ssh_private_key_path != null ? var.ssh_private_key_path : "${path.cwd}/${var.prefix}-ssh_private_key.pem"
  private_ssh_key_path = fileexists("${path.cwd}/${var.prefix}-ssh_private_key.pem") ? "${path.cwd}/${var.prefix}-ssh_private_key.pem" : var.ssh_private_key_path
  public_ssh_key_path  = fileexists("${path.cwd}/${var.prefix}-ssh_public_key.pem") ? "${path.cwd}/${var.prefix}-ssh_public_key.pem" : var.ssh_public_key_path
}

resource "tls_private_key" "ssh_private_key" {
  count     = var.create_ssh_key_pair ? 1 : 0
  algorithm = "ED25519"
}

resource "local_file" "private_key_pem" {
  count           = var.create_ssh_key_pair ? 1 : 0
  filename        = local.new_key_pair_path
  content         = tls_private_key.ssh_private_key[0].private_key_openssh
  file_permission = "0600"
}

resource "local_file" "public_key_pem" {
  count           = var.create_ssh_key_pair ? 1 : 0
  filename        = var.ssh_public_key_path != null ? var.ssh_public_key_path : "${path.cwd}/${var.prefix}-ssh_public_key.pem"
  content         = tls_private_key.ssh_private_key[0].public_key_openssh
  file_permission = "0600"
}

resource "aws_key_pair" "key_pair" {
  count      = var.create_ssh_key_pair ? 1 : 0
  key_name   = "tf-rancher-up-${var.prefix}"
  public_key = tls_private_key.ssh_private_key[0].public_key_openssh
}

resource "aws_vpc" "vpc" {
  count      = var.vpc_id == null ? 1 : 0
  cidr_block = var.vpc_ip_cidr_range

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

resource "aws_subnet" "subnet" {
  count             = var.subnet_id == null ? 1 : 0
  availability_zone = data.aws_availability_zones.available.names[count.index]
  # cidr_block = var.subnet_ip_cidr_range[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = var.vpc_id == null ? aws_vpc.vpc[0].id : var.vpc_id

  tags = {
    Name = "${var.prefix}-subnet"
  }
}

resource "aws_internet_gateway" "internet-gateway" {
  count  = var.vpc_id == null ? 1 : 0
  vpc_id = aws_vpc.vpc[0].id

  tags = {
    Name = "${var.prefix}-ig"
  }
}

resource "aws_route_table" "route-table" {
  count  = var.vpc_id == null ? 1 : 0
  vpc_id = aws_vpc.vpc[0].id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway[0].id
  }
}

resource "aws_route_table_association" "rt-association" {
  count = var.subnet_id == null ? 1 : 0

  subnet_id      = var.subnet_id == null ? "${aws_subnet.subnet.*.id[0]}" : var.subnet_id
  route_table_id = aws_route_table.route-table[0].id
}

resource "aws_security_group" "sg_allowall" {
  count  = var.create_security_group == true ? 1 : 0
  vpc_id = aws_vpc.vpc[0].id

  name        = "${var.prefix}-allow-nodes"
  description = "Allow traffic for nodes in the cluster"

  ingress {
    description = "Allow all inbound from nodes in the cluster"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }

  ingress {
    description = "Allow all inbound SSH to nodes"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow all inbound kube-apiserver to nodes"
    from_port   = "6443"
    to_port     = "6443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow all inbound HTTPS to nodes"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Creator = var.prefix
  }
}

resource "aws_instance" "instance" {
  count         = var.instance_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id == null ? "${aws_subnet.subnet.*.id[0]}" : var.subnet_id

  key_name               = var.create_ssh_key_pair ? aws_key_pair.key_pair[0].key_name : var.ssh_key_pair_name
  vpc_security_group_ids = [var.create_security_group == true ? aws_security_group.sg_allowall[0].id : var.instance_security_group_id]
  user_data              = var.user_data

  root_block_device {
    volume_size = var.instance_disk_size
  }

  instance_market_options {
    market_type = var.spot_instances ? "spot" : null
  }

  provisioner "remote-exec" {
    inline = flatten([
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'"
    ])

    connection {
      type        = "ssh"
      host        = var.bastion_host == null ? self.public_ip : self.private_ip
      user        = var.ssh_username
      private_key = data.local_file.ssh-private-key.content

      bastion_host        = var.bastion_host != null ? var.bastion_host.address : null
      bastion_user        = var.bastion_host != null ? var.bastion_host.user : null
      bastion_private_key = var.bastion_host != null ? (var.bastion_host.ssh_key_path != null ? file(pathexpand(var.bastion_host.ssh_key_path)) : var.bastion_host.ssh_key) : null
    }
  }

  tags = merge(
    {
      Name    = "${var.prefix}-${count.index + var.tag_begin}"
      Creator = var.prefix
    },
    var.tags
  )

  iam_instance_profile = var.iam_instance_profile

  lifecycle {
    ignore_changes = [ami, instance_market_options, user_data, tags]
  }
}
