# MERN Stack Deployment using Terraform and Ansible for Travel Memory

## Project Overview

This project demonstrates a secure and automated deployment of a MERN (MongoDB, Express, React, Node.js) application on AWS using:

- **Terraform** – Infrastructure as Code (IaC)
- **Ansible** – Configuration Management & Deployment
- **PM2** – Process Management
- **Nginx** – Frontend Hosting
- **Ansible Vault** – Secret Management

The setup follows production-level best practices, including a private database subnet, authentication, least-privilege access, and encrypted secrets.

---

##  AWS Infrastructure (Provisioned via Terraform)

### Components Created

-VPC

---

- Public Subnet

---

- Private Subnet

---

- Internet Gateway

---

- NAT Gateway

---

- Route Tables

---

- Security Groups

---

- 2 EC2 Instances:
  - Web Server (Public)
  - Database Server (Private)

---  

- SSH Key Pair

---

### Terraform Commands

```bash
terraform init
terraform plan
terraform apply
```

Outputs:

- Public IP of Web Server

- Private IP of Database Server

---

⚙ Configuration Management (Ansible)
Web Server Automation

---

Install Node.js

---

Install PM2


---

Clone the MERN repository

---

Install backend dependencies


---

Generate .env dynamically using a template


---

Restart backend with updated environment variables

Database Server Automation

Install MongoDB

Configure the MongoDB service

---

Enable authentication

---

Create:

Admin user

---

Application user (least privilege)

🔐 Security Implementation
Database Security

MongoDB is deployed in a private subnet

No public IP for DB server

MongoDB Authentication Enabled

Role-based access:

admin → root access (admin DB only)

traveluser → readWrite access (application DB only)

Secret Management

Sensitive credentials stored using Ansible Vault

No passwords committed to Git

.env and Terraform state files excluded via .gitignore

Network Security

SSH access restricted

MongoDB is not publicly accessible

Security Groups configured for minimal exposure

- Deployment Workflow
- Provision Infrastructure
```
cd terraform
terraform init
terraform apply
```
cd ansible

ansible-playbook -i inventory.ini db.yml --ask-vault-pass

ansible-playbook -i inventory.ini web.yml --ask-vault-pass

🌐 Application Access

Frontend: (http://3.8.6.116/addexperience)

---

Backend API: (http://3.8.6.116:5000/hello)

---

Terraform Destroy

EC2 delete

VPC delete

NAT delete

Public IP delete

MongoDB data delete

```
MERN-DevOps-Assignment/
│
├── terraform/
│   ├── vpc.tf
│   ├── ec2.tf
│   ├── subnet.tf
│   ├── route.tf
│   ├── outputs.tf
│   └── ...
│
├── ansible/
│   ├── inventory.ini
│   ├── web.yml
│   ├── db.yml
│   ├── templates/
│   └── vault.yml (encrypted, not committed)
│
├── backend/
├── frontend/
└── README.md
```

## Key DevOps Concepts Demonstrated

Infrastructure as Code (Terraform)

Configuration as Code (Ansible)

Idempotent Playbooks

Secret Encryption (Ansible Vault)

Private Networking Architecture

Bastion-based SSH Access

Production-level MongoDB Security

Process Management using PM2

## Notes

Vault password is not committed for security reasons.

MongoDB is deployed in a private subnet and cannot be accessed publicly.

Secrets are encrypted with AES-256 using Ansible Vault.

Deployment is fully automated and reproducible.

Project Status

1 Infrastructure Provisioned

2 Web Server Configured

3 MongoDB Secured

4 Secrets Encrypted

5 Application Successfully Deployed

