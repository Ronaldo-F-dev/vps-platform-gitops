# vps-platform-gitops

Configuration déclarative du cluster K3s du VPS (Projet 2 du parcours DevOps Senior).
Tout ce qui est appliqué au cluster est décrit ici : namespaces, quotas, RBAC, politiques réseau,
composants de plateforme et application de démonstration.

Le socle hôte et l'installation de K3s vivent dans `vps-platform-infra` (Ansible). Ce dépôt ne
contient que des manifests Kubernetes.

## Documentation
- `docs/structure.md` : arborescence et préparation Argo CD
- `docs/bootstrap.md` : ordre d'application manuel (Projet 2)
- `docs/naming.md` : namespaces, URLs, domaine
- `docs/access-matrix.md` : qui peut lire, déployer, administrer
- `docs/isolation-limits.md` : ce qu'un namespace n'isole pas

## Règles
- Aucun secret dans ce dépôt, aucun kubeconfig, aucune adresse e-mail personnelle.
- Tout changement passe par un commit relu ; pas de `kubectl edit` hors incident documenté.
- Un namespace sépare des droits et des ressources, pas de l'infrastructure : voir
  `docs/isolation-limits.md`.
