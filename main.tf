provider "aws" {
  region = "us-east-2"
}

resource "aws_security_group" "launch_wizard_1" {
  name        = "launch-wizard-1"
  description = "Security group for EC2 instance"
  vpc_id      = "vpc-0c2f3f11a7726e225"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "launch-wizard-1"
  }
}

resource "aws_iam_role" "cloudwatch_agent_role" {
  name = "cloudwatch_agent_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "cloudwatch_agent_policy" {
  name = "cloudwatch_agent_policy"
  role = aws_iam_role.cloudwatch_agent_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:PutMetricData",
          "ec2:DescribeTags",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "cloudwatch_agent_profile" {
  name = "cloudwatch_agent_profile"
  role = aws_iam_role.cloudwatch_agent_role.name
}

resource "aws_instance" "example1" {
  ami           = "ami-0d0f28110d16ee7d6"
  instance_type = "t2.micro"
  key_name      = "minha_chave_aws2"

  vpc_security_group_ids = [aws_security_group.launch_wizard_1.id]

  associate_public_ip_address = true

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
  }

  private_dns_name_options {
    hostname_type                    = "ip-name"
    enable_resource_name_dns_a_record = true
    enable_resource_name_dns_aaaa_record = false
  }

  iam_instance_profile = aws_iam_instance_profile.cloudwatch_agent_profile.name

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              sudo curl -L "https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              sudo chmod +x /usr/local/bin/docker-compose
              sudo yum install -y git
              git clone https://github.com/Lucas-Sana/meu-projeto-node.git /app
              cd /app
              echo "DB_HOST=${aws_db_instance.example.endpoint}" > .env
              echo "DB_USER=admin" >> .env
              echo "DB_PASSWORD=senha_segura" >> .env
              echo "DB_NAME=meu_banco_de_dados" >> .env
              echo "DB_PORT=3306" >> .env
              docker-compose up --build -d
              EOF

  tags = {
    Name = "example-instance-1"
  }
}

resource "aws_instance" "example2" {
  ami           = "ami-0d0f28110d16ee7d6"
  instance_type = "t2.micro"
  key_name      = "minha_chave_aws2"

  vpc_security_group_ids = [aws_security_group.launch_wizard_1.id]

  associate_public_ip_address = true

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
  }

  private_dns_name_options {
    hostname_type                    = "ip-name"
    enable_resource_name_dns_a_record = true
    enable_resource_name_dns_aaaa_record = false
  }

  iam_instance_profile = aws_iam_instance_profile.cloudwatch_agent_profile.name

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              sudo curl -L "https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              sudo chmod +x /usr/local/bin/docker-compose
              sudo yum install -y git
              git clone https://github.com/Lucas-Sana/meu-projeto-node.git /app
              cd /app
              echo "DB_HOST=${aws_db_instance.example.endpoint}" > .env
              echo "DB_USER=admin" >> .env
              echo "DB_PASSWORD=senha_segura" >> .env
              echo "DB_NAME=meu_banco_de_dados" >> .env
              echo "DB_PORT=3306" >> .env
              docker-compose up --build -d
              EOF

  tags = {
    Name = "example-instance-2"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "meu-bucket-s3-unico-123456"
}

resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.example.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.example.arn,
          "${aws_s3_bucket.example.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Security group for RDS"
  vpc_id      = "vpc-0c2f3f11a7726e225"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.launch_wizard_1.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-security-group"
  }
}

resource "aws_db_instance" "example" {
  identifier           = "meu-banco-de-dados"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  username             = "admin"
  password             = "senha_segura"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Security group for ALB"
  vpc_id      = "vpc-0c2f3f11a7726e225"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-security-group"
  }
}

resource "aws_lb" "example" {
  name               = "example-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = ["subnet-0230d768af7d5e205", "subnet-0ca32d85abcd57920", "subnet-0ded2ea57a5a7c79e"]

  enable_deletion_protection = false

  tags = {
    Name = "example-lb"
  }
}

resource "aws_lb_target_group" "example" {
  name     = "example-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0c2f3f11a7726e225"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
  }
}

resource "aws_lb_target_group_attachment" "example1" {
  target_group_arn = aws_lb_target_group.example.arn
  target_id        = aws_instance.example1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "example2" {
  target_group_arn = aws_lb_target_group.example.arn
  target_id        = aws_instance.example2.id
  port             = 80
}

resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}

output "public_ip_instance1" {
  value = aws_instance.example1.public_ip
}

output "public_ip_instance2" {
  value = aws_instance.example2.public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.example.bucket
}

output "rds_endpoint" {
  value = aws_db_instance.example.endpoint
}

output "alb_dns_name" {
  value = aws_lb.example.dns_name
}