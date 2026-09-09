#!/bin/bash

touch /var/log/install-tools.log

echo "===== Starting tool installation =====" >> /var/log/install-tools.log
sudo apt-get update -y
sudo apt-get install -y \
  fontconfig \
  openjdk-21-jre \
  wget \
  gnupg \
  ca-certificates \
  docker.io

echo "===== Java installed =====" >>/var/log/install-tools.log
java -version >>/var/log/install-tools.log 



sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y jenkins

sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "===== Jenkins installed =====" >>/var/log/install-tools.log
jenkins --version >>/var/log/install-tools.log


sudo systemctl enable docker
sudo systemctl start docker

sudo usermod -aG docker ubuntu
sudo usermod -aG docker jenkins
sudo systemctl restart docker

echo "===== Docker installed =====" >>/var/log/install-tools.log
docker --version >>/var/log/install-tools.log 


apt-get install wget gnupg
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update -y
sudo apt-get install -y trivy

echo "===== Trivy installed =====" >>/var/log/install-tools.log
trivy --version >>/var/log/install-tools.log


sudo snap install aws-cli --classic
echo "===== AWS CLI installed =====" >>/var/log/install-tools.log
aws --version >>/var/log/install-tools.log

sudo snap install helm --classic
echo "===== Helm installed =====" >>/var/log/install-tools.log
helm version >>/var/log/install-tools.log

sudo snap install kubectl --classic
echo "===== kubectl installed =====" >>/var/log/install-tools.log
kubectl version --client >>/var/log/install-tools.log

sudo systemctl restart jenkins

curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64
argocd version --client >> /var/log/install-tools.log

echo "===== ALL TOOLS INSTALLED SUCCESSFULLY =====" >>/var/log/install-tools.log

