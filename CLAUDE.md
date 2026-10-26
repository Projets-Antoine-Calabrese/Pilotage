# Dépôt Pilotage

Boîte à outils partagée, sans application.
- Ne pas modifier à la main `.claude/skills/`, `.claude/agents/`, `.claude/references/`, `licenses/` : passer par `scripts/sources.txt` puis `bash scripts/sync.sh`.
- Toute modification de la sélection doit être reportée dans `README.md`.
- Diffusion : les sessions cloud de l'environnement AntoCala installent ce dépôt dans `~/.claude/` à chaque démarrage (script de démarrage) → rien à faire. Pour les copies locales, lancer `bash scripts/maj-outils.sh` dans `Modele-Projet` et dans les projets qui en sont issus.
- Ne jamais y mettre de données personnelles.
