# Axion App — Helm Chart

Helm Umbrella Chart for deploying the **Axion Intelligence Platform** on Kubernetes.

This chart manages the complete Axion application stack as a single Helm release using multiple child charts.

---

## Architecture

The Axion application consists of the following components:

```text
                         ┌─────────────────────┐
                         │      Browser        │
                         └──────────┬──────────┘
                                    │
                                    ▼
                         ┌─────────────────────┐
                         │      Axion UI       │
                         │      NGINX          │
                         └──────────┬──────────┘
                                    │
                                    │ API Requests
                                    ▼
                         ┌─────────────────────┐
                         │ Telemetry Backend   │
                         │ FastAPI / Uvicorn   │
                         │       :8000         │
                         └──────────┬──────────┘
                                    │
                                    ▼
                         ┌─────────────────────┐
                         │     PostgreSQL      │
                         │       :5432         │
                         └─────────────────────┘


        ┌──────────────────────┐
        │      Simulator       │
        └──────────┬───────────┘
                   │
                   │ POST telemetry
                   ▼
        ┌──────────────────────┐
        │      Ingestion       │
        │       :8000          │
        └──────────┬───────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │     PostgreSQL       │
        └──────────────────────┘


        ┌──────────────────────┐
        │       pgAdmin        │
        │       :80            │
        └──────────┬───────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │     PostgreSQL       │
        └──────────────────────┘
```

---

# Components

The umbrella chart contains the following child charts:

| Component | Purpose |
|---|---|
| `ui-chart` | Axion web frontend |
| `telemetry-chart` | Telemetry query/dashboard backend |
| `simulator-chart` | Generates/sends telemetry data |
| `ingestion-chart` | Receives telemetry data |
| `postgres-db-chart` | PostgreSQL database |
| `pgadmin-chart` | PostgreSQL administration UI |

All components are deployed as a **single Helm release**.

---

# Repository Structure

```text
axion-app-helm/
│
├── Chart.yaml
├── values.yaml
├── README.md
├── .gitignore
│
├── templates/
│   └── _helpers.tpl
│
└── charts/
    │
    ├── ui-chart/
    │   ├── Chart.yaml
    │   ├── values.yaml
    │   └── templates/
    │
    ├── telemetry-chart/
    │   ├── Chart.yaml
    │   ├── values.yaml
    │   └── templates/
    │
    ├── simulator-chart/
    │   ├── Chart.yaml
    │   ├── values.yaml
    │   └── templates/
    │
    ├── ingestion-chart/
    │   ├── Chart.yaml
    │   ├── values.yaml
    │   └── templates/
    │
    ├── postgres-db-chart/
    │   ├── Chart.yaml
    │   ├── values.yaml
    │   └── templates/
    │
    └── pgadmin-chart/
        ├── Chart.yaml
        ├── values.yaml
        └── templates/
```

Generated Helm dependency packages (`*.tgz`) are not required in Git because they can be regenerated using:

```bash
helm dependency update
```

---

# Prerequisites

Before installing the chart, make sure the following are installed:

- Kubernetes cluster
- `kubectl`
- Helm 3.x
- Access to the Kubernetes cluster
- Container images accessible from the cluster

Verify:

```bash
kubectl version --client
```

```bash
helm version
```

Verify Kubernetes connectivity:

```bash
kubectl cluster-info
```

Check the current context:

```bash
kubectl config current-context
```

---

# Clone Repository

Clone the Helm repository:

```bash
git clone https://github.com/<YOUR_USERNAME>/axion-app-helm.git
```

Enter the directory:

```bash
cd axion-app-helm
```

---

# Chart Dependencies

This is an umbrella chart.

Dependencies are defined in `Chart.yaml`:

```yaml
dependencies:

  - name: ui-chart
    version: 1.0.0
    repository: "file://charts/ui-chart"

  - name: telemetry-chart
    version: 1.0.0
    repository: "file://charts/telemetry-chart"

  - name: simulator-chart
    version: 1.0.0
    repository: "file://charts/simulator-chart"

  - name: ingestion-chart
    version: 1.0.0
    repository: "file://charts/ingestion-chart"

  - name: postgres-db-chart
    version: 1.0.0
    repository: "file://charts/postgres-db-chart"

  - name: pgadmin-chart
    version: 1.0.0
    repository: "file://charts/pgadmin-chart"
```

