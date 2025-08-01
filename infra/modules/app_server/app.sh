#!/bin/bash
set -e

REGION="us-east-1"
APP_DIR="/home/ec2-user/app"
APP_PATH="$APP_DIR/application-code/app-tier"

echo "=== Updating system and installing packages ==="
sudo dnf update -y
sudo dnf install -y https://s3.amazonaws.com/amazon-ssm-us-east-1/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent

sudo dnf install -y git 
sudo dnf install -y mariadb105
sudo dnf install -y awscli

echo "=== Installing Node.js 16 ==="
curl -fsSL https://rpm.nodesource.com/setup_16.x | bash -
sudo dnf install -y nodejs

echo "=== Cloning app repo ==="
sudo -u ec2-user git clone https://github.com/OjoOluwagbenga700/aws-three-tier-web-source-code.git $APP_DIR || true

echo "=== Installing Node.js dependencies ==="
cd $APP_PATH
sudo -u ec2-user npm install
sudo npm install -g pm2

echo "=== Fetching DB credentials from SSM ==="
DB_USER=$(aws ssm get-parameter --name "/app/db_username" --with-decryption --region $REGION --query "Parameter.Value" --output text)
DB_PWD=$(aws ssm get-parameter --name "/app/db_password" --with-decryption --region $REGION --query "Parameter.Value" --output text)
DB_HOST=$(aws ssm get-parameter --name "/app/db_host" --region $REGION --query "Parameter.Value" --output text)
DB_DATABASE=$(aws ssm get-parameter --name "/app/db_database" --region $REGION --query "Parameter.Value" --output text)

echo "=== Creating DbConfig.js ==="
cat > "$APP_PATH/DbConfig.js" <<EOL
module.exports = Object.freeze({
    DB_HOST : "$DB_HOST",
    DB_USER : "$DB_USER",
    DB_PWD : "$DB_PWD",
    DB_DATABASE : "$DB_DATABASE"
});
EOL


echo "=== Starting Node.js app with PM2 ==="
cd $APP_PATH
sudo -u ec2-user pm2 start index.js
sudo -u ec2-user pm2 startup systemd -u ec2-user --hp /home/ec2-user
sudo -u ec2-user pm2 save