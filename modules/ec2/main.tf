##    Create EC2

resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id = var.private_app_subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  iam_instance_profile = var.instance_profile_name

  associate_public_ip_address = false




  ##    Scripting code to Check the web page by adding example file index.html and installing nginx

  user_data = <<-EOF
    #!/bin/bash
    set -eux

    apt-get update
    apt-get install -y nginx

    cat > /var/www/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html>
      <head>
        <title>AWS 3-Tier Infrastructure</title>
      </head>
      <body>
        <h1>Deployment Successful!</h1>
        <p>Served by a private EC2 instance.</p>
        <p>Infrastructure provisioned using Terraform.</p>
      </body>
    </html>
    HTML

    systemctl enable nginx
    systemctl start nginx
  EOF




  tags = {
    Name        = "three-tier-${var.environment}-app"
    Tier        = "Private-App"
    Environment = var.environment
  }
}