Update/build the dependencies:

```bash
helm dependency update
```

Verify:

```bash
helm dependency list
```

Expected:

```text
NAME                 VERSION   REPOSITORY
ui-chart             1.0.0     file://charts/ui-chart
telemetry-chart      1.0.0     file://charts/telemetry-chart
simulator-chart      1.0.0     file://charts/simulator-chart
ingestion-chart      1.0.0     file://charts/ingestion-chart
postgres-db-chart    1.0.0     file://charts/postgres-db-chart
pgadmin-chart        1.0.0     file://charts/pgadmin-chart
```

---

# Validate the Chart

Run Helm lint:

```bash
helm lint .
```

Expected:

```text
1 chart(s) linted, 0 chart(s) failed
```

Render the Kubernetes manifests without installing:

```bash
helm template axion-app . \
  -n axion-dev \
  -f values.yaml
```

This is useful for validating the generated Kubernetes YAML.

---

# Dry Run

Perform a client-side dry run:

```bash
helm upgrade --install axion-app . \
  -n axion-dev \
  --create-namespace \
  -f values.yaml \
  --dry-run=client
```

Review the generated manifests before deployment.

---

# Installation

Install the complete Axion application:

```bash
helm upgrade --install axion-app . \
  -n axion-dev \
  --create-namespace \
  -f values.yaml
```

For example:

```bash
helm upgrade --install axion-app . \
  -n prod-ns \
  --create-namespace \
  -f values.yaml
```

The release name can be changed:

```bash
helm upgrade --install akkc . \
  -n akkc \
  --create-namespace \
  -f values.yaml
```

---

# Verify Installation

Check Helm release:

```bash
helm list -n axion-dev
```

Check all resources:

```bash
kubectl get all -n axion-dev
```

Check pods:

```bash
kubectl get pods -n axion-dev
```

Expected components include:

```text
Axion UI
Telemetry
Simulator
Ingestion
PostgreSQL
pgAdmin
```

Check services:

```bash
kubectl get svc -n axion-dev
```

Check deployments:

```bash
kubectl get deployments -n axion-dev
```

Check ingress:

```bash
kubectl get ingress -n axion-dev
```

---

# Check Pod Status

All application pods should eventually become:

```text
READY   STATUS
1/1     Running
```

Check:

```bash
kubectl get pods -n axion-dev -o wide
```

If a pod is not running:

```bash
kubectl describe pod <POD_NAME> -n axion-dev
```

Check logs:

```bash
kubectl logs <POD_NAME> -n axion-dev
```

---

# Service Architecture

The application uses Kubernetes Services for internal communication.

Example:

```text
Axion UI
   |
   | HTTP
   ▼
Telemetry Service
   |
   ▼
Telemetry Pod :8000
```

Simulator:

```text
Simulator
   |
   | POST /api/v1/telemetry/ingest
   ▼
Ingestion Service
   |
   ▼
Ingestion Pod :8000
```

Database:

```text
Telemetry
     |
     ▼
PostgreSQL Service :5432

Ingestion
     |
     ▼
PostgreSQL Service :5432
```

---

# Telemetry Service URL

The parent chart provides the telemetry service URL through a global value.

Example:

```yaml
global:
  telemetryServiceUrl: "http://localhost:8085"
```

The parent helper:

```yaml
{{/*
Telemetry service URL
*/}}
{{- define "axion.telemetryService" -}}
{{ .Values.global.telemetryServiceUrl }}
{{- end }}
```

The UI consumes this value.

For local port-forward testing:

```yaml
global:
  telemetryServiceUrl: "http://localhost:8085"
```

For an externally exposed production API:

```yaml
global:
  telemetryServiceUrl: "https://telemetry.example.com"
```

Do not hard-code environment-specific URLs inside the templates.

