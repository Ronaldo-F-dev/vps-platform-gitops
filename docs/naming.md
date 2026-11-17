# Conventions de nommage

## Namespaces
`platform` (outils), `dev`, `staging`, `prod`.

## URLs
Forme : `<service>.<env>.<domaine de base>`. Les outils de plateforme utilisent l'environnement `platform`.

| Usage | URL |
|---|---|
| Application dev / staging / prod | `whoami.dev.<base>`, `whoami.staging.<base>`, `whoami.prod.<base>` |
| Outils de plateforme (à venir) | `argocd.platform.<base>`, `grafana.platform.<base>` |

## Domaine de base
- Temporaire : `169.58.11.221.sslip.io` (résout vers l'IP du VPS, aucun achat nécessaire). Hostname
  temporaire clairement identifié, comme le prévoit le document maître.
- Cible : un domaine personnel, à acheter avant l'exposition HTTPS publique finale.
- Basculer = modifier le champ `host` des trois `apps/whoami/overlays/*/ingress-patch.yaml`, rien d'autre.
- Risque connu : `sslip.io` est partagé par tous ses utilisateurs, donc les limites de Let's Encrypt
  peuvent être atteintes. Repli : émetteur `selfsigned`.

## Labels et ressources
- `app.kubernetes.io/name` : nom de l'application ; `app.kubernetes.io/part-of: vps-platform`.
- `platform.vps/environment` : sur les namespaces uniquement.
- Les ressources portent le nom de l'application (`whoami`), sans suffixe d'environnement : le namespace suffit.
