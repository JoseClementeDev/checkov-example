# Ejemplo de Terraform con vulnerabilidades de seguridad

# EC2 Instance sin grupo de seguridad
resource "aws_instance" "vulnerable_ec2" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = "my-key-pair"

  # Sin grupo de seguridad
  # Sin IAM Role
  # Sin tags

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
}

# S3 Bucket público
resource "aws_s3_bucket" "public_bucket" {
  bucket = "my-public-bucket-123"

  # Sin encriptación
  # Sin versionamiento
  # Sin bloqueo de acceso público
}

resource "aws_s3_bucket_public_access_block" "public_bucket_access" {
  bucket = aws_s3_bucket.public_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# IAM User con permisos excesivos
resource "aws_iam_user" "admin_user" {
  name = "admin-user"
  # Sin política de contraseña
  # Sin MFA
  # Con acceso completo a la consola
}

resource "aws_iam_user_policy" "admin_policy" {
  name = "admin-access"
  user = aws_iam_user.admin_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "*"
        Resource = "*"
      }
    ]
  })
}