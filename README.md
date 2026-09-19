# 🛒 EasyShop — DevSecOps & GitOps on AWS EKS

<p align="center">

<img src="https://img.shields.io/badge/AWS-EKS-orange?style=for-the-badge&logo=amazon-aws" />
<img src="https://img.shields.io/badge/Terraform-IaC-7B42BC?style=for-the-badge&logo=terraform" />
<img src="https://img.shields.io/badge/Jenkins-CI%2FCD-D24939?style=for-the-badge&logo=jenkins" />
<img src="https://img.shields.io/badge/Docker-Containerization-2496ED?style=for-the-badge&logo=docker" />
<img src="https://img.shields.io/badge/Kubernetes-Orchestration-326CE5?style=for-the-badge&logo=kubernetes" />
<img src="https://img.shields.io/badge/ArgoCD-GitOps-EF7B4D?style=for-the-badge&logo=argo" />
<img src="https://img.shields.io/badge/Trivy-Security-1904DA?style=for-the-badge" />
<img src="https://img.shields.io/badge/Prometheus-Monitoring-E6522C?style=for-the-badge&logo=prometheus" />
<img src="https://img.shields.io/badge/Grafana-Observability-F46800?style=for-the-badge&logo=grafana" />

</p>

<p align="center">
  <b>End-to-End DevSecOps • CI/CD • GitOps • AWS EKS • Kubernetes • Monitoring</b>
</p>

---

## 📌 Overview

**EasyShop** is a containerized e-commerce application deployed on **Amazon EKS** with an end-to-end DevSecOps and GitOps workflow.

The project combines:

- ☁️ AWS infrastructure provisioning with Terraform
- 🐳 Docker containerization
- 🔄 Jenkins CI pipeline
- 🔐 Trivy container security scanning
- 📦 Docker Hub image publishing
- ☸️ Kubernetes deployment on Amazon EKS
- 🔄 Argo CD GitOps deployment
- 🌐 NGINX Ingress
- 🔒 HTTPS using Let's Encrypt
- 📊 Prometheus & Grafana monitoring
- ⚡ Kubernetes Horizontal Pod Autoscaling
- 🗄️ MongoDB with persistent storage

---

## 🏗️ Architecture

```mermaid
flowchart TB

    DEV[Developer]
    GIT[GitHub]
    JENKINS[Jenkins CI]
    TRIVY[Trivy Security Scan]
    DOCKER[Docker Hub]
    ARGO[Argo CD]
    EKS[AWS EKS]
    K8S[Kubernetes Application]
    MONGO[MongoDB StatefulSet + PVC]
    NGINX[NGINX Ingress]
    CERT[cert-manager + Let's Encrypt]
    HPA[Horizontal Pod Autoscaler]
    PROM[Prometheus]
    GRAF[Grafana]
    DOMAIN[HTTPS Domain]

    DEV --> GIT
    GIT --> JENKINS
    JENKINS --> TRIVY
    JENKINS --> DOCKER
    JENKINS --> GIT

    GIT --> ARGO
    ARGO --> EKS

    EKS --> K8S
    EKS --> MONGO

    K8S --> NGINX
    NGINX --> DOMAIN
    CERT --> NGINX

    K8S --> HPA

    EKS --> PROM
    PROM --> GRAF
````

---

## 🔄 DevSecOps Workflow

### CI Pipeline

```text
Developer
    ↓
GitHub
    ↓
Jenkins
    ↓
Clone Repository
    ↓
Build Docker Images
    ↓
Run Tests
    ↓
Trivy Security Scan
    ↓
Push Images to Docker Hub
    ↓
Update Kubernetes Manifests
    ↓
GitHub
```

### GitOps Deployment

```text
GitHub Kubernetes Manifests
            ↓
         Argo CD
            ↓
        AWS EKS
            ↓
       Kubernetes
            ↓
      EasyShop App
