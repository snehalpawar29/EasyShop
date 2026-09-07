#!/bin/bash

set -euxo pipefail

exec > >(tee /var/log/install-tools.log | logger -t install-tools -s 2>/dev/console) 2>&1

echo "===== Starting tool installation ====="

# Update packages
sudo apt-get update -y

# Basic packages + Java
sudo apt-get install -y \
  fontconfig \
  openjdk-21-jre \
  wget \
  gnupg \
  ca-certificates \
  docker.io

echo "===== Java installed ====="
java -version

# =========================================================
# Jenkins
# =========================================================

mkdir -p /etc/apt/keyrings

wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  > /etc/apt/sources.list.d/jenkins.list

sudo apt-get update -y

sudo apt-get install -y jenkins

sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "===== Jenkins installed ====="

# =========================================================
# Docker
# =========================================================

sudo systemctl enable docker
sudo systemctl start docker

sudo usermod -aG docker ubuntu
sudo usermod -aG docker jenkins

sudo systemctl restart docker

echo "===== Docker installed ====="

# =========================================================
# Trivy
# =========================================================

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key \
  | gpg --dearmor \
  > /usr/share/keyrings/trivy.gpg

echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" \
  > /etc/apt/sources.list.d/trivy.list

sudo apt-get update -y

sudo apt-get install -y trivy

echo "===== Trivy installed ====="

# =========================================================
# AWS CLI
# =========================================================

sudo apt-get install -y awscli

echo "===== AWS CLI installed ====="

# =========================================================
# Helm
# =========================================================

sudo snap install helm --classic

echo "===== Helm installed ====="

# =========================================================
# kubectl
# =========================================================

sudo snap install kubectl --classic

echo "===== kubectl installed ====="

# Restart Jenkins after Docker installation
sudo systemctl restart jenkins

echo "===== ALL TOOLS INSTALLED SUCCESSFULLY ====="