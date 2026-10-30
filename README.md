# Pilotage — gestion de projets, produit et données

Compétences et sous-agents pour décider quoi construire, suivre l'avancement et analyser les données des applications.
Provenance exacte et commits dans `SOURCES.md`.

| Dossier | Contenu |
|---|---|
| `.claude/skills/` | 15 compétences |
| `references/` | `donnees.md` (sources de données : finances, sport, nutrition, données publiques), `veille.md` (où chercher de nouveaux outils, connecteurs à envisager, sources écartées) |
| `.claude/agents/` | 13 sous-agents (produit, gestion de projet, experts métier) |
| `.claude/CONNECTORS.md` | Correspondance des `~~outils` avec nos connecteurs (écrit à la main) |
| `licenses/`, `scripts/` | Licences ; `sources.txt` + `sync.sh` |
| `routines/` | Consignes des conversations automatiques (veille lundi-mercredi-vendredi, MAJ hebdo, sécurité hebdo, organisation du samedi), écrites à la main |
| `agents-maison/` | Sous-agents écrits pour Antoine (écrits à la main ici, installés dans `.claude/agents/` par `scripts/sources.txt` + `sync.sh`) |

## Compétences
| Usage | Compétences |
|---|---|
| Idées et specs | `product-brainstorming`, `before-you-build`, `write-spec` |
| Feuille de route et suivi | `roadmap-update`, `task-management` (fichier `TASKS.md`), `memory-management`, `project-artifact` (page d'avancement du projet, officiel Anthropic) |
| Retours et mesures | `synthesize-research`, `metrics-review` |
| Données | `explore-data`, `analyze`, `statistical-analysis`, `validate-data`, `build-dashboard` |
| Finance | `risk-metrics-calculation` (volatilité, Sharpe, perte maximale d'un portefeuille) |
| Méthodes de travail de Claude | `claude-automation-recommender` (propose des automatisations pour un dépôt, officiel Anthropic), `session-report` (rapport de consommation de tokens, officiel Anthropic), `/handoff` (passation entre conversations), `/to-questionnaire` (questionnaire à faire remplir) |

## Sous-agents
`product-manager`, `product-sprint-prioritizer`, `product-feedback-synthesizer`, `product-behavioral-nudge-engine` (habitudes, motivation), `project-manager-senior`, `project-management-experiment-tracker`.

## Agents maison
| Agent | Rôle |
|---|---|
| `verificateur-livraison` | Avant chaque PR d'une appli : test dans un vrai navigateur (téléphone et ordinateur, parcours, données, export/import), verdict PRÊT / PAS PRÊT avec preuves |
| `auditeur-securite-appli` | Audit en lecture seule d'une appli HTML : secrets, données perso, bibliothèques CDN, injections, import JSON, stockage local |

## Experts métier
| Domaine | Sous-agents |
|---|---|
| Finance | `finance-financial-analyst`, `finance-fpa-analyst` (budget, écarts, prévisions), `finance-investment-researcher`, `finance-tax-strategist` |
| Crédit / immobilier | `loan-officer-assistant`, `real-estate-buyer-seller` |
| Santé | `healthcare-clinical-evidence-agent` (niveau de preuve des affirmations santé ; à combiner avec le connecteur PubMed) |

> Ces agents sont écrits pour le contexte américain : appliquer la réglementation et la fiscalité **françaises**, et vérifier tout chiffre réglementaire.

## Sécurité
Chaque source a été vérifiée avant ajout (octobre 2026) : licence libre (MIT, Apache 2.0, domaine public), auteur identifié, projet actif.
Le code exécutable a été relu : pas de lecture de secrets, pas de consignes cachées, connexions réseau limitées à des CDN connus et à des banques d'images publiques.
Règle pour toute nouvelle source : même vérification avant de l'ajouter à `scripts/sources.txt`.

## Mise à jour
`bash scripts/sync.sh` puis commit. Ne pas écraser `.claude/CONNECTORS.md` (non synchronisé).

## Environnement cloud
- `environnement/script-demarrage-AntoCala.sh` : copie de référence du script de démarrage (« Script de configuration ») de l'environnement **AntoCala** (version 2). Il installe Design, Dev, Pilotage et Creatif dans `~/.claude/`. L'environnement **met en cache** son résultat : il ne le relance que si le texte du script change.
- `.claude/hooks/outils-demarrage.sh` : routine lancée au début de **chaque** conversation cloud (déclarée dans `.claude/settings.json`). Elle récupère la dernière version des 4 boîtes, pour que les mises à jour du lundi arrivent sans toucher au script de démarrage. Écrite à la main par Antoine : ne la modifier qu'avec son accord.

## Consignes globales (`.claude/CLAUDE.md`)
Fiche recopiée par le script de démarrage dans `~/.claude/CLAUDE.md` : Claude la lit au début de **chaque** conversation AntoCala.
Elle décrit l'organisation, le démarrage d'un projet, le déroulé de travail, la façon de s'adresser à Antoine et les règles de sécurité.
Écrite à la main (non synchronisée) : ne la modifier qu'avec l'accord d'Antoine, et la garder courte.

## Autorisations (`.claude/settings.json`)
Ce fichier est recopié par le script de démarrage dans `~/.claude/settings.json` de **toutes** les conversations AntoCala.
Il déclare la routine de démarrage (`hooks` → `SessionStart`), les garde-fous automatiques (`hooks` → `PreToolUse`, script `.claude/hooks/garde-fous.sh` : pas de modification à la main des copies d'outils, pas de clé, IBAN, téléphone ou e-mail personnel envoyé vers une boîte publique) et autorise uniquement les scripts de mise à jour des boîtes (`scripts/sync.sh` de Design, Dev, Pilotage, Creatif et `scripts/maj-outils.sh` de Modele-Projet), lancés à leur emplacement habituel, pour que la mise à jour du lundi ne soit pas bloquée.
N'y ajouter que des autorisations précises et sans risque : elles s'appliquent partout.
