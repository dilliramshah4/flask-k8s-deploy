# flask-k8s-deploy
This repository contains a Flask application deployed on Kubernetes using Docker, GitHub Actions (CI/CD), and Kubernetes (EKS)

## Development Setup

### Prerequisites
- Python 3.8+
- Docker
- Kubernetes CLI (kubectl)
- AWS CLI (for EKS)
- Git

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/flask-k8s-deploy.git
    cd flask-k8s-deploy
    ```

2. Create a virtual environment and activate it:
    ```sh
    python3 -m venv venv
    source venv/bin/activate
    ```

3. Install the dependencies:
    ```sh
    pip install -r requirements.txt
    ```

### Running the Application

1. Run the Flask application locally:
    ```sh
    flask run
    ```

2. Build and run the Docker container:
    ```sh
    docker build -t flask-app .
    docker run -p 5000:5000 flask-app
    ```

3. Deploy to Kubernetes:
    ```sh
    kubectl apply -f k8s-deployment.yaml
    kubectl apply -f k8s-service.yaml
    ```

### Running Tests

1. Run the tests using pytest:
    ```sh
    pytest
    ```

## AWS EKS Setup and Deployment

### Step 1: Login to AWS
```sh
aws configure
```
Enter your AWS credentials when prompted.

### Step 2: Create an EKS Cluster
```sh
eksctl create cluster --name flask-cluster --region us-east-1 --nodegroup-name flask-nodes --node-type t2.micro --nodes 2
```
Wait for the cluster to be created.

### Step 3: Configure kubectl
```sh
aws eks update-kubeconfig --name flask-cluster --region us-east-1
```
Verify the cluster connection:
```sh
kubectl get nodes
```

### Step 4: Clone the Flask App Repository
```sh
git clone https://github.com/your-repo/flask-app.git
cd flask-app
```

### Step 5: Build and Push Docker Image
```sh
docker build -t flask-app .
docker tag flask-app:latest <your-dockerhub-username>/flask-app:latest
docker push <your-dockerhub-username>/flask-app:latest
```

### Step 6: Deploy the Flask App to Kubernetes

Create Deployment:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: flask-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: flask-app
  template:
    metadata:
      labels:
        app: flask-app
    spec:
      containers:
        - name: flask-app
          image: <your-dockerhub-username>/flask-app:latest
          ports:
            - containerPort: 5000
```
Apply the deployment:
```sh
kubectl apply -f deployment.yml
```

Create Service:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: flask-service
spec:
  selector:
    app: flask-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 5000
  type: LoadBalancer
```
Apply the service:
```sh
kubectl apply -f service.yaml
```

### Step 7: Verify Deployment
```sh
kubectl get pods
kubectl get services
```
Get the external IP of the service:
```sh
kubectl get svc flask-service
```
Visit the external IP in your browser to access the Flask app.

### Step 8: Monitor Logs
```sh
kubectl logs -l app=flask-app
```

### Step 9: Clean Up Resources
To delete the cluster and free up resources:
```sh
eksctl delete cluster --name flask-cluster --region us-east-1
```


