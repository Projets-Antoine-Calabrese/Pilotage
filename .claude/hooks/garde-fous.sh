#!/bin/bash
# Garde-fous automatiques (choix d'Antoine du 30/10/26), déclarés dans .claude/settings.json (PreToolUse).
# 1. Interdit de modifier à la main les outils copiés dans une boîte (passer par scripts/sources.txt + sync.sh).
# 2. Bloque un commit ou un envoi vers une boîte publique (Design, Dev, Pilotage, Creatif) dont les lignes
#    ajoutées contiennent une clé, un IBAN, un téléphone ou une adresse e-mail personnelle.
# Code 2 = blocage (le message va à Claude). En cas d'erreur interne, ne bloque jamais.
command -v python3 >/dev/null 2>&1 || exit 0
exec python3 -I - "$@" 3<&0 <<'PY'
import json, os, re, shlex, subprocess, sys
try:
    data = json.load(os.fdopen(3))
except Exception:
    sys.exit(0)
tool = data.get("tool_name", ""); inp = data.get("tool_input") or {}; cwd = data.get("cwd") or os.getcwd()
BOITES = r"(design|dev|pilotage|creatif)"
def stop(msg):
    print(msg, file=sys.stderr); sys.exit(2)

if tool in ("Edit", "Write", "MultiEdit", "NotebookEdit"):
    path = inp.get("file_path") or inp.get("notebook_path") or ""
    if re.search(r"/" + BOITES + r"/(\.claude/(skills|agents|references|commands)|licenses)/", path, re.I):
        stop("Garde-fou : ce fichier est une copie gérée par scripts/sync.sh. Modifie scripts/sources.txt puis lance bash scripts/sync.sh, au lieu de le changer à la main.")
    sys.exit(0)

if tool != "Bash":
    sys.exit(0)
cmd = inp.get("command", "")
if not re.search(r"\bgit\b[^;&|]*\b(commit|push)\b", cmd):
    sys.exit(0)

# Dossiers concernés : celui de la conversation, et ceux cités par « cd X » ou « git -C X ».
dirs = {cwd}
try:
    toks = shlex.split(cmd, posix=True)
except Exception:
    toks = cmd.split()
for i, t in enumerate(toks[:-1]):
    if t in ("cd", "-C"):
        dirs.add(os.path.join(cwd, os.path.expanduser(toks[i + 1])))

def git(d, *a):
    r = subprocess.run(["git", "-C", d, *a], capture_output=True, text=True, timeout=20)
    return r.stdout if r.returncode == 0 else None

PATTERNS = [
    ("clé privée", r"-----BEGIN [A-Z ]*PRIVATE KEY-----"),
    ("jeton GitHub", r"\b(ghp|gho|ghs|ghu)_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{30,}"),
    ("clé d'API", r"\bsk-(ant-)?[A-Za-z0-9_-]{20,}|\bAKIA[0-9A-Z]{16}\b|\bAIza[0-9A-Za-z_-]{35}\b|\bxox[abpr]-[A-Za-z0-9-]{10,}"),
    ("IBAN", r"\bFR\d{2}[ ]?(\d{4}[ ]?){2}(\w{4}[ ]?){2}\w{3}\b"),
    ("téléphone", r"(?<![\w.])(\+33[ .]?|0)[67]([ .-]?\d{2}){4}(?![\w.])"),
    ("e-mail personnel", r"\b[A-Za-z0-9._%+-]+@(gmail|googlemail|hotmail|outlook|live|yahoo|icloud|me|orange|free|wanadoo|laposte|sfr|bbox)\.(com|fr|net)\b"),
]
IGNORE = re.compile(r"^(\.claude/(skills|agents|references|commands)|licenses)/|^SOURCES\.md$")

for d in dirs:
    if not os.path.isdir(d):
        continue
    url = git(d, "remote", "get-url", "origin") or ""
    if not re.search(r"Projets-Antoine-Calabrese/" + BOITES + r"(\.git)?/?\s*$", url, re.I):
        continue
    if re.search(r"\bpush\b", cmd):
        base = (git(d, "rev-parse", "--abbrev-ref", "@{u}") or "origin/main").strip()
        diff = git(d, "diff", "--unified=0", base + "...HEAD")
    else:
        diff = git(d, "diff", "--cached", "--unified=0")
        if "-a" in toks or "--all" in toks or "-am" in toks:
            diff = (diff or "") + (git(d, "diff", "--unified=0") or "")
    if not diff:
        continue
    found, f = [], None
    for line in diff.splitlines():
        if line.startswith("+++ "):
            f = line[6:] if line.startswith("+++ b/") else None
            continue
        if not line.startswith("+") or f is None or IGNORE.search(f):
            continue
        for name, pat in PATTERNS:
            if re.search(pat, line[1:]):
                found.append(f"{f} : {name}")
    if found:
        stop("Garde-fou : envoi bloqué vers une boîte publique (" + os.path.basename(d) + "). Contenu possiblement personnel ou secret dans :\n- "
             + "\n- ".join(sorted(set(found))[:15])
             + "\nRetire-le (exemple anonymisé à la place). Si c'est une fausse alerte, explique-le à Antoine au lieu de contourner.")
sys.exit(0)
PY
