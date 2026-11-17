# Amorçage manuel du cluster (Projet 2)

Prérequis : K3s installé par `vps-platform-infra` (`ansible/platform.yml`), kubeconfig administrateur disponible
via un tunnel SSH (voir `docs/k3s-access.md` de `vps-platform-infra`). Remplacé par Argo CD au Projet 3.

## 0. Validation hors cluster
```bash
scripts/validate.sh
```
