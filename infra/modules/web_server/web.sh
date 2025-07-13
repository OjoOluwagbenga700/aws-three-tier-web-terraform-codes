#!/bin/bash
set -e

REGION="us-east-1"
APP_DIR="/home/ec2-user/web"
WEB_DIR="/home/ec2-user/web-tier"

# Update and install prerequisites
dnf update -y
dnf install -y git awscli nginx

# Install Node.js 16 from NodeSource
curl -fsSL https://rpm.nodesource.com/setup_16.x | bash -
dnf install -y nodejs

# Enable and start nginx
systemctl enable nginx
systemctl restart nginx || systemctl start nginx

# Clone repo and build React app
sudo -u ec2-user bash -c "
  git clone https://github.com/OjoOluwagbenga700/aws-three-tier-web-source-code.git $APP_DIR || true
  cp -r $APP_DIR/application-code/web-tier $WEB_DIR
  cd $WEB_DIR
  npm install && npm run build
"

# Deploy to nginx
rm -rf /usr/share/nginx/html/*
cp -r $WEB_DIR/build/* /usr/share/nginx/html/

# Fetch ALB DNS from SSM
ALB_DNS=$(aws ssm get-parameter --name "/app/internal_alb_dns" --region $REGION --query "Parameter.Value" --output text 2>/dev/null)
ALB_DNS=${ALB_DNS:-internal-alb-placeholder}

# Replace placeholder in nginx.conf and apply
sed -i "s|\[REPLACE-WITH-INTERNAL-LB-DNS\]|$ALB_DNS|g" $APP_DIR/application-code/nginx.conf
cp $APP_DIR/application-code/nginx.conf /etc/nginx/nginx.conf

# Start nginx
systemctl restart nginx
