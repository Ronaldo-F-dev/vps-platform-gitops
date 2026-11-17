#!/usr/bin/env bash
# Prouve la séparation RBAC entre environnements (critère de sortie Projet 2).
# Exige un kubeconfig administrateur : les tests se font par impersonation (--as).
#   scripts/verify-rbac.sh | tee docs/evidence/rbac-$(date +%F).txt
set -uo pipefail

envs=(dev staging prod)
failures=0

# check <attendu> <verbe> <ressource> <env du compte> <compte> <env cible>
check() {
  local expected=$1 verb=$2 resource=$3 sa_env=$4 sa=$5 target=$6 got
  got=$(kubectl auth can-i "$verb" "$resource" \
        --as="system:serviceaccount:${sa_env}:${sa}" -n "$target" 2>/dev/null || true)
  if [[ "$got" == "$expected" ]]; then
    echo "OK    ${sa_env}/${sa} ${verb} ${resource} dans ${target} -> ${got}"
  else
    echo "ÉCHEC ${sa_env}/${sa} ${verb} ${resource} dans ${target} -> ${got} (attendu ${expected})"
    failures=$((failures + 1))
  fi
}
