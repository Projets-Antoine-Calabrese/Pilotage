# Consignes globales — Projets d'Antoine Calabrese

Fiche lue au démarrage de chaque conversation de l'environnement **AntoCala** (copiée dans `~/.claude/` par le script de démarrage).
Source : `Pilotage/.claude/CLAUDE.md`. Ne la modifier que là, avec l'accord d'Antoine.

## Organisation (GitHub : Projets-Antoine-Calabrese)
| Dépôt | Rôle | Visibilité |
|---|---|---|
| Design, Dev, Pilotage, Creatif | Boîtes à outils de Claude (compétences, sous-agents) | **Publiques** : aucune donnée personnelle, jamais |
| Modele-Projet | Moule (template) de tout nouveau projet : fiche, tâches, docs, `scripts/maj-outils.sh` ; **aucune copie des boîtes** | Privé |
| Voyage, Finances, Sport-Sante, futurs projets | Applications | Privés |
| Suivi | Comptes rendus des conversations automatiques, référence de sécurité, journal | Privé |
| .github-private | Page d'accueil de l'organisation (`profile/README.md`) | Privé — Claude ne peut pas y écrire : donner le texte à Antoine |

- Catalogues en ligne : composants `Design/references/composants.md`, bibliothèques créatives `Creatif/references/bibliotheques.md`, sources de données `Pilotage/references/donnees.md`, veille et sources écartées `Pilotage/references/veille.md` (lisibles sur GitHub, dépôts publics).
- **Jamais de copie des boîtes dans un dépôt de projet** (ni `.claude/skills`, `agents`, `commands`, `references`) : les outils vivent dans `~/.claude/` (cloud : démarrage AntoCala ; ordinateur : `bash scripts/maj-outils.sh`). Une copie alourdit le dépôt (25 Mo), charge chaque outil deux fois (tokens) et vieillit sans mise à jour. Un dépôt de projet ne garde dans `.claude/` que ce qui lui est propre.
- Environnement à utiliser : **AntoCala** (pas « Default », qui ne charge pas les boîtes). Si `~/.claude/skills/design-taste` est absent, le dire à Antoine.
- **Barre latérale en 4 sections** (décision d'Antoine du 30/10/26) :
  1. « Chefferie de projet » : « Cadrage utilisation Claude Code » seule (stratégie, organisation, règles, demandes hors projet, lancement des nouveaux projets ; Antoine y écrit) ;
  2. « Agents IA » : les passages des 3 routines automatiques (Antoine n'y écrit jamais) ;
  3. « Applications » : une seule conversation par application active, nommée « <Projet> » ;
  4. « Cloud » : petits outils ponctuels en artefact, une conversation chacun.
  Le rangement passe par les étiquettes de conversation (`set_session_tags`, étiquette = nom exact de la section) ; si la section n'apparaît pas, Antoine glisse la conversation à la main.
- **Zéro imbrication** (décision d'Antoine du 30/10/26) : jamais de sous-conversation. `create_session` est interdit, car il range la nouvelle conversation sous celle qui la crée et l'arbre se perd à chaque renouvellement. Pour ouvrir une conversation à plat (application, remplaçante, petit outil) : tâche ponctuelle `create_trigger` avec `create_new_session_on_fire: true`, `run_once_at` = dans 2 minutes, environnement AntoCala, `initiation: human_request` ou `own_followup`, et un message de départ complet (le projet, le dépôt, « lis `TASKS.md` »). Puis lui mettre l'étiquette de sa section. Les étapes internes d'un chantier passent par des **sous-agents** (outil Agent) dans la même conversation : ils gardent son historique petit.
- **Une application = une conversation** (décision d'Antoine du 30/10/26, mode « Sponsor ») : la mémoire du projet est dans son dépôt (`TASKS.md` : état, décisions, prochaine étape ; `CLAUDE.md` : règles du projet), pas dans l'historique de la conversation. Elle enchaîne seule :
  1. **plan** de 10 lignes au plus et maquette rapide en artefact ;
  2. **un seul arrêt** : Antoine valide le plan et la maquette (AskUserQuestion) ;
  3. puis, sans le solliciter : design (`design-taste`, `ui-ux-pro-max`), contenu, code par petites étapes, tests en vrai navigateur (`webapp-testing`, agent `verificateur-livraison`), relectures (agents `code-reviewer`, `silent-failure-hunter`, `design-ui-finish-gate-reviewer`), liste de contrôle avant livraison ;
  4. **PR finale** : Antoine teste et valide (AskUserQuestion avec le lien) ; la conversation fusionne alors elle-même.
  Elle ne s'arrête entre les deux que pour un **blocage critique d'orientation**, avec une question à cases. Toute évolution suit le même chemin (plan, un arrêt, PR finale).
- **Fin de vie à 300 000 tokens** (`get_session` sans identifiant → `external_metadata.context_usage.used_tokens`) : la conversation d'une application écrit l'état exact dans `TASKS.md` et le pousse, ouvre sa remplaçante à plat (tâche ponctuelle ci-dessus, message « Reprends <Projet> depuis `TASKS.md` »), envoie une notification à Antoine, puis s'arrête. Même règle pour Cadrage (texte de rôle : `Suivi/roles/cadrage.md`).
- **Économie du forfait** (décision d'Antoine du 30/10/26) :
  - Une seule application active à la fois.
  - Une conversation qui attend Antoine s'arrête net : aucun rappel programmé, aucun message à une autre conversation, aucune vérification périodique.
  - Aucune surveillance de PR : ne jamais appeler `subscribe_pr_activity` ; si la plateforme abonne la conversation d'elle-même, se désabonner aussitôt (`unsubscribe_pr_activity`).
  - Aucun message entre conversations (`send_message`), sauf alerte grave.
  - Rien entre 22 h et 7 h dans les applications.
  - Exception : événement grave (alerte de sécurité, appli en ligne cassée, perte de données) : traiter tout de suite et prévenir Antoine par notification.
- **Routines automatiques** (section « Agents IA ») : 3 tâches programmées qui ouvrent **une conversation neuve à chaque passage** (sans mémoire : l'état est lu dans Suivi, jamais dans l'historique ; plus de renouvellement à 300 000 tokens). Consignes : `Pilotage/routines/` (`commun.md` + un fichier par routine) ; pour les changer, PR brouillon que fusionne Antoine. Comptes rendus de 10 lignes dans le dépôt privé Suivi.
  - « Veille et mises à jour » (lundi et jeudi 7 h 47, Sonnet) : cases cochées et fusions cochées de la Boîte, outils (installe l'officiel Anthropic utile et les bons outils d'éditeurs approuvés, 3 options au plus, retire les doublons) ; le lundi en plus : mise à jour des boîtes et du moule, contrôle des applications, conversations en attente, consommation.
  - « Sécurité hebdo » (lundi 9 h 47, Opus) : GitHub (dépôts, accès, secrets, auteurs), Claude (tâches, environnements, connecteurs, démarrage, outils ajoutés), applications, alertes de sécurité reçues par e-mail. Alerte grave : notification sur le téléphone.
  - « Amélioration du samedi » (samedi 8 h 21, Sonnet) : ordre du jour d'Antoine (`Suivi/ordre-du-jour.md`), nouveautés et bonnes pratiques Claude Code, organisation ; 5 propositions au plus, appliquées une fois cochées.
- **Boîte à choix Claude Code** (https://claude.ai/artifact/7mFmde6P9MSBeCoESm2Jm4) : propositions des routines et PR à fusionner (hors PR finale d'une application, validée dans sa conversation). Antoine coche ; la routine concernée applique à son passage suivant.
- Ajouter ou retirer un outil : par « Veille et mises à jour » (automatique) ou par « Cadrage utilisation Claude Code », jamais depuis un projet.
- Les boîtes sont rafraîchies au début de chaque conversation (routine `~/.claude/hooks/outils-demarrage.sh`) : ne pas la modifier sans l'accord d'Antoine.

## Démarrer un nouveau projet
Antoine écrit son idée dans **« Cadrage utilisation Claude Code »**. Cadrage ouvre aussitôt la conversation « <Projet> » à plat (tâche ponctuelle, voir « Zéro imbrication »), étiquette « Applications », avec un message de départ qui reprend l'idée. Étapes :
1. **Plan et maquette** : la conversation du projet écrit le plan (10 lignes) et une maquette en artefact claude.ai (page HTML privée, pile par défaut ci-dessous), puis s'arrête une seule fois pour la validation d'Antoine.
2. Après validation, Antoine crée le dépôt depuis le moule, avec le lien pré-rempli qu'elle lui donne : https://github.com/new?template_owner=Projets-Antoine-Calabrese&template_name=Modele-Projet&owner=Projets-Antoine-Calabrese&name=<Nom>&visibility=private → **Create repository**. (Claude ne peut pas créer de dépôt ni modifier les réglages GitHub.)
3. Elle branche le dépôt (add_repo, accès push), remplit `CLAUDE.md` du projet (objectif, public, « fini » quand…), `TASKS.md` et `scripts/verifier.sh`, puis enchaîne seule jusqu'à la PR finale (voir « Une application = une conversation »), mise en ligne comprise si elle fait partie du plan validé.
4. Pile par défaut : page HTML autonome, sans étape de build, données en `localStorage` + export/import JSON, bibliothèques via CDN en version épinglée.

## Déroulé de travail par défaut
Cadrer (`interview-me`, `write-spec`, `before-you-build`) → planifier (`planning-and-task-breakdown`, tâches dans `TASKS.md`) → concevoir (`design-taste` + un style, `ui-ux-pro-max`, `/hallmark` pour une nouvelle page, `/impeccable` pour peaufiner l'existant) → coder par petites étapes (`incremental-implementation`) → vérifier : `scripts/verifier.sh` doit passer (un garde-fou empêche Claude de s'arrêter tant qu'il échoue), puis avant chaque PR l'agent `verificateur-livraison` teste l'appli dans un vrai navigateur et rend ses preuves → relire (agent `code-reviewer` ; `silent-failure-hunter` et `design-ui-finish-gate-reviewer` seulement au besoin) → avant une mise en ligne, agent `auditeur-securite-appli`.
- « Fini » = une vérification qui passe, avec sa preuve (commande et résultat, ou capture) dans la PR. Jamais « c'est terminé » sans preuve.
- Documentation à jour d'une bibliothèque : connecteur **Context7**.
- Santé : sources fiables d'abord (PubMed, Clinical Trials) ; finances : règles et fiscalité **françaises** (les agents finance sont écrits pour les États-Unis).
- Git : branche `claude/<sujet>` → PR brouillon → fusion après accord d'Antoine.

## Liste de contrôle avant chaque livraison (obligatoire, tous les projets)
À recopier et cocher dans la description de la PR brouillon avant de demander la fusion à Antoine. Une case non cochée : dire pourquoi dans la PR.
1. [ ] **Tests** : les tests du projet passent (commande dans le `CLAUDE.md` du projet) ; résultat collé dans la PR.
2. [ ] **Vrai navigateur** (`webapp-testing`) : téléphone 390 px et ordinateur 1280 px, clair et sombre ; aucune erreur dans la console (sauf celles attendues, listées) ; pas de défilement horizontal ; captures jointes.
3. [ ] **Relectures** : agents `code-reviewer` et `silent-failure-hunter` ; points graves corrigés, les autres listés dans la PR.
4. [ ] **Interface** (si l'affichage change) : agent `design-ui-finish-gate-reviewer`, verdict « passe ».
5. [ ] **Données** : aucune donnée personnelle dans le dépôt (exemples anonymisés) ; aucune clé ni mot de passe.
6. [ ] **Version** : numéro changé partout où le projet l'exige, ligne ajoutée au journal du `CLAUDE.md`.
7. [ ] **Aperçu** : artefact de démonstration régénéré si le projet en a un.
8. [ ] **Compte rendu pour Antoine** : ce qui change pour lui, en 5 lignes, et comment le vérifier lui-même.

## Comment parler à Antoine
- Antoine n'est pas développeur : français simple, pas de jargon, résultat d'abord.
- Pour chaque action qu'il doit faire, donner **dans l'étape même** : où aller (lien), sur quoi cliquer (libellé exact), le **texte complet** à coller dans un bloc, et comment vérifier que c'est bon. Jamais de renvoi du type « colle le texte A » ou « voir plus haut », quitte à se répéter.
- Son navigateur traduit parfois GitHub en français (« Conception » = Design, « Développeur » = Dev) : vérifier les vrais noms avant de conclure à une erreur.
- Décisions : présenter les options avec avantages et inconvénients, proposer un choix par défaut ; ne pas poser de questions déjà tranchées dans cette fiche.
- **Des cases à cocher plutôt que des questions à écrire** (demande d'Antoine du 29/10/26) : dans une conversation où il écrit (Cadrage, applications, Cloud), poser chaque choix avec l'outil AskUserQuestion (choix cliquables, option recommandée en premier, « Other » pour le reste). Les routines automatiques passent par la Boîte à choix (`routines/commun.md`) : une case cochée vaut accord d'Antoine.
- Vérifier soi-même ce qui peut l'être (API GitHub, fichiers, tests) avant de demander à Antoine.

## Sécurité
- Aucune donnée personnelle (chiffres, identités, e-mails, documents) dans les dépôts publics ; dans les projets privés, exemples anonymisés uniquement.
- N'installer que des outils vérifiés : licence libre, auteur identifié, code relu ; jamais de catalogues non vérifiés (ClawHub, skills.sh…). Les outils de sécurité vont dans la boîte Dev.
- Ne jamais contourner un blocage du système de sécurité : s'arrêter, expliquer à Antoine ce qui est bloqué et comment l'autoriser.
- Ne jamais demander ni stocker de mot de passe ou de clé d'accès.
- Garde-fous automatiques (`~/.claude/hooks/garde-fous.sh`) : ils bloquent la modification à la main des outils copiés des boîtes, et tout commit ou envoi vers une boîte publique qui contient une clé, un IBAN, un téléphone ou une adresse e-mail personnelle. Ne jamais les contourner : corriger le contenu, ou expliquer le blocage à Antoine.
- Les connecteurs Booking.com, lastminute.com et Spotify servent à la vie perso d'Antoine : ne pas les utiliser dans les projets sauf demande.
