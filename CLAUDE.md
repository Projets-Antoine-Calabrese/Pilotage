# Dépôt Pilotage

Boîte à outils partagée, sans application.
- Ne pas modifier à la main `.claude/skills/`, `.claude/agents/`, `.claude/references/`, `licenses/` : passer par `scripts/sources.txt` puis `bash scripts/sync.sh`.
- Toute modification de la sélection doit être reportée dans `README.md`.
- Diffusion : les sessions cloud de l'environnement AntoCala installent ce dépôt dans `~/.claude/` à chaque démarrage (script de démarrage) → rien à faire. Sur un ordinateur, `bash scripts/maj-outils.sh` (dans Modele-Projet ou un projet qui en est issu) installe les outils dans `~/.claude/`. Les outils ne sont jamais copiés dans un dépôt de projet.
- Ne jamais y mettre de données personnelles.
- `.claude/CLAUDE.md` (consignes globales), `.claude/settings.json` (autorisations et routine de démarrage), `.claude/hooks/` et `routines/` (consignes des conversations automatiques) sont écrits à la main et s'appliquent à toutes les conversations AntoCala : ne les modifier qu'avec l'accord d'Antoine.
