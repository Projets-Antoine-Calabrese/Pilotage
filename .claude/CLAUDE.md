# Consignes globales — Projets d'Antoine Calabrese

Fiche lue au démarrage de chaque conversation de l'environnement **AntoCala** (copiée dans `~/.claude/` par le script de démarrage).
Source : `Pilotage/.claude/CLAUDE.md`. Ne la modifier que là, avec l'accord d'Antoine.

## Organisation (GitHub : Projets-Antoine-Calabrese)
| Dépôt | Rôle | Visibilité |
|---|---|---|
| Design, Dev, Pilotage, Creatif | Boîtes à outils de Claude (compétences, sous-agents) | **Publiques** : aucune donnée personnelle, jamais |
| Modele-Projet | Moule (template) de tout nouveau projet | Privé |
| Voyage, Finances, Sport-Sante, futurs projets | Applications | Privés |
| Suivi | Comptes rendus des conversations automatiques, référence de sécurité, journal | Privé |
| .github-private | Page d'accueil de l'organisation (`profile/README.md`) | Privé — Claude ne peut pas y écrire : donner le texte à Antoine |

- Catalogues en ligne : composants `Design/references/composants.md`, bibliothèques créatives `Creatif/references/bibliotheques.md`, sources de données `Pilotage/references/donnees.md`, veille et sources écartées `Pilotage/references/veille.md` (lisibles sur GitHub, dépôts publics).
- Environnement à utiliser : **AntoCala** (pas « Default », qui ne charge pas les boîtes). Si `~/.claude/skills/design-taste` est absent, le dire à Antoine.
- Une conversation par projet. Rangement dans la barre latérale (les **sections** sont créées et remplies par Antoine ; Claude ne peut pas y ranger une conversation, et la barre n'affiche pas l'imbrication) :
  - section « Gestion Claude Code » : « Cadrage utilisation Claude Code » (conversation généraliste : réglages et toutes les demandes hors projet ; Antoine y écrit), puis 4 conversations **automatiques où Antoine n'écrit jamais** : « Veille GitHub quotidienne » (chaque jour 7 h 47), « Mise à jour et amélioration hebdo » (lundi 8 h 07), « Sécurité hebdo » (lundi 8 h 13), « Organisation du samedi » (samedi 8 h 21) ;
  - section « Applications » : « Template des nouveaux projets » (lanceur), puis chaque application (pivot) et ses sous-conversations « <Projet> — <chantier> ».
- Liens entre conversations : Template crée la conversation pivot de chaque nouvelle application ; le pivot crée ses sous-conversations. (Exception : le pivot « Voyage » a été créé par « Cadrage utilisation Claude Code ».) Après chaque création, rappeler à Antoine de glisser la nouvelle conversation dans la section « Applications ».
- **Économie de tokens (tous les projets)** : la conversation d'un projet est un *pivot* léger. Pour chaque chantier (design, pilotage, mise en ligne, amélioration, bugs…), elle crée **au moment où le chantier commence** (jamais d'avance : chaque démarrage coûte des tokens) une sous-conversation « <Projet> — <chantier> » (create_session, même dépôt, environnement AntoCala) avec une passation de 10 lignes maximum. La sous-conversation travaille sur sa propre branche, envoie un résumé de 5 lignes au pivot (send_message « @parent ») en fin de chantier, puis attend. Une conversation de projet qui dépasse environ 300 000 tokens doit proposer à Antoine de repartir dans une conversation neuve. « Cadrage utilisation Claude Code » et les conversations automatiques se renouvellent seules au-delà de ce seuil (`routines/commun.md`) : Antoine n'a qu'à glisser la nouvelle conversation dans sa section.
- **Conversations automatiques** : leur message programmé renvoie à leur routine, écrite dans `Pilotage/routines/` (`commun.md` + un fichier par conversation) ; pour changer une routine, PR brouillon que fusionne Antoine. Les choix d'Antoine passent par la page « Boîte à choix Claude Code » (https://claude.ai/artifact/7mFmde6P9MSBeCoESm2Jm4) : il coche, la conversation applique à son passage suivant. Comptes rendus copiés dans le dépôt privé Suivi.
  - Veille : installe les bons outils d'éditeurs déjà approuvés, met les autres en option à cocher, retire les outils en double ou abandonnés.
  - MAJ hebdo : met à jour les outils installés et le moule, corrige les bugs des applications en PR brouillon, signale les conversations en attente.
  - Sécurité hebdo : GitHub (dépôts, accès, secrets, auteurs), Claude (tâches, environnements, connecteurs, démarrage, outils ajoutés), applications, alertes de sécurité reçues par e-mail (GitHub, Google, Anthropic). Alerte grave : notification sur le téléphone.
  - Organisation du samedi : propose au plus 5 améliorations de l'organisation (dépôts, conversations, sections, automatisations, tokens), appliquées une fois cochées.
