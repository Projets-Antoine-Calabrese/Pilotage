#!/bin/bash
# --- Outils Claude partagés (Design, Dev, Pilotage, Creatif) -> ~/.claude --- version 2 du 26/10/26
# L'environnement met en cache le résultat de ce script ; la mise à jour à chaque conversation
# est faite ensuite par ~/.claude/hooks/outils-demarrage.sh (fourni par la boîte Pilotage).
# Ne bloque jamais la session : en cas d'échec, un avertissement est affiché et la session démarre quand même.
OUTILS_ORG="${OUTILS_ORG:-https://github.com/Projets-Antoine-Calabrese}"
OUTILS_BASE="$HOME/.claude-outils"
mkdir -p "$OUTILS_BASE" "$HOME/.claude"
for r in Design Dev Pilotage Creatif; do
  rm -rf "$OUTILS_BASE/$r"
  if timeout 90 git clone -q --depth 1 "$OUTILS_ORG/$r" "$OUTILS_BASE/$r"; then
    cp -R "$OUTILS_BASE/$r/.claude/." "$HOME/.claude/"
    echo "Outils Claude : $r installé"
  else
    echo "Outils Claude : échec de récupération de $r (session démarrée sans)" >&2
  fi
done
# --- fin Outils Claude ---
