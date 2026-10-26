#!/bin/bash
# Rafraîchit les boîtes à outils (Design, Dev, Pilotage, Creatif) au début de chaque conversation cloud.
# Pourquoi : le résultat du script de démarrage de l'environnement AntoCala est mis en cache ;
# sans ce rafraîchissement, les mises à jour du lundi n'arriveraient pas dans les nouvelles conversations.
# Ne bloque jamais : en cas d'échec, la conversation démarre avec la version déjà présente.
[ "${CLAUDE_CODE_REMOTE:-}" = "true" ] || exit 0
OUTILS_ORG="${OUTILS_ORG:-https://github.com/Projets-Antoine-Calabrese}"
BASE="$HOME/.claude-outils"
mkdir -p "$BASE" "$HOME/.claude"
for r in Design Dev Pilotage Creatif; do
  d="$BASE/$r"
  if [ -d "$d/.git" ] && timeout 30 git -C "$d" fetch -q --depth 1 origin main 2>/dev/null; then
    git -C "$d" reset -q --hard FETCH_HEAD 2>/dev/null
  else
    rm -rf "$d"
    timeout 60 git clone -q --depth 1 "$OUTILS_ORG/$r" "$d" 2>/dev/null || continue
  fi
  [ -d "$d/.claude" ] && cp -R "$d/.claude/." "$HOME/.claude/"
done
exit 0
