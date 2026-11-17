#!/usr/bin/env bash
# Vérifie hors cluster que tous les kustomizations se construisent (aucun accès au cluster requis).
set -euo pipefail
cd "$(dirname "$0")/.."

dirs=(
  clusters/vps/namespaces
  environments/dev environments/staging environments/prod
  apps/whoami/overlays/dev apps/whoami/overlays/staging apps/whoami/overlays/prod
)

for d in "${dirs[@]}"; do
  kubectl kustomize "$d" > /dev/null
  echo "OK  $d"
done
