# Flask Notes App

## Overview

Flask Notes App: End-to-End Deployment on AWS EKS with Automated CI/CD

![Architecture Diagram](../Pictures/Screenshots/Screenshot%20from%202025-03-08%2001-03-55.png)

## Prerequisites

- AWS Account with IAM configured
- AWS CLI installed and configured
- kubectl installed
- eksctl installed
- Docker installed
- GitHub repository for CI/CD integration

## Deployment Steps

### 1. Clone the Repository
```sh
git clone https://github.com/dilliramshah4/flask-k8s-deploy
cd flask-k8s-deploy
```

### 2. Set Up AWS CLI & EKS

Configure AWS CLI:
```sh
aws configure
```

Create an EKS Cluster:
```sh
eksctl create cluster --name flask-cluster --region us-east-1
```

### 3. Build & Push Docker Image
```sh
docker build -t <your-dockerhub-username>/flask-notes-app .
docker push <your-dockerhub-username>/flask-notes-app
```

### 4. Deploy to Kubernetes

Apply Kubernetes manifests:
```sh
kubectl apply -f deployment.yml
kubectl apply -f service.yml
```

Check if pods are running:
```sh
kubectl get pods
```

Get the LoadBalancer URL:
```sh
kubectl get svc flask-service
```

### 5. Set Up CI/CD Pipeline

Use GitHub Actions or Jenkins for automation.

Configure `.github/workflows/deploy.yml` for GitHub Actions.

### 6. Automate Deployment

Push code to GitHub:
```sh
git add .
git commit -m "Deploy Flask Notes App"
git push origin main
```

CI/CD pipeline will automatically:
- Build Docker image
- Push to Docker Hub
- Deploy to Kubernetes

### 7. Verify Deployment
```sh
kubectl get pods
kubectl get svc
```

Access the app via the LoadBalancer URL.

## Conclusion

This setup ensures a smooth and automated deployment of the Flask Notes App using AWS EKS and CI/CD best practices. 🚀
