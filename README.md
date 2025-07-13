# AWS Three Tier Web Architecture Workshop

# 🛠️ 3-Tier AWS Architecture with Terraform

This project demonstrates how to provision a complete **3-Tier Architecture** on AWS using **Terraform**. With a single `terraform apply --auto-approve`, the entire infrastructure is deployed like magic — securely and efficiently.

![Architecture Diagram](https://i.imgur.com/KXlJ8uI.png)

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


## ⚙️ How to Use

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/aws-three-tier-web-terraform-codes.git
cd aws-three-tier-web-terraform-codes
```

### 2. Initialize Terraform
```hcl
terraform init
```

### 3. Review the Plan
```hcl
terraform plan
```

### 4. Apply the Infrastructure
```hcl
terraform apply --auto-approve
```
### 5. Destroy (When Done)
```hcl
terraform destroy --auto-approve
```

## 🔐 Security Highlights
- Public access is restricted to the Web Tier only.
- The App Tier and DB Tier reside in private subnets.
- IAM roles used for EC2 instance permissions (e.g., SSM access).
- DB credentials stored securely via environment variables or AWS Secrets Manager (optional enhancement).
