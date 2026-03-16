# GitOps Application

A GitOps repository managing Kubernetes deployments via **ArgoCD** and **Helm charts** for a weather application and a generic app template.

## Repository Structure

```
gitops-application/
├── argocd/                        # ArgoCD Application manifests
│   ├── dev-app.yaml               # myapp dev environment
│   ├── weather-backend-dev.yaml   # Weather backend dev environment
│   └── weather-frontend-dev.yaml  # Weather frontend dev environment
└── charts/                        # Helm charts
    ├── myapp/                     # Generic application chart
    ├── weather-backend/           # Weather API backend (Flask)
    └── weather-frontend/          # Weather UI frontend (Flask)
```

## Applications

### Weather App

A two-tier web application:

- **weather-backend** — Flask REST API serving weather data (`henria/weather_app_backend`)
- **weather-frontend** — Flask web UI consuming the backend (`henria/weather_app_frontend`)

The frontend connects to the backend via Kubernetes DNS: `http://weather-backend-weather-backend:80`.

### myapp

A generic, reusable Helm chart with support for Deployment, Service, ConfigMap, Secret, CronJob, and DaemonSet resources. Useful as a template for new services.

## Environments

| Environment | Replicas | Image Tag | Trigger |
|-------------|----------|-----------|---------|
| dev | 1 | `latest` / any push | GitHub Actions on every push |
| prod | 2 | semver (`v*.*.*`) | GitHub Actions on git tag |

## ArgoCD Sync Policy

All applications use automated sync with:

- **Prune** — removes resources no longer in Git
- **Self-heal** — reverts manual changes in the cluster

## Charts

### weather-backend / weather-frontend

Minimal charts with Deployment and Service templates. Values files per environment:

- `values.yaml` — base defaults
- `values-dev.yaml` — dev overrides (1 replica, `FLASK_ENV=development`)
- `values-prod.yaml` — prod overrides (2 replicas, `FLASK_ENV=production`)

### myapp

Full-featured chart with optional resources controlled via `values.yaml` flags. Includes templates for:

- `deployment.yaml`
- `service.yaml`
- `configmap.yaml`
- `secret.yaml`
- `cronjob.yaml`
- `daemonset.yaml`

## Prerequisites

- Kubernetes cluster
- ArgoCD installed and configured
- Access to `https://github.com/henria/gitops-application.git`

## Adding a New Application

1. Create a new Helm chart under `charts/`
2. Add `values-dev.yaml` and `values-prod.yaml`
3. Create an ArgoCD Application manifest under `argocd/`
4. Apply the manifest: `kubectl apply -f argocd/<your-app>.yaml`
