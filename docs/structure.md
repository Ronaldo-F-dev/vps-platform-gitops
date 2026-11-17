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

## Préparation pour Argo CD (Projet 3)
- Chaque dossier racine correspondra à une `Application` Argo CD (app-of-apps) : `clusters/vps/namespaces`,
  `environments/*`, `platform/*`, `apps/whoami/overlays/*`.
- Les overlays Kustomize `dev` / `staging` / `prod` sont déjà la forme attendue pour des promotions par
  pull request.
- Rien n'est automatisé au Projet 2 : l'application des manifests est manuelle et décrite dans `bootstrap.md`.
