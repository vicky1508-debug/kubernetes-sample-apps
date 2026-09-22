#!/bin/bash

echo "Starting AWS DevOps toolchain installation..."

# 1. Update system and install base dependencies
sudo dnf update -y
sudo dnf groupinstall -y "Development Tools"
sudo dnf install -y python3 python3-pip wget curl git

# 2. Install Java 17 (Required for Jenkins)
sudo dnf install -y java-17-amazon-corretto-devel

# 3. Install and configure Docker
echo "Installing Docker..."
sudo dnf install -y docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user

# 4. Install and configure Jenkins
echo "Installing Jenkins..."
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo dnf install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

# 5. Install Kubernetes (kubectl)
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

echo "All DevOps modules installed successfully!"