```

Argo CD monitors the Kubernetes manifests stored in Git and synchronizes them with the EKS cluster.

---

## 🛠️ Technology Stack

| Category                   | Technologies                 |
| -------------------------- | ---------------------------- |
| ☁️ Cloud                   | AWS                          |
| 🏗️ Infrastructure as Code | Terraform                    |
| 🐳 Containerization        | Docker                       |
| 📦 Container Registry      | Docker Hub                   |
| 🔄 CI/CD                   | Jenkins                      |
| 🔐 Security                | Trivy                        |
| ☸️ Orchestration           | Kubernetes / Amazon EKS      |
| 🔄 GitOps                  | Argo CD                      |
| 🌐 Ingress                 | NGINX Ingress Controller     |
| 🔒 TLS                     | cert-manager + Let's Encrypt |
| 📊 Monitoring              | Prometheus                   |
| 📈 Visualization           | Grafana                      |
| ⚡ Autoscaling              | Kubernetes HPA               |
| 🗄️ Database               | MongoDB                      |
| 💻 Application             | Next.js / TypeScript         |
| 📝 Source Control          | GitHub                       |

---

## ✨ Key Features

### ☁️ Infrastructure

* AWS VPC and EKS infrastructure provisioned using Terraform
* EC2-based bastion/tooling host
* Automated tool installation using EC2 user-data
* AWS CLI, kubectl, Helm, Jenkins, Docker, Trivy and Argo CD CLI

### 🐳 Containerization

* Dockerized EasyShop application
* Docker image publishing to Docker Hub
* Separate migration image

### 🔄 CI/CD

Jenkins automates the CI workflow:

```text
Clone
  ↓
Build
  ↓
Test
  ↓
Security Scan
  ↓
Push Image
  ↓
Update Kubernetes Manifests
```

### 🔐 DevSecOps

Trivy is integrated into the Jenkins workflow to scan container images for vulnerabilities before deployment.

### ☸️ Kubernetes

The application uses Kubernetes resources including:

* Namespace
* Deployment
* Service
* Migration Job
* MongoDB StatefulSet
* PersistentVolume
* PersistentVolumeClaim
* ConfigMap
* Secret
* HorizontalPodAutoscaler
* Ingress
* ClusterIssuer

### 🔄 GitOps

Argo CD continuously monitors Kubernetes manifests stored in Git and synchronizes the desired state with the EKS cluster.

### 🌐 HTTPS

NGINX Ingress provides application routing while cert-manager obtains TLS certificates using Let's Encrypt.

Application domain:

```text
https://snehaldevopsengineer.online
```

### 📊 Monitoring

The cluster is monitored using:

* Prometheus
* Grafana
* Kubernetes Metrics Server

### ⚡ Autoscaling

The application uses Kubernetes HPA.

```text
Minimum Replicas: 2
Maximum Replicas: 5
CPU Target: 70%
```

---

# 🚀 Deployment

## 1. Clone the Repository

```bash
git clone https://github.com/snehalpawar29/EasyShop.git
cd EasyShop
```

---

## 2. Provision Infrastructure

Navigate to the Terraform directory:

```bash
cd terraform
```

Initialize Terraform:

```bash
terraform init
```

Validate:

```bash
terraform validate
```

Create the execution plan:

```bash
terraform plan
```

Apply the infrastructure:

```bash
terraform apply
```

---

## 3. Configure AWS CLI

```bash
aws configure
```

Verify:

```bash
aws --version
```

---

## 4. Configure kubectl for EKS

```bash
aws eks --region ap-south-1 update-kubeconfig --name easyshop-cluster
```

Verify the cluster:

```bash
kubectl get nodes
```

---

## 5. Configure Jenkins

Check Jenkins:

```bash
sudo systemctl status jenkins
```

Initial password:

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Jenkins is configured with the required credentials and shared library for the CI pipeline.

---

## 6. Jenkins Shared Library

The project uses:

```text
https://github.com/snehalpawar29/jenkins-shared-libraries.git
```

Configure the shared library in:

```text
Manage Jenkins
→ System
→ Global Pipeline Libraries
```

Library name:

```text
shared
```

Default version:

```text
main
```

---

## 7. Argo CD

Create the namespace:

```bash
kubectl create namespace argocd
```

Install Argo CD:

```bash
kubectl apply -n argocd \
-f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Verify:

