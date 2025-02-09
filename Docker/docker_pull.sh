#!/bin/bash

# Define the AWS region, repository name, image name, and tag
AWS_REGION="us-east-1" 
REPOSITORY_NAME="flask-app-repo" 
IMAGE_NAME="flask-app"  
IMAGE_TAG="latest"

# Get the full ECR repository URL
ECR_REPO_URL="${1234567}.dkr.ecr.${eu-east-1}.amazonaws.com/${REPOSITORY_NAME}"

# Authenticate Docker to the AWS ECR
echo "Authenticating Docker to AWS ECR..."
aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REPO_URL}

# Check if the login was successful
if [ $? -ne 0 ]; then
  echo "Error: Docker login to AWS ECR failed."
  exit 1
fi

# Pull the Docker image from AWS ECR
IMAGE="${ECR_REPO_URL}:${IMAGE_TAG}"

echo "Pulling Docker image ${IMAGE} from AWS ECR..."

docker pull ${IMAGE}

# Check if the pull was successful
if [ $? -eq 0 ]; then
    echo "Docker image ${IMAGE} pulled successfully from AWS ECR."
else
    echo "Error: Docker image pull from AWS ECR failed."
    exit 1
fi
