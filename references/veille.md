# Veille — où trouver de nouveaux outils

| Source | Quoi |
|---|---|
| [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) | Catalogue officiel (~315 plugins) — à privilégier |
| [anthropics/skills](https://github.com/anthropics/skills) | Compétences officielles Anthropic |
| [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | Liste communautaire d'outils Claude Code |
| [ComposioHQ/awesome-claude-skills](https://github.com/ComposioHQ/awesome-claude-skills) | Liste communautaire de compétences |
| [luongnv89/claude-howto](https://github.com/luongnv89/claude-howto) | Guide illustré pour apprendre Claude Code |

## Connecteurs claude.ai à envisager
| Connecteur | Intérêt |
|---|---|
| data.gouv.fr (`https://mcp.data.gouv.fr/mcp`) | Données publiques françaises |
| Context7 (Upstash) | Documentation à jour des bibliothèques |
| Figma, Canva, Notion | Seulement si un compte est utilisé |

## Sources écartées
| Dépôt | Raison |
|---|---|
| superdesigndev/superdesign | Plus maintenu, licence GPL |
| marvkr/better-design | Dépend d'un service externe et d'un compte |
| anthropics/knowledge-work-plugins (design, finance d'entreprise, ventes, RH…) | Doublons ou comptabilité d'entreprise |
| affaan-m/everything-claude-code | 1 062 compétences, 110 Mo |
| JuliusBrussee/caveman | Réponses en style télégraphique |
| EveryInc/compound-engineering-plugin, VoltAgent/awesome-claude-code-subagents | Doublons |
| vercel-labs/agent-skills (web-design-guidelines) | Télécharge ses règles sur Internet à chaque usage |
| remotion-dev/skills, ui-layouts/cursify | Pas de licence déclarée |
| makecindy/cindy | Agent concurrent, pas un outil pour Claude |
| Catalogues non vérifiés (ClawHub, skills.sh…) | Taux élevé de compétences malveillantes signalé par Snyk (2026) |
| anthropics/skills (web-artifacts-builder) | Installe des paquets npm et une archive opaque (.tar.gz) ; pile React/Vite inutile pour nos pages HTML autonomes (écarté le 26/10/26) |
| anthropics/skills (discernment-nudge, academy-guide) | Ajoutent des questions ou des liens de formation à chaque réponse : contraire au besoin de réponses brèves (26/10/26) |
| greensock/gsap-skills (gsap-react) | Nos projets n'utilisent pas React (26/10/26) |
| vercel-labs/agent-skills (writing-guidelines, react-view-transitions) | Doublon d'avoid-ai-writing / spécifique React (26/10/26) |
| anthropics/claude-plugins-official (security-guidance) | Un appel supplémentaire au modèle à chaque réponse : coûteux, redondant avec claude-security (veille du 27/10/26) |
| kenryu42/claude-code-safety-net | Doublon partiel du mode automatique ; paquet npm |
| gstack | Lourd, nombreux doublons |
| grill-me | Doublon d'interview-me |
| Playwright MCP | Doublon de webapp-testing |
| excalidraw-diagram-skill, doc-coauthoring | Pas de licence déclarée |
| second-opinion | Nécessite Codex ou Gemini |
| ralph-loop | Boucles coûteuses en tokens |
| Serena | Pensé pour de gros projets de code |
| claude-code-ui-ux-skill | Doublon d'ui-ux-pro-max |
| anthropics/claude-plugins-official (receipts) | Doublon de session-report, installé le 28/10/26 (veille du 28/10/26) |
| anthropics/claude-plugins-official (hookify) | Installe des hooks : contrôle raté (veille du 28/10/26) |
| anthropics/claude-plugins-official (code-modernization) | Pensé pour de vieux logiciels d'entreprise ; hooks et télémétrie (veille du 28/10/26) |
| anthropics/claude-plugins-official (commit-commands) | Doublon de ce que Claude Code fait déjà seul (veille du 28/10/26) |
| anthropics/claude-plugins-official (cwc-makers, mcp-tunnels) | Matériel ou serveurs qu'Antoine n'utilise pas (veille du 28/10/26) |
| trailofbits/skills (supply-chain-risk-auditor) | Ne lit que les fichiers de paquets ; nos applis chargent leurs bibliothèques par CDN (veille du 29/10/26) |
| ibelick/ui-skills (create-design-md) | Lance `npx @google/design.md` sans version fixée à chaque usage (veille du 29/10/26) |
| anthropics/skills (brand-guidelines, internal-comms, slack-gif-creator) | Marque Anthropic, communication d'entreprise, Slack : hors de nos usages (veille du 29/10/26) |
| anthropics/skills (pdf, docx, xlsx, pptx, skill-creator, claude-api) | Déjà fournis d'office dans Claude Code (veille du 29/10/26) |
| anthropics/claude-plugins-official (agent-sdk-dev, mcp-server-dev, plugin-dev, *-lsp, math-*, *-output-style) | Développement d'agents ou de plugins, langages compilés, mathématiques ou styles de réponse : hors de nos usages (veille du 29/10/26) |
| t3dotgg/tstack | S'appuie sur Codex (council, full-send) ; le reste double le suivi de PR déjà fait par Claude Code (veille du 30/10/26) |
| mattpocock/skills (implement-spec) | Doublon de spec-driven-development et incremental-implementation (veille du 30/10/26) |
| abdiraimov-otabek/dashboard-design-skill | Doublon de kpi-dashboard-design, build-dashboard et dataviz ; pensé pour Tailwind (veille du 30/10/26) |
| OthmanAdi/planning-with-files, thedotmack/claude-mem | Installent des hooks qui réinjectent du contexte à chaque tour : contrôle raté (veille du 30/10/26) |
| anthropics/skills (mcp-builder) | Création de serveurs MCP : hors de nos usages (veille du 30/10/26) |