- Ajouter ou retirer un outil : par la veille (automatique) ou par « Cadrage utilisation Claude Code », jamais depuis un projet.
- Les boîtes sont rafraîchies au début de chaque conversation (routine `~/.claude/hooks/outils-demarrage.sh`) : ne pas la modifier sans l'accord d'Antoine.

## Démarrer un nouveau projet
Porte d'entrée : la conversation **« Template des nouveaux projets »** (section « Applications »), simple lanceur. Antoine y écrit son idée ; elle crée aussitôt la conversation pivot « <Projet> » (environnement AntoCala, **sans dépôt** au départ). Si Antoine demande un nouveau projet ailleurs, l'orienter vers elle. Étapes, dans le pivot :
1. **Maquette d'abord** : un artefact claude.ai (page HTML privée, pile par défaut ci-dessous), corrigé avec Antoine d'abord sur la forme (design), puis sur le fond (contenu, fonctions), jusqu'à sa validation. Moins coûteux qu'un dépôt tant que l'idée bouge.
2. Après validation, Antoine crée le dépôt depuis le moule, avec le lien pré-rempli que lui donne le pivot : Modele-Projet → **Use this template** → **Create a new repository** → nom → **Private** → **Create repository**. (Claude ne peut pas créer de dépôt ni modifier les réglages GitHub : description, visibilité, case « Template ».)
3. Le pivot branche le dépôt (add_repo, accès push), y dépose la page validée, remplit `CLAUDE.md` du projet avec Antoine (objectif, public, « fini » quand…), puis suit le déroulé de travail par défaut avec ses sous-conversations par chantier.
4. Pile par défaut : page HTML autonome, sans étape de build, données en `localStorage` + export/import JSON, bibliothèques via CDN en version épinglée.

## Déroulé de travail par défaut
Cadrer (`interview-me`, `write-spec`, `before-you-build`) → planifier (`planning-and-task-breakdown`, tâches dans `TASKS.md`) → concevoir (`design-taste` + un style, `ui-ux-pro-max`, `/hallmark` pour une nouvelle page, `/impeccable` pour peaufiner l'existant) → coder par petites étapes (`incremental-implementation`) → vérifier dans un vrai navigateur (`webapp-testing`, `verification-before-completion`) → relire (agents `code-reviewer`, `silent-failure-hunter`, `design-ui-finish-gate-reviewer`).
- Documentation à jour d'une bibliothèque : connecteur **Context7**.
- Santé : sources fiables d'abord (PubMed, Clinical Trials) ; finances : règles et fiscalité **françaises** (les agents finance sont écrits pour les États-Unis).
- Git : branche `claude/<sujet>` → PR brouillon → fusion après accord d'Antoine.

## Comment parler à Antoine
- Antoine n'est pas développeur : français simple, pas de jargon, résultat d'abord.
- Pour chaque action qu'il doit faire, donner **dans l'étape même** : où aller (lien), sur quoi cliquer (libellé exact), le **texte complet** à coller dans un bloc, et comment vérifier que c'est bon. Jamais de renvoi du type « colle le texte A » ou « voir plus haut », quitte à se répéter.
- Son navigateur traduit parfois GitHub en français (« Conception » = Design, « Développeur » = Dev) : vérifier les vrais noms avant de conclure à une erreur.
- Décisions : présenter les options avec avantages et inconvénients, proposer un choix par défaut ; ne pas poser de questions déjà tranchées dans cette fiche.
- Vérifier soi-même ce qui peut l'être (API GitHub, fichiers, tests) avant de demander à Antoine.

## Sécurité
- Aucune donnée personnelle (chiffres, identités, e-mails, documents) dans les dépôts publics ; dans les projets privés, exemples anonymisés uniquement.
- N'installer que des outils vérifiés : licence libre, auteur identifié, code relu ; jamais de catalogues non vérifiés (ClawHub, skills.sh…). Les outils de sécurité vont dans la boîte Dev.
- Ne jamais contourner un blocage du système de sécurité : s'arrêter, expliquer à Antoine ce qui est bloqué et comment l'autoriser.
- Ne jamais demander ni stocker de mot de passe ou de clé d'accès.
- Les connecteurs Booking.com, lastminute.com et Spotify servent à la vie perso d'Antoine : ne pas les utiliser dans les projets sauf demande.
