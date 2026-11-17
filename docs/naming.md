# Conventions de nommage

## Namespaces
`platform` (outils), `dev`, `staging`, `prod`.

## URLs
Forme : `<service>.<env>.<domaine de base>`. Les outils de plateforme utilisent l'environnement `platform`.

| Usage | URL |
|---|---|
| Application dev / staging / prod | `whoami.dev.<base>`, `whoami.staging.<base>`, `whoami.prod.<base>` |
| Outils de plateforme (à venir) | `argocd.platform.<base>`, `grafana.platform.<base>` |
