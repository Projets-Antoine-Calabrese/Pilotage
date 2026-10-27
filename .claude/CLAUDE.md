# Consignes globales — Projets d'Antoine Calabrese

Fiche lue au démarrage de chaque conversation de l'environnement **AntoCala** (copiée dans `~/.claude/` par le script de démarrage).
Source : `Pilotage/.claude/CLAUDE.md`. Ne la modifier que là, avec l'accord d'Antoine.

## Organisation (GitHub : Projets-Antoine-Calabrese)
| Dépôt | Rôle | Visibilité |
|---|---|---|
| Design, Dev, Pilotage, Creatif | Boîtes à outils de Claude (compétences, sous-agents) | **Publiques** : aucune donnée personnelle, jamais |
| Modele-Projet | Moule (template) de tout nouveau projet | Privé |
| Voyage, Finances, Sport-Sante, futurs projets | Applications | Privés |
| .github-private | Page d'accueil de l'organisation (`profile/README.md`) | Privé — Claude ne peut pas y écrire : donner le texte à Antoine |

- Catalogues en ligne : composants `Design/references/composants.md`, bibliothèques créatives `Creatif/references/bibliotheques.md`, sources de données `Pilotage/references/donnees.md`, veille et sources écartées `Pilotage/references/veille.md` (lisibles sur GitHub, dépôts publics).
- Environnement à utiliser : **AntoCala** (pas « Default », qui ne charge pas les boîtes). Si `~/.claude/skills/design-taste` est absent, le dire à Antoine.
- Une conversation par projet. Rangement dans la barre latérale (les **sections** sont créées et remplies par Antoine ; Claude ne peut pas y ranger une conversation, et la barre n'affiche pas l'imbrication) :
  - section « Gestion Claude Code » : « Cadrage utilisation Claude Code » (réglages d'ensemble) et « Mise à jour et amélioration hebdo » (maintenance du lundi) ;
  - section « Applications » : « Template des nouveaux projets » (lanceur), puis chaque application (pivot) et ses sous-conversations « <Projet> — <chantier> ».
- Liens entre conversations : Template crée la conversation pivot de chaque nouvelle application ; le pivot crée ses sous-conversations. (Exception : le pivot « Voyage » a été créé par « Cadrage utilisation Claude Code ».) Après chaque création, rappeler à Antoine de glisser la nouvelle conversation dans la section « Applications ».
- **Économie de tokens (tous les projets)** : la conversation d'un projet est un *pivot* léger. Pour chaque chantier (design, pilotage, mise en ligne, amélioration, bugs…), elle crée **au moment où le chantier commence** (jamais d'avance : chaque démarrage coûte des tokens) une sous-conversation « <Projet> — <chantier> » (create_session, même dépôt, environnement AntoCala) avec une passation de 10 lignes maximum. La sous-conversation travaille sur sa propre branche, envoie un résumé de 5 lignes au pivot (send_message « @parent ») en fin de chantier, puis attend. Une conversation qui dépasse environ 300 000 tokens doit proposer à Antoine de repartir dans une conversation neuve.
- Conversation « Mise à jour et amélioration hebdo » : chaque lundi 6 h 47, met à jour les boîtes, propose les nouveautés, vérifie la sécurité et les bugs de chaque application (corrections uniquement en PR brouillon, à valider par Antoine) et signale les conversations en attente. Pour ajouter ou retirer un outil, passer par elle (ou par la conversation « Cadrage utilisation Claude Code »), pas depuis un projet.
- Les boîtes sont rafraîchies au début de chaque conversation (routine `~/.claude/hooks/outils-demarrage.sh`) : ne pas la modifier sans l'accord d'Antoine.

## Démarrer un nouveau projet
Porte d'entrée : la conversation **« Template des nouveaux projets »** (section « Gestion Claude Code »). Antoine y écrit son idée ; elle lui donne le lien GitHub pré-rempli, puis crée la conversation pivot du projet, déjà branchée au dépôt, qui créera ensuite ses sous-conversations au fil des chantiers. Si Antoine demande un nouveau projet ailleurs, l'orienter vers elle. Étapes qu'elle applique :
1. Antoine crée le dépôt depuis le moule : Modele-Projet → **Use this template** → **Create a new repository** → nom → **Private** → **Create repository**. (Claude ne peut pas créer de dépôt ni modifier les réglages GitHub : description, visibilité, case « Template ».)
2. Claude branche le dépôt dans la conversation, puis remplit `CLAUDE.md` du projet avec Antoine (objectif, public, « fini » quand…).
3. Pile par défaut : page HTML autonome, sans étape de build, données en `localStorage` + export/import JSON, bibliothèques via CDN en version épinglée.

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
- N'installer que des outils vérifiés : licence libre, auteur identifié, code relu ; jamais de catalogues non vérifiés (ClawHub, skills.sh…).
- Ne jamais contourner un blocage du système de sécurité : s'arrêter, expliquer à Antoine ce qui est bloqué et comment l'autoriser.
- Ne jamais demander ni stocker de mot de passe ou de clé d'accès.
- Les connecteurs Booking.com, lastminute.com et Spotify servent à la vie perso d'Antoine : ne pas les utiliser dans les projets sauf demande.
