#!/bin/bash
# --- Outils Claude partagés (Design, Dev, Pilotage, Creatif) -> ~/.claude pour toutes les sessions ---
# Ne bloque jamais la session : en cas d'échec, un avertissement est affiché et la session démarre quand même.
OUTILS_ORG="${OUTILS_ORG:-https://github.com/Projets-Antoine-Calabrese}"
OUTILS_TMP="$(mktemp -d)"
mkdir -p "$HOME/.claude"
for r in Design Dev Pilotage Creatif; do
  if timeout 90 git clone -q --depth 1 "$OUTILS_ORG/$r" "$OUTILS_TMP/$r"; then
    cp -R "$OUTILS_TMP/$r/.claude/." "$HOME/.claude/"
    echo "Outils Claude : $r installé"
  else
    echo "Outils Claude : échec de récupération de $r (session démarrée sans)" >&2
  fi
done
rm -rf "$OUTILS_TMP"
# --- fin Outils Claude ---
