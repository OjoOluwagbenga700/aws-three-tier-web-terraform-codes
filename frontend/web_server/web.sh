#!/bin/bash
set -euxo pipefail

# Variables
REPO_URL="https://github.com/OjoOluwagbenga700/aws-three-tier-web-source-code.git"
FRONTEND_DIR="/home/ec2-user/aws-three-tier-web-source-code/application-code/web-tier"
NGINX_CONF="/home/ec2-user/aws-three-tier-web-source-code/application-code/nginx.conf"

# Update system packages and install prerequisites
sudo dnf update -y
sudo dnf install -y https://s3.amazonaws.com/amazon-ssm-us-east-1/latest/linux_amd64/amazon-ssm-agent.rpm git awscli nginx

sudo systemctl enable --now amazon-ssm-agent
sudo systemctl enable --now nginx

# Install Node.js 16
curl -fsSL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo dnf install -y nodejs

# Clone, build and copy frontend files as ec2-user
if [ ! -d "$FRONTEND_DIR" ]; then
  sudo -u ec2-user git clone "$REPO_URL" /home/ec2-user/aws-three-tier-web-source-code
fi

sudo -u ec2-user bash -c "
  cd $FRONTEND_DIR
  npm install && npm run build
"

# Pull ALB DNS from Parameter Store
ALB_DNS=$(aws ssm get-parameter --name "/app/internal_alb_dns" --with-decryption --query "Parameter.Value" --output text)

# Update nginx.conf with the ALB DNS
sudo sed -i "s/\[REPLACE-WITH-INTERNAL-LB-DNS\]/$ALB_DNS/g" "$NGINX_CONF"

# Copy updated NGINX config and restart nginx
sudo cp -v "$NGINX_CONF" /etc/nginx/nginx.conf
sudo systemctl restart nginx

# Set correct permissions for nginx to access the copied files
sudo chmod -R 755 /home/ec2-user

sudo systemctl enable nginx