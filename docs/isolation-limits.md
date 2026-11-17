# Limites de l'isolation sur un VPS unique

Les namespaces `dev`, `staging` et `prod` séparent les droits (RBAC), les ressources (quotas, limites) et,
avec les NetworkPolicies, une partie des flux. Ils ne créent pas une isolation d'infrastructure.
