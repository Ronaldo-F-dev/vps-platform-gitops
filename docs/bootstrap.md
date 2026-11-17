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

## 2. Ingress et certificats
```bash
kubectl apply -f platform/traefik/helmchartconfig.yaml
kubectl apply -f platform/cert-manager/helmchart.yaml
kubectl -n platform rollout status deploy/cert-manager deploy/cert-manager-webhook --timeout=300s
# Remplacer d'abord l'adresse e-mail ACME dans les deux émetteurs letsencrypt (ne pas la commiter) :
kubectl apply -f platform/cert-manager/clusterissuer-selfsigned.yaml
kubectl apply -f platform/cert-manager/clusterissuer-letsencrypt-staging.yaml
```
L'émetteur `letsencrypt-prod` n'est appliqué qu'après un certificat staging émis correctement.

## 3. Application minimale et preuves
```bash
kubectl apply -k apps/whoami/overlays/dev
kubectl apply -k apps/whoami/overlays/staging
kubectl apply -k apps/whoami/overlays/prod
kubectl get certificate -A
scripts/verify-rbac.sh
scripts/test-quota.sh
scripts/test-networkpolicy.sh
```
Consigner les sorties dans `docs/evidence/` (daté) et mettre à jour `docs/test-log.md` de `vps-platform-infra`.
