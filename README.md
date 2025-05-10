# To-Do List API Microservice

A scalable To-Do List API microservice built with Django REST Framework and deployed on Kubernetes.

## Project Overview

This project implements a simple To-Do List API with the following features:

- REST API endpoints for CRUD operations on tasks
- Containerization with Docker
- Deployment on Kubernetes with scalability features
- Health checks and monitoring
- CI/CD pipeline with GitHub Actions

## API Endpoints

- `GET /tasks/` - List all tasks
- `POST /tasks/` - Create a new task
- `GET /tasks/{id}/` - Get a task by ID
- `PUT /tasks/{id}/` - Update a task
- `DELETE /tasks/{id}/` - Delete a task
- `GET /health/` - Health check endpoint

## Local Development Setup

### Prerequisites

- Python 3.9+
- Docker
- Kubernetes (Minikube or Kind for local development)
- kubectl

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/eeAlirezaye/todo-app.git
   cd todo-app
   ```

2. Create a virtual environment and install dependencies:
   ```
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   pip install -r requirements.txt
   ```

3. Run migrations:
   ```
   python manage.py migrate
   ```

4. Run the development server:
   ```
   python manage.py runserver
   ```

5. Access the API at http://localhost:8000/

## Docker Deployment

1. Build the Docker image:
   ```
   docker build -t yourusername/todo-app .
   ```

2. Run the container:
   ```
   docker run -p 8000:8000 yourusername/todo-app
   ```

3. Push to Docker Hub:
   ```
   docker push yourusername/todo-app
   ```

## Kubernetes Deployment

### Local Kubernetes Deployment (Minikube)

1. Start Minikube:
   ```
   minikube start
   ```

2. Update the deployment.yaml file with your Docker Hub username.

3. Apply the Kubernetes manifests:
   ```
   kubectl apply -f deployment.yaml
   kubectl apply -f service.yaml
   kubectl apply -f hpa.yaml
   ```

4. Access the service:
   ```
   minikube service todo-service
   ```

### Cloud Kubernetes Deployment

1. Set up your cloud provider's Kubernetes service (e.g., EKS, GKE, AKS).

2. Configure kubectl to use your cloud Kubernetes cluster.

3. Update the deployment.yaml file with your Docker Hub username.

4. Apply the Kubernetes manifests:
   ```
   kubectl apply -f deployment.yaml
   kubectl apply -f service.yaml
   kubectl apply -f hpa.yaml
   ```

## Scaling

### Manual Scaling

```
kubectl scale deployment todo-app --replicas=3
```

### Autoscaling

The HPA (Horizontal Pod Autoscaler) is configured to automatically scale based on CPU usage:

```
kubectl apply -f hpa.yaml
```

## Monitoring

Access the health check endpoint at `/health/` to verify the application status.

For more detailed monitoring, consider setting up:
- Prometheus for metrics
- Grafana for visualization
- Loki for logs

## CI/CD Pipeline

The GitHub Actions workflow in `.github/workflows/deploy.yaml` will:
1. Build and test the application
2. Build and push the Docker image
3. Deploy to Kubernetes

To use it, add the following secrets to your GitHub repository:
- `DOCKER_HUB_USERNAME`
- `DOCKER_HUB_ACCESS_TOKEN`
- `KUBE_CONFIG` (base64-encoded kubeconfig file)

## Troubleshooting

### Common Issues

1. **Pods not starting:**
   ```
   kubectl describe pod <pod-name>
   kubectl logs <pod-name>
   ```

2. **Service not accessible:**
   ```
   kubectl get svc
   kubectl describe svc todo-service
   ```

3. **Autoscaling not working:**
   ```
   kubectl describe hpa todo-app-hpa
   ```

For more support, please open an issue on the GitHub repository.
