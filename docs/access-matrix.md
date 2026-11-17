# Matrice d'accès

Qui peut lire, déployer ou administrer chaque environnement. Les comptes de service sont créés dans chaque
namespace (`environments/base/serviceaccounts.yaml`) et liés par RoleBinding, donc limités à leur namespace.

| Identité | dev | staging | prod | platform | Cluster |
|---|---|---|---|---|---|
| Administrateur (kubeconfig K3s via SSH) | admin | admin | admin | admin | cluster-admin |
| ServiceAccount `deployer` de l'env | edit (son env) | edit (son env) | edit (son env) | aucun | aucun |
| ServiceAccount `viewer` de l'env | view (son env) | view (son env) | view (son env) | aucun | aucun |
| ServiceAccount `app` de l'env | aucun | aucun | aucun | aucun | aucun |
