# Limites de l'isolation sur un VPS unique

Les namespaces `dev`, `staging` et `prod` séparent les droits (RBAC), les ressources (quotas, limites) et,
avec les NetworkPolicies, une partie des flux. Ils ne créent pas une isolation d'infrastructure.

## Ce qui reste partagé
- Le noyau, le disque et la mémoire du VPS : un conteneur qui sature l'hôte affecte les trois environnements.
- Le plan de contrôle Kubernetes et son datastore : une erreur d'administrateur touche tout le cluster.
- Les CRD, ClusterRoles et ClusterIssuers (objets de portée cluster).
- Le stockage local : pas de réplication, pas d'isolation physique entre volumes.

## Conséquence pour le dossier d'architecture
- `prod` ici n'est pas une production au sens d'une séparation de comptes cloud ou de serveurs.
- Une panne ou une compromission de l'hôte est une panne totale : on valide la reconstruction et la
  restauration (Projet 6), pas la haute disponibilité.
