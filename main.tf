resource "aws_instance" "ansible_master"  {

  instance_type           = "t3.micro"
  vpc_security_group_ids  = [var.allow_everything] #replace your SG
  ami                     = data.aws_ami.ami_info.id
  subnet_id              = "subnet-0ea9a2005fdcc6695" 
  user_data               = file("${path.module}/install_ansible.sh")

  # Define the root volume size and type
  root_block_device  {
    encrypted             = false
    volume_type           = "gp3"
    volume_size           = 60
    iops                  = 3000
    throughput            = 125
    delete_on_termination = true
  }
  
    tags = {
    Name   = "Ansible-Master"
  }
}
resource "aws_instance" "ansible_agent" {

  instance_type           = "t3.micro"
  vpc_security_group_ids  = [var.allow_everything] #replace your SG
  ami                     = data.aws_ami.ami_info.id
  subnet_id              = "subnet-0ea9a2005fdcc6695" 
  #user_data               = file("${path.module}/install_jenkins_agent.sh")

  # Define the root volume size and type
  root_block_device  {
    encrypted             = false
    volume_type           = "gp3"
    volume_size           = 80
    iops                  = 3000
    throughput            = 125
    delete_on_termination = true
  }

  tags = {
    Name   = "Ansible-Agent"
  }
}

resource "aws_route53_record" "ansible_master_r53" {
    zone_id = var.zone_id
    name    = "ansible_master.${var.domain_name}"
    type    =  "A"
    ttl     = 1
    records = [aws_instance.ansible_master.public_ip]
    allow_overwrite = true
}
resource "aws_route53_record" "jenkins_agent_r53" {
    zone_id = var.zone_id
    name    = "ansible_agent.${var.domain_name}"
    type    = "A"
    ttl     = 1
    records = [aws_instance.ansible_agent.public_ip]
    allow_overwrite = true
}


# module "ansible_master" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   name = "ansible-master"
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [var.allow_everything] #replace your SG
#   ami                    = data.aws_ami.ami_info.id
#   user_data              = file("${path.module}/ansible.sh")
#   tags = {
#     Name   = "Ansible-Master"
#   }
#   # Define the root volume size and type
#   root_block_device = [{
#     encrypted             = false
#     volume_type           = "gp3"
#     volume_size           = 30
#     iops                  = 3000
#     throughput            = 125
#     delete_on_termination = true
#   }]

# }
# module "ansible_agent" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   name = "tf-ansible-agent"
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [var.allow_everything] #replace your SG
#   ami                    = data.aws_ami.ami_info.id
 
#   tags = {
#     Name   = "Ansible-Agent"
#   }
#   # Define the root volume size and type
#   root_block_device = [{
#     encrypted             = false
#     volume_type           = "gp3"
#     volume_size           = 50
#     iops                  = 3000
#     throughput            = 125
#     delete_on_termination = true
#   }]
# }
# module "records" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "~> 2.0"
#   zone_name = var.zone_name

# records = [
#       {
#         name = "ansible_master"
#         type = "A"
#         ttl  = 1
#         records = [
#           module.ansible_master.public_ip
#         ]
#          allow_overwrite = true
#       },
#       {
#         name = "ansible_agent"
#         type = "A"
#         ttl  = 1
#         records = [
#           module.ansible_agent.public_ip
#         ]
#          allow_overwrite = true
#        }
#    ]
# }