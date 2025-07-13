#!/bin/bash
set -e

REGION="us-east-1"
APP_DIR="/home/ec2-user/app"
APP_PATH="$APP_DIR/application-code/app-tier"

echo "=== Updating system and installing packages ==="
dnf update -y
dnf install -y git awscli jq mysql curl

echo "=== Installing Node.js 16 ==="
curl -fsSL https://rpm.nodesource.com/setup_16.x | bash -
dnf install -y nodejs

echo "=== Cloning app repo ==="
sudo -u ec2-user git clone https://github.com/aws-samples/aws-three-tier-web-architecture-workshop.git $APP_DIR || true

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

echo "=== Creating database and table ==="
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PWD" <<SQL
CREATE DATABASE IF NOT EXISTS webappdb;
USE webappdb;
CREATE TABLE IF NOT EXISTS transactions(
    id INT NOT NULL AUTO_INCREMENT,
    amount DECIMAL(10,2),
    description VARCHAR(100),
    PRIMARY KEY(id)
);
INSERT IGNORE INTO transactions (amount, description) VALUES ('400', 'groceries');
SQL

echo "=== Starting Node.js app with PM2 ==="
cd $APP_PATH
sudo -u ec2-user pm2 start index.js
sudo -u ec2-user pm2 startup systemd -u ec2-user --hp /home/ec2-user
sudo -u ec2-user pm2 save

