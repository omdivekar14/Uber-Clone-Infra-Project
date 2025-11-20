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
| **VPC with Subnets & Routing** | ![VPC](images/vpc.png) |
| **Target Group (Healthy Instances)** | ![Target Group](images/target-group.png) |
| **Load Balancer → Browser Output** | ![App Output](images/app.png) |
| **EC2 Auto Scaling Group Instances** | ![EC2 Instances](images/ec2.png) |
| **Terraform Apply Output** | ![Terraform Output](images/terraform-output.png) |

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