```bash
kubectl get pods -n argocd
```

Argo CD is configured to monitor the Kubernetes manifests in:

```text
kubernetes/
```

---

## 8. NGINX Ingress

Add the Helm repository:

```bash
helm repo add ingress-nginx \
https://kubernetes.github.io/ingress-nginx
```

Update:

```bash
helm repo update
```

Install:

```bash
helm install nginx-ingress \
ingress-nginx/ingress-nginx
```

Verify:

```bash
kubectl get pods
kubectl get svc
```

---

## 9. HTTPS with cert-manager

Add the Jetstack repository:

```bash
helm repo add jetstack \
https://charts.jetstack.io
```

Install cert-manager:

```bash
helm install cert-manager jetstack/cert-manager \
--namespace cert-manager \
--create-namespace \
--set crds.enabled=true
```

Verify:

```bash
kubectl get pods -n cert-manager
kubectl get certificate -n easyshop-ns
kubectl get clusterissuer
```

---

## 10. Prometheus & Grafana

Add the Prometheus repository:

```bash
helm repo add prometheus-community \
https://prometheus-community.github.io/helm-charts
```

Install the monitoring stack:

```bash
helm install prometheus \
prometheus-community/kube-prometheus-stack \
--namespace monitoring \
--create-namespace
```

Verify:

```bash
kubectl get pods -n monitoring
```

---

# 📂 Project Structure

```text
EasyShop/
│
├── terraform/
│   ├── provider.tf
│   ├── vpc.tf
│   ├── eks.tf
│   ├── ec2.tf
│   ├── outputs.tf
│   └── install_tools.sh
│
├── kubernetes/
│   ├── namespace.yml
│   ├── deployment.yml
│   ├── service.yml
│   ├── mongodb-statefulset.yml
│   ├── pvc.yml
│   ├── migration-job.yml
│   ├── configmap.yml
│   ├── secret.yml
│   ├── hpa.yml
│   ├── ingress.yml
│   └── clusterissuer.yml
│
├── docs/
│   └── screenshots/
│
├── Jenkinsfile
├── Dockerfile
└── README.md
```

---

# 📸 Project Screenshots

## ☁️ AWS Infrastructure

### AWS VPC

![AWS VPC](docs/screenshots/aws-vpc.png)

### EKS Cluster

![AWS EKS Cluster](docs/screenshots/aws-eks-cluster.png)

### EKS Nodes

![AWS EKS Nodes](docs/screenshots/aws-eks-nodes.png)

---

## 🐳 Docker

### EasyShop Docker Image

![Docker Hub EasyShop](docs/screenshots/dockerhub-easyshop-image.png)

### Migration Docker Image

![Docker Hub Migration](docs/screenshots/dockerhub-migration-image.png)

---

## 🔧 Jenkins

### Jenkins Dashboard

![Jenkins Dashboard](docs/screenshots/jenkins-dashboard.png)

### Jenkins Pipeline

![Jenkins Pipeline](docs/screenshots/jenkins-pipeline-stages.png)

### Successful Pipeline

![Jenkins Pipeline Success](docs/screenshots/jenkins-pipeline-success.png)

---

## ☸️ Kubernetes

### Kubernetes Nodes

![Kubernetes Nodes](docs/screenshots/kubernetes-nodes.png)

### EasyShop Pods

![EasyShop Pods](docs/screenshots/kubernetes-easyshop-pods.png)

### Kubernetes Services

![Kubernetes Services](docs/screenshots/kubernetes-easyshop-services.png)

### Kubernetes Resources

![Kubernetes Resources](docs/screenshots/kubernetes-all-resources.png)

---

## 🔄 Argo CD

### Argo CD Application

![Argo CD Application](docs/screenshots/argocd-app.png)

