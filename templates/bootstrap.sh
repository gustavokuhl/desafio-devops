#! /bin/bash
# This script is used to bootstrap the build process.

# Update the submodules
echo "Updating submodules..." >> /home/bootstrap.log
apt update -y
apt install -y apt-transport-https ca-certificates curl software-properties-common

# Install Docker
echo "Installing Docker..." >> /home/bootstrap.log
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
apt update -y
apt-get install -y docker-ce

# Enable Docker start on boot
echo "Enabling Docker start on boot..." >> /home/bootstrap.log
systemctl start docker
systemctl enable docker

# Add the current user to the docker group
echo "Adding current user to the docker group..." >> /home/bootstrap.log
groupadd docker
usermod -aG docker ubuntu

# Pull and start the Docker container
echo "Pulling and starting the Docker container..." >> /home/bootstrap.log
docker pull nginx:latest
docker run --name mynginx1 -p 80:80 -d nginx