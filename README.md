# 🛠️ End-to-End Full-Stack App Deployment on AWS

This project demonstrates DevOps best practices by building, containerizing, testing, deploying, and monitoring a full-stack web application (FastAPI backend + Next.js frontend) on AWS using GitHub Actions, Docker, Terraform, and other DevOps tools.

---

## 📦 Tech Stack

* **Backend**: Python (FastAPI)
* **Frontend**: Next.js (React)
* **CI/CD**: GitHub Actions
* **Containers**: Docker
* **Infrastructure as Code**: Terraform (EC2 + Docker Compose)
* **Monitoring**: AWS CloudWatch (Future Improvement)
* **Secrets & Security**: SSH Key Pair, IAM
* **Load Balancing**: NA (Handled by EC2 instance directly)

---

## 🗂️ Repository Structure

```
/backend/       # Python FastAPI REST API
/frontend/      # Next.js web frontend
/.github/       # GitHub Actions workflows
/terraform/     # IaC configs for EC2, VPC, SG, IAM, etc.
/assets/        # Architecture diagrams, CloudWatch screenshots, etc.
README.md
```

---

## 🚀 Architecture Overview

* Frontend & backend containerized using Docker
* GitHub repo contains Dockerfiles and docker-compose for orchestration
* Terraform provisions an EC2 instance and auto-installs Docker, Compose, and Git
* EC2 instance clones the GitHub repo and runs `docker-compose up`
* Supports GitOps-style self-hosted deployment model
![Architecture Diagram](./assets/image.png)
---

## 📖 Setup Instructions

### 🔧 Prerequisites

* AWS Account (Free Tier or higher)
* GitHub repository
* Docker & Docker Compose (for local test)
* Terraform v1.4+
* AWS CLI (configured with access keys)

---

### 1️⃣ Clone the Repo

```bash
git clone https://github.com/vijaypvk/devops-assignment-aws-ecs.git
cd devops-assignment-aws-ecs
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

### 5️⃣ EC2 Deployment via Terraform

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

Provisions:

* EC2 instance (Ubuntu 22.04)
* Installs Docker, Compose, Git
* Clones the GitHub repo
* Runs `docker-compose up -d`

> ✅ Frontend available at `http://<public-ip>:3000`
> ✅ Backend available at `http://<public-ip>:8000`

---

## ⚙️ CI/CD Workflow (GitHub Actions)

> *Suggested future enhancement:*

* On push to `main` or `develop`, SSH into EC2
* Run `git pull && docker-compose down && docker-compose up -d`
* Securely use EC2 IP and SSH key from GitHub Secrets

---

## 📊 Monitoring & Alerts (Planned)

* Add **CloudWatch Agent** on EC2 to monitor:

  * CPU/Memory
  * Disk usage
* Configure alarms to trigger via SNS
* View logs in `/var/lib/docker/containers/...` or bind to host

---

## 🔐 Security

* SSH access restricted via **Key Pair**
* **Security Groups** allow only necessary ports: 22, 3000, 8000
* Use **.env or AWS SSM** for managing secrets (recommended)

---

## 📸 Evidence (Manual Validation)

* ✅ Terraform apply logs
* ✅ EC2 instance public IP
* ✅ Live frontend/backend accessibility
* ✅ GitHub repo auto-cloned
* ✅ Docker containers up on `ps`

---

## ✅ Submission Checklist

* [x] Dockerized backend and frontend
* [x] GitHub-hosted codebase with Docker Compose
* [x] Terraform provisions EC2 infra
* [x] Containers auto-started from Git clone
* [x] Security groups and SSH access configured
* [x] Readme includes complete steps

---

## 🙌 Author

**Vijay Krishnaa P**
📘 B.Tech CSE | Cloud | DevOps | AI Enthusiast
🔗 [LinkedIn](https://www.linkedin.com/in/vijaykrishnaa) • [GitHub](https://github.com/vijaypvk)

---

> *"Build once. Deploy anywhere. Automate everything."*
