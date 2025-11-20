# 🚀 Uber Clone AWS Infrastructure (Terraform Project)

This project automates the deployment of a **Highly Available, Secure, and Scalable AWS Infrastructure** for an Uber-like application using **Terraform**.  

It includes:

- VPC with public + private subnets across 2 AZs  
- Internet Gateway & NAT Gateways  
- Application Load Balancer (ALB)  
- Auto Scaling Group (ASG)  
- Launch Template with Nginx user_data  
- RDS MySQL (Primary + Read Replica)  
- Security Groups  
- Outputs for ALB DNS, RDS endpoints, VPC ID  

---

# 📌 **Project Objectives**
- Fully automated IaC deployment using Terraform  
- Production-grade AWS networking (VPC, subnets, NAT, routing)  
- High availability using ASG and Load Balancer  
- Private RDS with Read Replica  
- No manual provisioning  
- Zero downtime instance replacement  
- Perfect for resume & DevOps interviews  

---
                ┌──────────────────────────┐
                │        Route 53           │
                └─────────────┬────────────┘
                              │
                  ┌───────────▼───────────┐
                  │   Application ALB      │
                  └───────┬───────────────┘
                          │
              ┌───────────▼───────────┐
              │ Auto Scaling Group     │
              │  (Amazon Linux + Nginx)│
              └───────────┬───────────┘
                          │
    ┌─────────────────────▼──────────────────────┐
    │                Private Subnets              │
    │    ┌────────────────────────────────────┐   │
    │    │  RDS MySQL (Primary + Replica)     │   │
    │    └────────────────────────────────────┘   │
    └─────────────────────┬──────────────────────┘
                          │
               ┌──────────▼──────────┐
               │   NAT Gateways       │
               └──────────┬──────────┘
                          │
                ┌─────────▼────────┐
                │ Internet Gateway │
                └──────────────────┘


---

# 📁 **Terraform Project Structure**

├── main.tf

├── variables.tf

├── outputs.tf

├── terraform.tfvars

├── user_data.tftpl

└── modules/

├── vpc/

├── compute/

├── alb/

├── rds/

└── security/

# 🏗 **Architecture Diagram**

---

# 📸 **Screenshots (Table Format)**

Below are the screenshots showing successful deployment.

---

## 🟦 **AWS Resources Overview (Screenshots)**

| Component | Screenshot |
|----------|------------|
| **VPC with Subnets & Routing** | <img width="1919" height="828" alt="Screenshot 2025-11-20 235913" src="https://github.com/user-attachments/assets/8451bb8a-f436-4217-9992-e453fef6a24c" /> |
| **NAT Gateway** | <img width="1919" height="617" alt="Screenshot 2025-11-21 013130" src="https://github.com/user-attachments/assets/82765923-501e-49d0-b947-29f05e502027" />
| **Target Group (Healthy Instances)** | <img width="1919" height="830" alt="Screenshot 2025-11-20 235610" src="https://github.com/user-attachments/assets/95684795-92f8-4b56-b811-3ac8e939c612" />
| **Application Load Balancer** | <img width="1918" height="598" alt="Screenshot 2025-11-21 011006" src="https://github.com/user-attachments/assets/a1bda4da-7b5b-4777-9449-7f8b671a6317" />
| **Load Balancer → Browser Output** | [App Output]<img width="1309" height="482" alt="Screenshot 2025-11-20 235458" src="https://github.com/user-attachments/assets/2839dd03-be09-40dd-bc17-038485dabdad" />
| **EC2 Auto Scaling Group Instances** | <img width="1918" height="458" alt="Screenshot 2025-11-20 234057" src="https://github.com/user-attachments/assets/95e48755-a61c-4c3a-8e2a-e0d42ee1e94a" />
| **Auto Scaling Group** | <img width="1919" height="827" alt="Screenshot 2025-11-21 011242" src="https://github.com/user-attachments/assets/23bc51ad-cc4b-4595-a339-992d925b60a7" />
| **Terraform Apply Output** | <img width="1278" height="249" alt="Screenshot 2025-11-21 002756" src="https://github.com/user-attachments/assets/1ebf550b-b733-4ca9-a808-8a479cd6f8ae" />
| **RDS with replica** |  <img width="1919" height="512" alt="Screenshot 2025-11-21 010650" src="https://github.com/user-attachments/assets/03dabc77-f280-4d04-8f98-60cef3c9bc64" />

---

# 🧩 **Key AWS Services Used**

### 🌐 **VPC**
- CIDR: 10.0.0.0/16  
- 4 subnets (2 public + 2 private)  
- Internet Gateway  
- NAT Gateways (1 per AZ)

### ⚖️ **Application Load Balancer**
- Listens on port 80  
- Routes traffic to ASG

### 🖥 **Auto Scaling Group**
- Launch Template using Amazon Linux 2  
- Nginx installed using `user_data`  
- Multi-AZ deployment  
- Instance Refresh used for rolling replacements  

### 🗄 **RDS MySQL**
- Primary DB Instance  
- Read Replica  
- Private subnet only  
- Secured using SG rules  

---

# 🔧 **How to Deploy Locally**

### 1️⃣ Initialize Terraform  
terraform init

### 2️⃣ Validate  
terraform validate

### 3️⃣ Create a plan  
terraform plan -out=tfplan

### 4️⃣ Apply  
terraform apply "tfplan"

---

# 🌍 **Outputs Produced**

Example outputs from Terraform:

| Output | Description |
|--------|-------------|
| `alb_dns` | URL to access the application |
| `asg_name` | Auto Scaling Group name |
| `rds_primary_endpoint` | Primary DB URL |
| `rds_read_replica_endpoint` | Read replica DB URL |
| `vpc_id` | VPC ID |

---

# 🎯 **Final ALB URL**

Click to test:

👉 **http://my-uber-clone-infra-alb-553445953.ap-south-1.elb.amazonaws.com**

---

# 👤 Author

**Om Divekar**

- 🔗 GitHub: [omdivekar14](https://github.com/omdivekar14)
- 🔗 LinkedIn: [Om Divekar](https://www.linkedin.com/in/om-divekar/)

---




