# Structure du dépôt

```
clusters/vps/namespaces/   Namespaces platform, dev, staging, prod
environments/base/         ServiceAccounts, RoleBindings, NetworkPolicies communs
environments/<env>/        Quota et LimitRange de l'environnement (+ base)
platform/                  Traefik (limites), cert-manager (chart + ClusterIssuers), LimitRange
apps/whoami/               Application minimale : base + overlays dev / staging / prod
scripts/                   Validation hors cluster et preuves (RBAC, quota, NetworkPolicy)
tests/                     Manifests de test volontairement refusés
docs/                      Nommage, matrice d'accès, limites d'isolation, amorçage
```