---

# Local Port Forwarding

For local UI testing, expose the Axion UI:

```bash
kubectl port-forward \
  svc/axion-app-axion-svc \
  8080:80 \
  -n axion-dev
```

Open:

```text
http://localhost:8080
```

Expose the telemetry backend separately:

```bash
kubectl port-forward \
  svc/axion-app-axion-telemetry-svc \
  8085:80 \
  -n axion-dev
```

The architecture during local testing is:

```text
Browser
   |
   | localhost:8080
   ▼
Axion UI
   |
   | localhost:8085
   ▼
Telemetry Backend
```

Verify telemetry:

```bash
curl -i http://localhost:8085/docs
```

Test the dashboard API:

```bash
curl -i http://localhost:8085/dashboard/summary
```

---

# Important: Browser vs Kubernetes Networking

`localhost` has different meanings depending on where the request originates.

From your Mac/browser:

```text
http://localhost:8085
```

means your local machine.

Inside a Kubernetes pod:

```text
http://localhost:8085
```

means that pod itself.

For Kubernetes internal communication, use the Kubernetes Service:

```text
http://<service-name>:<port>
```

or:

```text
http://<service-name>.<namespace>.svc.cluster.local:<port>
```

Example:

```text
http://axion-app-axion-telemetry-svc.prod-ns.svc.cluster.local:80
```

---

# Simulator → Ingestion

The simulator uses the parent helper:

```yaml
{{/*
Ingestion API URL
*/}}
{{- define "simulator.ingestionApiUrl" -}}
http://{{ include "axion.ingestionServiceName" . }}:80/api/v1/telemetry/ingest
{{- end }}
```

The parent helper generates the ingestion Service name:

```yaml
{{/*
Ingestion service name
*/}}
{{- define "axion.ingestionServiceName" -}}
{{ include "axion.name" . }}-{{ .Release.Name }}-ingestion-svc
{{- end }}
```

This keeps the Simulator and Ingestion Service names synchronized.

---

# Check Ingestion Service

Check the Service:

```bash
kubectl get svc -n axion-dev
```

Check endpoints:

```bash
kubectl get endpoints ingestion-svc -n axion-dev -o wide
```

On newer Kubernetes versions, EndpointSlice can also be checked:

```bash
kubectl get endpointslice -n axion-dev
```

If the Service has no endpoints, verify the Service selector and pod labels.

---

# Check Simulator

Check simulator pod:

```bash
kubectl get pods -n axion-dev -l app=simulator
```

View logs:

```bash
kubectl logs -n axion-dev \
  -l app=simulator \
  --tail=100
```

The simulator should be able to communicate with the ingestion Service.

---

# Check Telemetry Backend

Check telemetry:

```bash
kubectl get pods -n axion-dev -l app=telemetry
```

Check logs:

```bash
kubectl logs -n axion-dev \
  -l app=telemetry \
  --tail=100
```

Check the service:

```bash
kubectl get svc axion-app-axion-telemetry-svc \
  -n axion-dev
```

Check endpoints:

```bash
kubectl get endpoints \
  axion-app-axion-telemetry-svc \
  -n axion-dev \
  -o wide
```

---

# Test Telemetry API

If port-forwarding:

```bash
kubectl port-forward \
  svc/axion-app-axion-telemetry-svc \
  8085:80 \
  -n axion-dev
```

Swagger:

```text
http://localhost:8085/docs
```

OpenAPI:

```text
http://localhost:8085/openapi.json
```

Dashboard API:

```bash
curl -i http://localhost:8085/dashboard/summary
```

---

# PostgreSQL

Check PostgreSQL:

```bash
kubectl get pods -n axion-dev \
  -l app=postgres
```

Check service:

```bash
kubectl get svc \
  axion-axion-app-postgres-svc \
  -n axion-dev
```

PostgreSQL service port:

```text
5432
```

The application connects to PostgreSQL using the Kubernetes Service rather than the pod IP.

---

# pgAdmin

Check pgAdmin:

```bash
kubectl get pods -n axion-dev \
  -l app=pgadmin
```

