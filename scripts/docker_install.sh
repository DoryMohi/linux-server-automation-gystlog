#!/bin/bash

# Update package list
sudo apt update

# Install Docker
sudo apt install -y docker.io

# Enable Docker to start automatically
sudo systemctl enable docker

# Start Docker service
sudo systemctl start docker

# Verify installation
docker --version

# Check service status
sudo systemctl status docker
