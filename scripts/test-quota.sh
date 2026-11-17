#!/usr/bin/env bash
# Prouve qu'une charge au-dessus du quota est refusée (critère de sortie Projet 2).
#   scripts/test-quota.sh | tee docs/evidence/quota-$(date +%F).txt
set -uo pipefail
cd "$(dirname "$0")/.."

echo "== Quota de dev avant le test"
kubectl -n dev describe resourcequota env-quota

echo "== Création d'un pod au-dessus du quota (refus attendu)"
if out=$(kubectl -n dev apply -f tests/quota-exceed.yaml 2>&1); then
  echo "ÉCHEC : le pod a été accepté"
  kubectl -n dev delete -f tests/quota-exceed.yaml --ignore-not-found
  exit 1
fi
echo "$out"

if grep -q "exceeded quota" <<< "$out"; then
  echo "OK : refusé par le ResourceQuota"
else
  echo "ÉCHEC : refus pour une autre raison que le quota"
  exit 1
fi
