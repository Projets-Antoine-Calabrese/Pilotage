#!/usr/bin/env bash
# Re-télécharge les sources listées dans scripts/sources.txt et met à jour les copies.
# Usage : bash scripts/sync.sh   (depuis n'importe où)
set -euo pipefail
set -f  # pas d'expansion de * dans les variables
trim(){ sed -E 's/^\s+|\s+$//g' <<<"$1"; }
ROOT="$(cd "$(dirname "$0")/.." && pwd)"; TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
LOG="$ROOT/SOURCES.md"
printf '# Provenance des fichiers copiés\n\nGénéré par `scripts/sync.sh` le %s. Ne pas modifier ces copies à la main.\n\n| Source | Commit | Copié vers | Éléments | Licence |\n|---|---|---|---|---|\n' "$(date -u +%F)" > "$LOG"
grep -vE '^\s*(#|$)' "$ROOT/scripts/sources.txt" | while IFS='|' read -r repo src dst items mode; do
  repo=$(trim "$repo"); src=$(trim "$src"); dst=$(trim "$dst"); items=$(trim "$items"); mode=$(trim "${mode:-}")
  dir="$TMP/${repo//\//_}"
  [ -d "$dir" ] || git clone -q --depth 1 "https://github.com/$repo" "$dir"
  sha=$(git -C "$dir" rev-parse --short HEAD)
  lic=$(ls "$dir" | grep -iE '^licen[cs]e' | head -1 || true)
  mkdir -p "$ROOT/$dst"
  if [ "$items" = "*" ]; then list=$(ls "$dir/$src"); else list=$items; fi
  set +f; n=0
  for spec in $list; do
    it="${spec%%=>*}"; new="${spec#*=>}"
    srcp="$dir/$src/$it"; [ -e "$srcp" ] || srcp="$dir/$src/$it.md"
    [ -e "$srcp" ] || { echo "ABSENT : $repo/$src/$it" >&2; exit 1; }
    if [ "$new" != "$spec" ]; then outname="$new"; else outname="$(basename "$srcp")"; fi
    out="$ROOT/$dst/$outname"; rm -rf "$out"; cp -R "$srcp" "$out"; n=$((n+1))
    # Compétence renommée : aligner le champ name sur le dossier
    if [ "$new" != "$spec" ] && [ -f "$out/SKILL.md" ]; then sed -i -E "0,/^name:.*/s//name: $new/" "$out/SKILL.md"; fi
    # Mode manuel : Claude ne la déclenche pas seul, seulement si on la nomme (/nom)
    if [ "$mode" = "manuel" ] && [ -f "$out/SKILL.md" ] && ! grep -q '^disable-model-invocation:' "$out/SKILL.md"; then
      sed -i -E '0,/^name:.*/s//&\ndisable-model-invocation: true/' "$out/SKILL.md"
    fi
    if [ -d "$out" ] && [ -n "$lic" ]; then cp "$dir/$lic" "$out/LICENSE.source"; fi
    # Sous-agents : nom = nom du fichier (minuscules, tirets), exigé par Claude Code
    if [[ "$dst" == *".claude/agents"* && -f "$out" ]]; then
      slug=$(basename "$out" .md); sed -i -E "0,/^name:.*/s//name: $slug/" "$out"
    fi
  done
  set -f
  if [ -n "$lic" ]; then mkdir -p "$ROOT/licenses"; cp "$dir/$lic" "$ROOT/licenses/${repo//\//_}.txt"; fi
  echo "| [$repo](https://github.com/$repo) | \`$sha\` | \`$dst\` | $n${mode:+ ($mode)} | ${lic:-aucune} |" >> "$LOG"
done
echo "Synchronisation terminée : voir SOURCES.md"
