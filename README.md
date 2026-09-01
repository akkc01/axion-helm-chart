# Axion with Argo CD — App of Apps Deployment

This repository contains the Kubernetes and Argo CD configuration required to deploy multiple microservices using the **Argo CD App of Apps pattern**.

The main Argo CD application (`axion-app-of-apps`) manages all individual micro-application deployments located inside the `applications` folder.

---

### How It Works

```text
                    Argo CD
                       │
                       │
             axion-app-of-apps
                       │
        ┌──────────────┼──────────────┐
        │              │              │
        ▼              ▼              ▼
      App 1          App 2          App 3
        │              │              │
        ▼              ▼              ▼
    Deployment     Deployment     Deployment
```

The `axion-app-of-apps` acts as the **parent application** and manages the child applications present inside the `applications` directory.

---

# 🚀 Deployment Guide

Follow the steps below to deploy the complete Argo CD setup.

## 1. Connect to Your Kubernetes Cluster

First, configure `kubectl` to connect to your Kubernetes cluster.

```bash
kubectl get nodes
```

You should see the nodes of your cluster.

---

## 2. Install Argo CD in the Cluster

Create the Argo CD namespace:

```bash
kubectl create namespace argocd
```

Install Argo CD:

```bash
kubectl apply -n argocd \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Verify the installation:

```bash
kubectl get pods -n argocd
```

All Argo CD components should eventually become `Running`.

You can also verify the services:

```bash
kubectl get svc -n argocd
```

---

## 3. Expose Argo CD Using a Public Domain

Apply the Argo CD Ingress configuration:

```bash
kubectl apply -f argocd-ingress.yaml
```

Verify the ingress:

```bash
kubectl get ingress -n argocd
```

Example:

```text
NAME             CLASS   HOST
argocd-ingress   nginx   argocd.example.com
```

### DNS Configuration

Make sure your DNS record points your domain to the public IP address of the Kubernetes Ingress Controller.

```text
argocd.example.com  →  <INGRESS_PUBLIC_IP>
```

After DNS propagation, Argo CD should be accessible through:

```text
https://argocd.example.com
```

> Make sure `argocd-ingress.yaml` is configured with your actual domain name and TLS settings.

---

## 4. Create the Development Namespace

Apply the namespace manifest:

```bash
kubectl apply -f dev-namespace.yaml
```

Verify:

```bash
kubectl get namespace
```

You should see the `dev` namespace.

---

## 5. Deploy the App of Apps

Finally, apply the main Argo CD Application:

```bash
kubectl apply -f axion-app-of-apps.yaml
```

Verify the application:

```bash
kubectl get applications -n argocd
```

You can also check the App of Apps directly:

```bash
kubectl get application axion-app-of-apps -n argocd
```

---

# 🎯 App of Apps Pattern

Once `axion-app-of-apps.yaml` is applied, Argo CD uses it as the **parent application**.

It manages the child applications inside:

```text
applications/
```

For example:

```text
applications/
├── frontend/
├── backend/
├── auth-service/
├── payment-service/
└── notification-service/
```

The deployment flow becomes:

```text
axion-app-of-apps
        │
        ├── frontend
        │
        ├── backend
        │
        ├── auth-service
        │
        ├── payment-service
        │
        └── notification-service
```

You only need to apply:

```bash
kubectl apply -f axion-app-of-apps.yaml
```

Argo CD takes care of managing the individual applications.

---

# 🔍 Verify Deployment

Check all Argo CD applications:

```bash
kubectl get applications -n argocd
```

Check all pods:

```bash
kubectl get pods -n dev
```

Check deployments:

```bash
kubectl get deployments -n dev
```

Check services:

```bash
kubectl get svc -n dev
```

---

# 🔄 GitOps Workflow

After the initial setup, application deployments can be managed through Git.

```text
Developer
    │
    │ Git Push
    ▼
Git Repository
    │
    ▼
Argo CD
    │
    │ Sync
    ▼
Kubernetes Cluster
    │
    ├── Frontend
    ├── Backend
    ├── Auth
    ├── Payment
    └── Other Microservices
```

When application manifests are updated in Git, Argo CD can synchronize those changes to the Kubernetes cluster.

---

# 📝 Quick Deployment

If everything is already configured, the complete deployment flow is:

```bash
# 1. Verify cluster connection
kubectl get nodes

# 2. Install Argo CD
kubectl create namespace argocd

kubectl apply -n argocd \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# 3. Expose Argo CD
kubectl apply -f argocd-ingress.yaml

# 4. Create development namespace
kubectl apply -f dev-namespace.yaml

# 5. Deploy App of Apps
kubectl apply -f axion-app-of-apps.yaml
```

---

# ✅ Final Result

After completing all the steps:

- Argo CD is installed in the cluster.
- Argo CD is accessible through a public domain.
- The `dev` namespace is created.
- `axion-app-of-apps` is deployed.
- All micro-applications inside the `applications` folder are managed by Argo CD.
- Application deployments can be managed using the GitOps workflow.

---

# 🛠 Useful Commands

### Check Argo CD Pods

```bash
kubectl get pods -n argocd
```

### Check Argo CD Applications

```bash
kubectl get applications -n argocd
```

### Check Application Details

```bash
kubectl describe application axion-app-of-apps -n argocd
```

### Check Dev Namespace

```bash
kubectl get all -n dev
```

### Check Ingress

```bash
kubectl get ingress -n argocd
```

---

# 📌 Important

Before deploying, make sure:

1. `kubectl` is connected to the correct cluster.
2. Your Kubernetes cluster has an Ingress Controller.
3. DNS is configured for the Argo CD domain.
4. `argocd-ingress.yaml` contains the correct domain.
5. `axion-app-of-apps.yaml` points to the correct Git repository and `applications` path.
6. The required Kubernetes manifests or Helm charts exist inside the `applications` directory.

---

# 🎉 Architecture Summary

```text
                    Git Repository
                          │
                          │
                   applications/
                          │
                          ▼
                ┌──────────────────┐
                │    App of Apps   │
                │ axion-app-of-apps│
                └────────┬─────────┘
                         │
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
      Micro App 1    Micro App 2    Micro App 3
          │              │              │
          └──────────────┼──────────────┘
                         ▼
                 Kubernetes Cluster
                         │
                         ▼
                    dev namespace
```

**One parent application → Multiple child applications → Complete microservices deployment.**
