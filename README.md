# 🏗️ AWS Multi-Tier Web Application — Terraform Project

A fully automated, production-ready multi-tier web application deployed on AWS using Terraform modules.

---

## 🏛️ Architecture Overview

```
Internet
    ↓
Application Load Balancer (Public Subnets)
    ↓
Web/App EC2 Instances (Private Subnets)
    ↓
RDS MySQL Database (Private Subnets, Multi-AZ)
```

---

## ✅ What's Deployed

| Resource | Details |
|----------|---------|
| **VPC** | CIDR `10.0.0.0/16` |
| **Public Subnets** | `10.0.10.0/24` (us-east-1a), `10.0.20.0/24` (us-east-1b) |
| **Private Subnets** | `10.0.100.0/24` (us-east-1a), `10.0.200.0/24` (us-east-1b) |
| **NAT Gateways** | 2x (one per AZ) |
| **EC2 Instances** | 2x Ubuntu, encrypted EBS, Apache web server |
| **Load Balancer** | Application LB, internet-facing, HTTP:80 |
| **Auto Scaling Group** | Target tracking, min=2, max=4 |
| **RDS** | MySQL, Multi-AZ, encrypted, Secrets Manager |
| **Security** | Least-privilege security groups, no hardcoded credentials |

---

## 📁 Project Structure

```
terraform-project/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── modules/
    ├── vpc/
    ├── subnets/
    ├── nat/
    ├── security/
    ├── ec2/
    ├── alb/
    ├── asg/
    └── rds/
```

---

## 🔐 Security Highlights

- RDS credentials generated via `random_password` and stored in **AWS Secrets Manager**
- EBS volumes **encrypted at rest**
- EC2 instances in **private subnets** — no direct internet exposure
- Security groups follow **least-privilege**: ALB → Web → RDS only
- SSM Session Manager used for instance access — **no SSH keys or bastion host**

---

## 🚀 How to Deploy

```bash
# 1. Initialize
terraform init

# 2. Preview changes
terraform plan

# 3. Deploy
terraform apply -auto-approve
```

After deploy, the ALB DNS will be shown in the outputs:
```
alb_dns = "tf-lb-xxxx.us-east-1.elb.amazonaws.com"
```

---

## 🧹 How to Destroy

```bash
terraform destroy -auto-approve
```

> ⚠️ Always destroy resources after testing to avoid unexpected AWS charges.

---

## 🛠️ Tech Stack

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=flat&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=flat&logo=amazon-aws&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)