Check Service:

```bash
kubectl get svc \
  axion-axion-app-pgadmin-svc \
  -n axion-dev
```

For local access:

```bash
kubectl port-forward \
  svc/axion-axion-app-pgadmin-svc \
  8082:80 \
  -n axion-dev
```

Then open:

```text
http://localhost:8082
```

---

# Ingress

If an Ingress/Application Gateway is configured, check:

```bash
kubectl get ingress -n axion-dev
```

Describe an ingress:

```bash
kubectl describe ingress <INGRESS_NAME> -n axion-dev
```

Example hosts used by the deployment can include:

```text
dev.axion.theakkc.space
telemetry.theakkc.space
dev.ingest.theakkc.space
pgadmin.theakkc.shop
```

These hostnames depend on the environment-specific values and DNS configuration.

---

# Upgrade

After modifying the Helm chart:

```bash
helm upgrade axion-app . \
  -n axion-dev \
  -f values.yaml
```

Or use the same install/upgrade command:

```bash
helm upgrade --install axion-app . \
  -n axion-dev \
  -f values.yaml
```

This is recommended because it works whether the release already exists or not.

---

# Rollback

Check release history:

```bash
helm history axion-app -n axion-dev
```

Rollback to a previous revision:

```bash
helm rollback axion-app <REVISION> -n axion-dev
```

Verify:

```bash
helm status axion-app -n axion-dev
```

---

# Uninstall

To remove the Helm release:

```bash
helm uninstall axion-app -n axion-dev
```

Verify:

```bash
kubectl get all -n axion-dev
```

If the namespace is dedicated to Axion and no longer needed:

```bash
kubectl delete namespace axion-dev
```

Be careful with namespace deletion because it removes all resources in that namespace.

---

# Useful Helm Commands

List releases:

```bash
helm list -A
```

Check release:

```bash
helm status axion-app -n axion-dev
```

Get values:

```bash
helm get values axion-app -n axion-dev
```

Get all values:

```bash
helm get values axion-app \
  -n axion-dev \
  --all
```

Get rendered manifest:

```bash
helm get manifest axion-app -n axion-dev
```

List dependencies:

```bash
helm dependency list
```

Update dependencies:

```bash
helm dependency update
```

Lint:

```bash
helm lint .
```

Render:

```bash
helm template axion-app . \
  -n axion-dev \
  -f values.yaml
```

---

# Troubleshooting

## 1. Helm installation fails

Run:

```bash
helm lint .
```

Then:

```bash
helm template axion-app . \
  -n axion-dev \
  -f values.yaml
```

This helps identify template errors before deployment.

---

## 2. Pod is CrashLoopBackOff

Check:

```bash
kubectl get pods -n axion-dev
```

Then:

```bash
kubectl logs <POD_NAME> -n axion-dev
```

For the previous container:

```bash
kubectl logs <POD_NAME> \
  -n axion-dev \
  --previous
```

---

## 3. Service has no endpoints

Check:

```bash
kubectl get svc -n axion-dev
```

Then:

```bash
kubectl get endpoints <SERVICE_NAME> \
  -n axion-dev \
  -o wide
```

Compare:

```text
Service selector
        ↓
Pod labels
```

They must match.

---

## 4. UI loads but shows a blank page

First check the UI:

```bash
kubectl get pods -n axion-dev -l app=axion-ui
```

Check logs:

```bash
kubectl logs -n axion-dev \
  -l app=axion-ui \
  --tail=100
```

Check the UI HTML:

```bash
curl -i http://localhost:8080
```

Check runtime configuration:

```bash
curl -i http://localhost:8080/config.js
```

The generated configuration must contain valid JavaScript, for example:

```javascript
window.__CONFIG__ = {
  API_BASE: "http://localhost:8085"
};
```

Do not generate:

```javascript
API_BASE: ""http://localhost:8085""
```

because this is invalid JavaScript.

---

## 5. UI loads but no backend data

Check telemetry:

```bash
curl -i http://localhost:8085/docs
```

Then:

