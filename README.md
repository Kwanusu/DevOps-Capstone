# DevOps Capstone Project 🚀

This capstone project demonstrates a complete **DevSecOps workflow** for building, securing, deploying, and monitoring a containerized application.  
The project integrates modern DevOps practices with a focus on **automation, security, and scalability**.

---

## 🔑 Project Overview

The workflow covers the entire lifecycle of a containerized application:

- **Version Control** → Manage source code with Git and GitHub.
- **Containerization** → Package applications using Docker.
- **Infrastructure as Code (IaC)** → Provision and manage infrastructure with Terraform/Helm.
- **Orchestration** → Deploy workloads on Kubernetes (K8s).
- **Security** → Apply DevSecOps practices including vulnerability scanning, secret management, and policy enforcement.
- **Monitoring & Logging** → Implement observability with Prometheus, Grafana, and centralized logging.
- **Code Quality** → Ensure maintainability and best practices with SonarQube.

---

## 🛠️ Tech Stack

- **Source Control**: GitHub  
- **CI/CD**: GitHub Actions  
- **Containerization**: Docker  
- **Orchestration**: Kubernetes (Minikube/AKS/EKS/GKE)  
- **Infrastructure as Code**: Terraform, Helm  
- **Security Tools**: Trivy, Snyk, kube-bench  
- **Monitoring/Logging**: Prometheus, Grafana, Loki  
- **Code Quality & Static Analysis**: SonarQube  

---

## ⚙️ Features

- Automated build and test pipeline  
- Secure container image scanning  
- Code quality checks with **SonarQube**  
- Infrastructure provisioning with Terraform  
- Kubernetes deployment manifests and Helm charts  
- Continuous delivery with GitHub Actions and GitOps principles  
- Real-time system health monitoring and alerts  

---

## 🚀 Getting Started

### Prerequisites
- [Git](https://git-scm.com/)  
- [Docker](https://www.docker.com/)  
- [Kubernetes](https://kubernetes.io/) (Minikube or cloud-managed)  
- [Terraform](https://www.terraform.io/)  
- [Helm](https://helm.sh/)  
- [SonarQube](https://www.sonarqube.org/) (for code quality scanning)  

### Setup
1. Clone this repository:
   ```bash
   git clone git@github.com:Kwanusu/DevOps-Capstone.git
   cd DevOps-Capstone
   ```
2. Build and run the Docker container:

```bash
docker build -t devsecops-app .
docker run -p 3000:3000 devsecops-app
Deploy to Kubernetes:
```
3. Deploy to kubernetes
```bash
kubectl apply -f k8s/
Run SonarQube analysis:
```
4. Run SonarQube analysis
```bash
sonar-scanner \
  -Dsonar.projectKey=devops-capstone \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=<your-token>
```
## 📊 Monitoring, Security & Code Quality
- Prometheus → Metrics collection

- Grafana → Dashboards and visualization

- Loki → Log aggregation

- Trivy → Container vulnerability scanning

- SonarQube → Code quality & static analysis

## 📌 Roadmap
 - Add automated integration tests

 - Implement canary deployments

 - Extend GitOps with ArgoCD

 - Enhance security policies with OPA/Gatekeeper

 - Automate SonarQube scans in CI/CD

## 🤝 Contributing
Contributions are welcome! Please fork the repo and open a PR with improvements.

## 📜 License
This project is licensed under the MIT License.

