# AWS Three Tier Web Architecture Workshop

# 🛠️ 3-Tier AWS Architecture with Terraform

This project demonstrates how to provision a complete **3-Tier Architecture** on AWS using **Terraform**. With a single `terraform apply --auto-approve`, the entire infrastructure is deployed like magic — securely and efficiently.

![Architecture Diagram](./A_diagram_illustrates_a_3-tier_architecture_deploy.png)

## 📚 Architecture Overview

- **Web Tier**
  - Public-facing EC2 instances in public subnets
  - Managed by an **Auto Scaling Group**
  - Fronted by an **Internet-facing Application Load Balancer**

- **App Tier**
  - EC2 instances in private subnets
  - Managed by an **Auto Scaling Group**
  - Fronted by an **Internal Application Load Balancer**
  - Connects securely to the DB tier

- **Database Tier**
  - **Amazon Aurora MySQL** deployed in **Multi-AZ**
  - Located in private subnets for maximum security

## 🚀 Features

- Infrastructure as Code (IaC) with **Terraform**
- Highly available and fault-tolerant setup
- Secure VPC design (public/private subnets)
- Load balancing and auto scaling for both Web and App tiers
- DB secrets stored in AWS Systems Manager Parameter Store
- IAM roles and Security Groups for least-privilege access
- Parameterized and modular design

## 🧰 Tech Stack

- **Terraform**
- **AWS VPC, EC2, ALB, ASG, Aurora**
- **Amazon Linux 2023**
- **CloudWatch** (for logging and monitoring)

## 📂 Project Structure

# aws-three-tier-web-terraform-codes
