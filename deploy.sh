#!/bin/bash

# Exit on error
set -e

# Variables
DOCKER_USERNAME=""
IMAGE_NAME="todo-app"
IMAGE_TAG="latest"

# Function to get Docker username
get_docker_username() {
    if [ -z "$DOCKER_USERNAME" ]; then
        read -p "Enter your Docker Hub username: " DOCKER_USERNAME
    fi
}

# Function to build and push Docker image
build_push_image() {
    echo "Building Docker image..."
    docker build -t $DOCKER_USERNAME/$IMAGE_NAME:$IMAGE_TAG .
    
    echo "Pushing Docker image to Docker Hub..."
    docker push $DOCKER_USERNAME/$IMAGE_NAME:$IMAGE_TAG
}

# Function to update Kubernetes manifests
update_manifests() {
    echo "Updating Kubernetes manifests..."
    sed -i "s|\${YOUR_DOCKER_USERNAME}|$DOCKER_USERNAME|g" deployment.yaml
}

# Function to deploy to Kubernetes
deploy_to_kubernetes() {
    echo "Deploying to Kubernetes..."
    
    # Check if minikube is running
    if command -v minikube &> /dev/null; then
        minikube_status=$(minikube status -f '{{.Host}}' 2>/dev/null || echo "Stopped")
        if [ "$minikube_status" != "Running" ]; then
            echo "Starting Minikube..."
            minikube start
        fi
    fi
    
    # Apply Kubernetes manifests
    kubectl apply -f deployment.yaml
    kubectl apply -f service.yaml
    kubectl apply -f hpa.yaml
    
    # Wait for deployment to be ready
    echo "Waiting for deployment to be ready..."
    kubectl rollout status deployment/todo-app
    
    # Get service URL
    if command -v minikube &> /dev/null; then
        echo "Service URL: $(minikube service todo-service --url)"
    else
        echo "Service deployed. Check the LoadBalancer endpoint:"
        kubectl get svc todo-service
    fi
}

# Main execution
echo "=== Todo App Deployment ==="
echo "This script will build, push, and deploy the Todo API to Kubernetes."

# Get Docker username
get_docker_username

# Ask for confirmation
read -p "Build and push Docker image? (y/n): " build_push
if [ "$build_push" = "y" ]; then
    build_push_image
fi

# Update and deploy
read -p "Deploy to Kubernetes? (y/n): " deploy
if [ "$deploy" = "y" ]; then
    update_manifests
    deploy_to_kubernetes
fi

echo "Deployment process completed!"