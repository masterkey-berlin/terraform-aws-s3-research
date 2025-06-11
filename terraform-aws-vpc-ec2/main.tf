# 1. Virtual Private Cloud (VPC)
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16" // Privater IP-Bereich für das VPC

  tags = {
    Name = "my-terraform-vpc"
  }
}

# 2. Subnetz innerhalb des VPC
resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id // Implizite Abhängigkeit zum VPC
  cidr_block = "10.0.1.0/24"     // IP-Bereich für das Subnetz, muss Teil des VPC CIDR sein
  # availability_zone = "${data.aws_region.current.name}a" // Optional: spezifische AZ, für einfaches Setup oft nicht nötig

  tags = {
    Name = "my-terraform-subnet"
  }
}

# 3. Sicherheitsgruppe (Security Group)
resource "aws_security_group" "my_sg" {
  name        = "my-terraform-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id // Implizite Abhängigkeit zum VPC

  ingress {
    description      = "SSH from anywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] // Erlaubt SSH von jeder IP (für Übungszwecke!)
    ipv6_cidr_blocks = ["::/0"]      // Optional: Erlaubt SSH auch von jeder IPv6
  }

  egress { // Erlaube allen ausgehenden Traffic (Standard, aber gut es explizit zu sehen)
    from_port        = 0
    to_port          = 0
    protocol         = "-1" // "-1" bedeutet alle Protokolle
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "my-terraform-sg"
  }
}

# 4. EC2 Instanz
resource "aws_instance" "my_ec2" {
  ami                    = "ami-014dd8ec7f09293e6"       // ERSETZEN! Finde ein aktuelles Ubuntu oder Amazon Linux 2 AMI ID für deine Region
  instance_type          = "t2.micro"                    // Kleiner, kostengünstiger Typ (ggf. t3.micro, wenn t2 nicht mehr Free Tier ist)
  subnet_id              = aws_subnet.my_subnet.id       // Implizite Abhängigkeit zum Subnetz
  vpc_security_group_ids = [aws_security_group.my_sg.id] // Implizite Abhängigkeit zur SG

  # Wichtig für den Zugriff, wenn du dich später per SSH verbinden möchtest:
  # key_name = "terraform-projeck.pem" // ERSETZEN durch den Namen eines existierenden EC2 Key Pairs in deiner Region

  # Um eine öffentliche IP zu bekommen (im Default VPC Subnetz oft automatisch, hier explizit für ein custom Subnetz)
  # associate_public_ip_address = true // Ist oft Default, wenn das Subnetz es erlaubt

  tags = {
    Name = "my-terraform-ec2-instance"
  }
}

# Optional: Datenquelle, um das aktuellste AMI dynamisch zu finden (fortgeschrittener)
# data "aws_ami" "latest_amazon_linux" {
#   most_recent = true
#   owners      = ["amazon"] # oder spezifische Account-ID für andere AMIs
#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"] # Beispiel-Filter für Amazon Linux 2
#   }
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }
# Dann in aws_instance: ami = data.aws_ami.latest_amazon_linux.id

# Outputs (optional für diese Aufgabe, aber gute Praxis)
output "ec2_instance_public_ip" {
  description = "Public IP address of the EC2 instance."
  value       = aws_instance.my_ec2.public_ip
}

output "ec2_instance_id" {
  description = "ID of the EC2 instance."
  value       = aws_instance.my_ec2.id
}

output "vpc_id" {
  description = "ID of the created VPC."
  value       = aws_vpc.my_vpc.id
}