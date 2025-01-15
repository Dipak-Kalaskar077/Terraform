resource "aws_instance" "iron_man" {
  ami                    = var.ami_id
  key_name               = var.key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.firewall.id]
  subnet_id              = var.subnet_id
  user_data              = <<-EOF
                          #!/bin/bash
                          sudo yum update -y
                          sudo yum install -y java-1.8.0-openjdk
                          sudo yum install -y wget
                          wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.41/bin/apache-tomcat-9.0.41.tar.gz
                          tar -xzf apache-tomcat-9.0.41.tar.gz
                          sudo mv apache-tomcat-9.0.41 /usr/local/tomcat9
                          sudo chmod +x /usr/local/tomcat9/bin/*.sh
                          sudo /usr/local/tomcat9/bin/startup.sh
                          EOF
  tags = {
    Name = var.project
    Env  = var.env
  }
}

output "instance_id" {
  value = aws_instance.iron_man.id
}

output "public_ip" {
  value = aws_instance.iron_man.public_ip
}