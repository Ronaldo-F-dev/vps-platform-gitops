#!/usr/bin/env bash
# Prouve l'effectivité des NetworkPolicies (ADR-003) : flux bloqué puis flux autorisé.
# Prérequis : application whoami déployée dans prod.
#   scripts/test-networkpolicy.sh | tee docs/evidence/networkpolicy-$(date +%F).txt
set -uo pipefail

target="http://whoami.prod.svc.cluster.local"

probe() { # <namespace> <nom du pod de test>
  kubectl -n "$1" run "$2" --rm -i --restart=Never --image=busybox:1.36.1 \
    --command -- wget -q -T 5 -O /dev/null "$target"
}