### Argo CD Resource Tree

![Argo CD Resource Tree](docs/screenshots/argocd-resource-tree.png)

---

## 🌐 Ingress & HTTPS

### NGINX Ingress

![NGINX Ingress](docs/screenshots/ingress-nginx.png)

### HTTPS Domain

![HTTPS Domain](docs/screenshots/https-domain.png)

### Let's Encrypt Certificate

![Let's Encrypt Certificate](docs/screenshots/lets-encrypt-certificate.png)

---

## 📊 Monitoring

### Prometheus

![Prometheus Overview](docs/screenshots/prometheus-overview.png)

### Grafana

![Grafana Kubernetes Nodes](docs/screenshots/grafana-kubernetes-nodes.png)

![Grafana Kubernetes Pods](docs/screenshots/grafana-kubernetes-pods.png)

![Grafana Kubernetes Workloads](docs/screenshots/grafana-kubernetes-workloads.png)

---

## ⚡ HPA

![HPA Status](docs/screenshots/hpa-status.png)

---

# 🔍 Kubernetes Verification

```bash
kubectl get nodes
```

```bash
kubectl get pods -n easyshop-ns
```

```bash
kubectl get svc -n easyshop-ns
```

```bash
kubectl get ingress -n easyshop-ns
```

```bash
kubectl get certificate -n easyshop-ns
```

```bash
kubectl get hpa -n easyshop-ns
```

```bash
kubectl top nodes
```

```bash
kubectl get applications -n argocd
```

---

# 🔐 Security

Security-related components used in the project include:

* 🔎 Trivy container image scanning
* 🔐 Kubernetes Secrets
* 🔒 HTTPS with Let's Encrypt
* 👤 AWS IAM
* 🛡️ AWS Security Groups
* ☸️ Private Kubernetes workloads
* 🔄 GitOps-based deployment

> ⚠️ Never commit real passwords, API keys, JWT secrets or other credentials to GitHub. Use environment variables, Kubernetes Secrets or an appropriate external secrets-management solution.

---

# 🧹 Cleanup

Infrastructure provisioned through Terraform can be removed using:

```bash
terraform destroy
```

Review the resources before confirming destruction.

> Persistent MongoDB data and externally created Helm-managed resources may require separate cleanup.

---

# ⚠️ Production Considerations

This project is **production-oriented / production-style for learning and portfolio purposes**.

Before using the architecture for a real production environment, additional hardening should be applied to:

* Kubernetes and application secrets
* EKS API endpoint access
* Public NodePort exposure
* EC2 security-group rules
* MongoDB production architecture
* Worker-node capacity strategy
* IAM permissions
* Network security and access controls

---

# 🎯 DevOps Skills Demonstrated

```text
AWS Cloud
    ↓
Terraform / IaC
    ↓
Docker
    ↓
Jenkins CI
    ↓
Trivy Security Scanning
    ↓
Docker Hub
    ↓
Kubernetes / EKS
    ↓
Argo CD GitOps
    ↓
NGINX Ingress
    ↓
HTTPS
    ↓
Prometheus + Grafana
    ↓
Kubernetes HPA
```

---

## 👩‍💻 Author

### Snehal Pawar

**Aspiring DevOps Engineer | AWS | Kubernetes | Docker | Terraform | Jenkins**

🔗 GitHub:
[https://github.com/snehalpawar29](https://github.com/snehalpawar29)

🔗 LinkedIn:
[https://linkedin.com/in/snehalpawar29](https://linkedin.com/in/snehalpawar29)

🌐 Portfolio:
[https://snehalpawar29.github.io/Snehal-Pawar-Devops-Portfolio/](https://snehalpawar29.github.io/Snehal-Pawar-Devops-Portfolio/)

---

<p align="center">

### ☁️ BUILD • AUTOMATE • SECURE • DEPLOY • MONITOR

**AWS | Terraform | Docker | Kubernetes | Jenkins | Argo CD | DevSecOps**

</p>
```
