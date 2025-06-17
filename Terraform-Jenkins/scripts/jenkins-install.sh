#!/bin/bash

# Exit on error and print commands as they are executed
set -ex

# Update system
echo "🚀 Updating system packages..."
sudo apt update -y
sudo apt upgrade -y

# Install Java 17
echo "☕ Installing Java 17..."
sudo apt install -y openjdk-17-jdk
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Install Jenkins
echo "🔧 Installing Jenkins..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Install Git
echo "📦 Installing Git..."
sudo apt install -y git

# Install Terraform
echo "🏗️  Installing Terraform..."
sudo apt update && sudo apt install -y gnupg software-properties-common
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install -y terraform

# Install kubectl
echo "☸️  Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Install Docker
echo "🐳 Installing Docker..."
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
sudo usermod -aG docker jenkins
sudo systemctl restart docker

# Install Maven
echo "📦 Installing Maven..."
sudo apt install -y maven

# Install AWS CLI v2
echo "☁️  Installing AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
sudo ./aws/install --update
rm -rf aws awscliv2.zip

# Configure environment
echo "⚙️  Configuring environment..."
echo 'export PATH=$PATH:$HOME/bin:/usr/local/bin' >> ~/.bashrc
source ~/.bashrc

# Get Jenkins initial admin password
JENKINS_PASSWORD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword 2>/dev/null || echo "Jenkins initial password not available yet")

# Print completion message
echo -e "\n\n✅ Installation completed!"
echo "===================================================="
echo "Jenkins URL: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):8080"
echo "Initial Jenkins admin password: $JENKINS_PASSWORD"
echo "===================================================="
echo "Next steps:"
echo "1. Access Jenkins and complete the setup wizard"
echo "2. Install suggested plugins"
echo "3. Create admin user"
echo "4. Install Jenkins plugins: pipeline, docker-workflow, kubernetes, git, maven-plugin"
echo "5. Configure Docker Hub credentials in Jenkins"
echo "6. Configure AWS credentials in Jenkins"
echo "===================================================="