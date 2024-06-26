output "instances_public_ip" {
  value = aws_instance.instance.*.public_ip
}

output "instances_private_ip" {
  value = aws_instance.instance.*.private_ip
}

output "instance_ips" {
  value = [
    for i in aws_instance.instance[*] :
    {
      public_ip   = i.public_ip
      private_ip  = i.private_ip
      private_dns = i.private_dns
    }
  ]
}

output "vpc" {
  value = aws_vpc.vpc
}

output "subnet" {
  value = aws_subnet.subnet
}

output "security_group" {
  value = aws_security_group.sg_allowall
}