```bash
curl -i http://localhost:8085/dashboard/summary
```

Check browser:

```text
Developer Tools
    ↓
Network
    ↓
Fetch/XHR
```

Verify the API request URL and HTTP status.

---

## 6. Simulator is not sending data

Check:

```bash
kubectl logs -n axion-dev \
  -l app=simulator \
  --tail=100
```

Check ingestion Service:

```bash
kubectl get svc ingestion-svc -n axion-dev
```

Check endpoints:

```bash
kubectl get endpoints ingestion-svc \
  -n axion-dev \
  -o wide
```

Verify that the Simulator's generated API URL points to the actual ingestion Service.

---

# Security

Do not commit real credentials to GitHub.

Avoid storing real values such as:

```yaml
password: jarvis12345
```

in a public repository.

Use Kubernetes Secrets, external secret management, or environment-specific secret injection.

Before pushing the repository:

```bash
git status
```

Review files carefully:

```bash
git diff --cached
```

You can also search for suspicious credentials:

```bash
grep -RniE 'password|secret|token|apikey|api_key' .
```

Review the results before committing.

---

# GitHub Workflow

Initialize Git:

```bash
git init
```

Create `.gitignore`:

```gitignore
.DS_Store
*.tgz
```

Add files:

```bash
git add .
```

Commit:

```bash
git commit -m "Add Axion umbrella Helm chart"
```

Add remote:

```bash
git remote add origin https://github.com/<USERNAME>/axion-app-helm.git
```

Rename branch:

```bash
git branch -M main
```

Push:

```bash
git push -u origin main
```

---

# Installation from GitHub

After the chart is pushed:

```bash
git clone https://github.com/<USERNAME>/axion-app-helm.git
```

```bash
cd axion-app-helm
```

Update dependencies:

```bash
helm dependency update
```

Lint:

```bash
helm lint .
```

Install:

```bash
helm upgrade --install axion-app . \
  -n axion-dev \
  --create-namespace \
  -f values.yaml
```

Verify:

```bash
kubectl get pods -n axion-dev
```

---

# Deployment Workflow

Recommended workflow:

```text
Developer
   |
   ▼
Modify Helm Chart
   |
   ▼
helm dependency update
   |
   ▼
helm lint
   |
   ▼
helm template
   |
   ▼
helm upgrade --install
   |
   ▼
Kubernetes
   |
   ├── Axion UI
   ├── Telemetry
   ├── Simulator
   ├── Ingestion
   ├── PostgreSQL
   └── pgAdmin
```

---

# Environment-Specific Values

For multiple environments, maintain separate values files.

Example:

```text
values.yaml
values-dev.yaml
values-qa.yaml
values-prod.yaml
```

Install development:

```bash
helm upgrade --install axion-app . \
  -n axion-dev \
  --create-namespace \
  -f values.yaml \
  -f values-dev.yaml
```

Install QA:

```bash
helm upgrade --install axion-app . \
  -n axion-qa \
  --create-namespace \
  -f values.yaml \
  -f values-qa.yaml
```

Install production:

```bash
helm upgrade --install axion-app . \
  -n axion-prod \
  --create-namespace \
  -f values.yaml \
  -f values-prod.yaml
```

The environment-specific values should contain only the configuration that changes between environments.

---

# Summary

This Helm repository provides a single deployment mechanism for the Axion Intelligence Platform.

Instead of installing each component separately:

```bash
helm install ui ...
helm install telemetry ...
helm install simulator ...
helm install ingestion ...
helm install postgres ...
helm install pgadmin ...
```

the umbrella chart allows the complete application to be deployed with:

```bash
helm upgrade --install axion-app . \
  -n axion-dev \
  --create-namespace \
  -f values.yaml
```

This provides a single Helm release for the complete Axion application stack.

---

## Author

**Axion Intelligence Platform**

Cloud / DevOps / Kubernetes / Helm Project

### Save it

From your chart root:

```bash
nano README.md
```

Paste the README above, save, then:

```bash
git add README.md
git commit -m "Add Helm deployment documentation"
git push
```