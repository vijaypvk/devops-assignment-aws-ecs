# 🛠️ DevOps Assignment – End-to-End AWS Deployment

This project demonstrates DevOps best practices by building, containerizing, testing, deploying, and monitoring a full-stack web application (Python backend + Next.js frontend) on AWS using GitHub Actions, Docker, Terraform, and other DevOps tools.

---

## 📦 Tech Stack

- **Backend**: Python (FastAPI)
- **Frontend**: Next.js (React)
- **CI/CD**: GitHub Actions
- **Containers**: Docker
- **Infrastructure as Code**: Terraform (AWS ECS + Fargate, ALB)
- **Monitoring**: AWS CloudWatch
- **Secrets & Security**: AWS Secrets Manager, IAM
- **Load Balancing**: AWS Application Load Balancer

---

## 🗂️ Repository Structure

```
/backend/       # Python FastAPI REST API
/frontend/      # Next.js web frontend
/.github/       # GitHub Actions workflows
/terraform/     # IaC configs for ECS, VPC, ALB, IAM, etc.
README.md
```

---

## 🚀 Architecture Overview

- Frontend & backend containerized using Docker
- CI/CD pipeline tests and pushes images to AWS ECR
- Terraform provisions ECS Fargate services behind an ALB
- CloudWatch handles monitoring with alarms & dashboards
- IAM policies enforce least privilege
- Secrets injected at runtime using Secrets Manager

![Architecture Diagram](./assets/architecture.png)

---

## 📖 Setup Instructions

### 🔧 Prerequisites

- AWS Account (Free Tier or higher)
- GitHub repository
- Docker & Docker Compose
- Terraform v1.4+
- AWS CLI (configured with access keys)

---

### 1️⃣ Clone the Repo

```bash
git clone https://github.com/your-username/devops-assignment.git
cd devops-assignment
```

---

### 2️⃣ Local Development

#### Backend

```bash
cd backend
python -m venv venv
source venv/bin/activate  # or venv\Scripts\activate on Windows
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000
```

#### Frontend

```bash
cd frontend
npm install
npm run dev
```

---

### 3️⃣ Running Tests

#### Backend Unit Tests

```bash
cd backend
pytest
```

#### Frontend E2E Tests

```bash
cd frontend
npm run test:e2e
```

---

### 4️⃣ Docker Build & Run

```bash
# Backend
docker build -t backend-service ./backend
docker run -p 8000:8000 backend-service

# Frontend
docker build -t frontend-app ./frontend
docker run -p 3000:3000 frontend-app
```

---

### 5️⃣ AWS ECR Push (Manually or via CI/CD)

```bash
aws ecr get-login-password --region YOUR_REGION | docker login --username AWS --password-stdin YOUR_ECR_URL
docker tag backend-service:latest YOUR_ECR_URL/backend:latest
docker push YOUR_ECR_URL/backend:latest
```

---

## ⚙️ CI/CD Workflow (GitHub Actions)

- On **push to `develop`**:
  - Lint & test backend and frontend
  - Build Docker images & push to ECR
- On **merge to `main`**:
  - Trigger Terraform deployment to AWS

Check the `.github/workflows/` folder for YAML files.

---

## 🌍 Terraform Deployment

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

Creates:
- VPC, subnets, ALB, ECS cluster
- ECS services (Fargate) for backend & frontend
- Secrets in AWS Secrets Manager
- IAM roles with least-privilege

---

## 📊 Monitoring & Alerts

- **CloudWatch Dashboard** includes:
  - CPU/Memory usage
  - Request count
- **Alarm**: Email alert if CPU > 70% for 5 mins
- Dashboard screenshots in `assets/cloudwatch/`

---

## 🔐 Security

- Secrets are stored in **AWS Secrets Manager**
- ECS services fetch secrets securely at runtime
- IAM roles are tightly scoped to required actions only
- Security Groups restrict inbound access (only via ALB)

---

## 🌐 Load Balancing Test

- ALB routes traffic to 2+ ECS tasks
- Verified zero-downtime by stopping one container — traffic continues to flow

---

## 🎬 Demo Video

[![Watch the Demo](https://img.youtube.com/vi/VIDEO_ID/0.jpg)](https://www.youtube.com/watch?v=VIDEO_ID)

> Covers: Architecture, Git workflow, Dockerization, CI/CD, Terraform, Monitoring, Security, and Load Balancer failover.

---

## 📸 Hands-On Evidence

- ✅ Terraform apply logs
- ✅ GitHub Actions deployment logs
- ✅ CloudWatch dashboard screenshots
- ✅ Secrets Manager integration demo
- ✅ Load balancer failover validation

All in the `evidence/` folder.

---

## ✅ Submission Checklist

- [x] Monorepo with `/backend` and `/frontend`
- [x] Clear README with setup & architecture
- [x] Tests run locally and in CI
- [x] Docker images pushed to ECR with Git SHA tags
- [x] Terraform provisions all infra correctly
- [x] CI/CD deploys on `main` merge
- [x] CloudWatch dashboards + alerts configured
- [x] IAM follows least privilege
- [x] Demo video link included

---

## 🙌 Author

**Vijay Krishnaa P**  
Cloud | DevOps | AI Enthusiast  
[LinkedIn](https://www.linkedin.com/in/your-profile) | [GitHub](https://github.com/your-username)