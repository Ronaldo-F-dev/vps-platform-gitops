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

for env in "${envs[@]}"; do
  # Dans son propre namespace
  check yes list pods "$env" deployer "$env"
  check yes create deployments "$env" deployer "$env"
  check yes list pods "$env" viewer "$env"
  check no  create deployments "$env" viewer "$env"
  check no  list pods "$env" app "$env"
done

# Dans les AUTRES namespaces : tout doit être refusé
for env in "${envs[@]}"; do
  for other in "${envs[@]}"; do
    [[ "$env" == "$other" ]] && continue
    check no list pods "$env" deployer "$other"
    check no create deployments "$env" deployer "$other"
    check no list pods "$env" viewer "$other"
  done
done

if (( failures > 0 )); then
  echo "${failures} vérification(s) en échec"
  exit 1
fi
echo "Séparation RBAC conforme"
