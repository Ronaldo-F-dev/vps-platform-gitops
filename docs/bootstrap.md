# Amorçage manuel du cluster (Projet 2)

Prérequis : K3s installé par `vps-platform-infra` (`ansible/platform.yml`), kubeconfig administrateur disponible
via un tunnel SSH (voir `docs/k3s-access.md` de `vps-platform-infra`). Remplacé par Argo CD au Projet 3.

## 0. Validation hors cluster
```bash
scripts/validate.sh
```

## 1. Namespaces puis environnements
```bash
kubectl apply -k clusters/vps/namespaces
kubectl apply -k environments/dev
kubectl apply -k environments/staging
kubectl apply -k environments/prod
kubectl apply -f platform/namespace/limitrange.yaml
```
