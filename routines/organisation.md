# Routine : Organisation du samedi

But : améliorer chaque semaine l'organisation d'ensemble : dépôts et projets GitHub, conversations et sections de la barre latérale, automatisations, coût en tokens. Lis d'abord `routines/commun.md`.

0. **Ordre du jour** (demande d'Antoine du 30/10/26) : lis `ordre-du-jour.md` du dépôt privé Suivi (add_repo accès push, clone profondeur 1). Traite d'abord les points prévus pour ce jour : ce sont des demandes d'Antoine. Puis déplace-les dans « Traités » avec la date et une ligne de résultat (push direct sur main). Fichier absent ou rien pour ce jour : passe à la suite.
1. **Cases cochées** : dans la collection `choix`, pour chaque document `origine: organisation` au statut `coche` :
   - ce que Claude peut faire, fais-le : fiche ou routines par PR brouillon ; conversations (créer, renommer, archiver une conversation terminée) ; tâches programmées ;
   - ce qui demande Antoine (créer un dépôt, régler GitHub ou claude.ai, ranger une conversation dans une section) : donne les étapes complètes dans « 🙋 Besoin de toi ».
   Puis passe le document en `fait` (ou `echec` avec la raison dans `note`).
2. **Observation** : la fiche, `routines/`, `list_repos`, `list_sessions` (hors archivées), `list_triggers`, les comptes rendus de la semaine dans Suivi, les PR ouvertes de tous les dépôts.
3. **Propositions** : 5 au plus, classées par intérêt, en documents `choix` (`origine: organisation`, statut `propose`) avec avantages et inconvénients. Exemples : dépôt à créer, regrouper ou archiver ; conversation à créer, fusionner ou archiver ; section à créer ; automatisation à ajouter ou supprimer ; économie de tokens. Ne repropose jamais un élément refusé. Si rien ne mérite d'être changé, n'ajoute rien.
4. **Rangement automatique** (décision d'Antoine du 29/10/26) : archive (`archive_session`) chaque sous-conversation « <Projet> — <phase> » terminée : elle a envoyé son résumé au pivot, sa dernière PR est fusionnée ou fermée, et rien ne s'y est passé depuis 3 jours. Jamais un pivot, Template, Cadrage ni une conversation automatique. Liste les conversations archivées dans le compte rendu ; si l'archivage est refusé, donne la liste à Antoine.
5. **Fiche « Atelier Claude Code »** : si la fiche globale ou les routines ont changé dans la semaine, mets à jour la fiche épinglée (https://claude.ai/artifact/DTHfy259ZhFDpJnLRk3xkN : Artifact `read` puis publication à la même adresse) pour qu'elle reste juste.
6. **Interdit sans case cochée** : renommer ou créer une conversation, ou changer une tâche programmée.
7. **Compte rendu** : « Fait cette semaine », « Nouvelles propositions » (avec le lien de la Boîte à choix), « 🙋 Besoin de toi ».
