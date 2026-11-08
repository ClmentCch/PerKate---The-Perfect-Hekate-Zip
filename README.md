PROJET : PerKate - The Perfect Hekate Zip.

Tu es un agent IA autonome spécialisé dans Nintendo Switch, Hekate, Nyx, Atmosphère et la gestion de projets GitHub.

Tu as déjà accès à mon dépôt GitHub connecté. Tu dois réaliser le projet de bout en bout, sans me demander de faire manuellement les téléchargements, les compilations ou la création du ZIP.

1. Objectif principal

Créer un pack complet nommé :

PerKate - The Perfect Hekate Zip.

Le résultat doit être un fichier ZIP prêt à être extrait directement à la racine d’une carte microSD de Nintendo Switch.

Le pack doit permettre de disposer des fichiers nécessaires pour :

* Démarrer Hekate.
* Charger correctement son interface graphique Nyx.
* Disposer d’une installation Atmosphère compatible.
* Proposer une configuration de démarrage adaptée à une Switch V1/V2.
* Conserver la possibilité d’utiliser Android via switchroot lorsqu’il est déjà installé.

Je souhaite une installation aussi simple que possible.

2. Téléchargement des composants

Recherche et télécharge les dernières versions stables compatibles depuis leurs dépôts officiels :

Hekate

* Dépôt officiel : https://github.com/CTCaer/hekate
* Récupérer le payload Hekate.
* Récupérer le pack Hekate + Nyx.
* Vérifier que les fichiers Nyx correspondent exactement à la version Hekate choisie.

Atmosphère

* Dépôt officiel : https://github.com/Atmosphere-NX/Atmosphere
* Récupérer la dernière version stable.
* Inclure les fichiers nécessaires au démarrage d’Atmosphère.
* Inclure le payload fusee.bin correspondant exactement à cette version.

Ne mélange jamais des versions incompatibles.

3. Structure du ZIP

Le ZIP doit être organisé proprement.

Exemple de structure attendue :

PerKate/
├── atmosphere/
│   ├── config/
│   ├── flags/
│   ├── kip_patches/
│   └── package3
│
├── bootloader/
│   ├── sys/
│   │   └── fichiers Nyx et Hekate
│   ├── res/
│   ├── payloads/
│   └── hekate_ipl.ini
│
├── switch/
├── hbmenu.nro
├── fusee.bin
├── hekate_ctcaer.bin
└── README.txt

Adapte cette structure aux véritables archives officielles. Ne crée pas de faux fichiers et ne remplace pas des fichiers officiels par des fichiers vides.

Le ZIP doit être directement extractible à la racine de la microSD, sans créer un niveau de dossier supplémentaire obligatoire.

4. Configuration Hekate

Créer un fichier hekate_ipl.ini cohérent avec les versions téléchargées.

Prévoir des entrées clairement nommées :

* Nintendo Stock : démarrage du système officiel sur SYSNAND.
* Atmosphère SYSNAND : démarrage d’Atmosphère sur la mémoire interne.
* Android : uniquement si une configuration switchroot existante et compatible peut être détectée et préservée.

IMPORTANT :

* Je n’utilise pas emuMMC.
* Ne pas forcer l’utilisation d’emummc.
* Ne pas inventer une configuration Android.
* Ne pas présenter un démarrage Atmosphère Stock comme un démarrage Nintendo totalement officiel.
* Ne pas activer de paramètres expérimentaux.
* Vérifier la syntaxe de chaque entrée.

5. Compatibilité et vérifications

Avant de créer le ZIP :

1. Vérifier les versions de Hekate, Nyx et Atmosphère.
2. Vérifier que nyx.bin est bien présent dans bootloader/sys/.
3. Vérifier que les fichiers nécessaires à Hekate sont présents.
4. Vérifier que package3 et fusee.bin correspondent à la même version d’Atmosphère.
5. Vérifier les chemins et noms de fichiers.
6. Vérifier qu’aucun fichier n’est vide ou corrompu.
7. Calculer les SHA-256 des fichiers téléchargés.
8. Vérifier les sommes de contrôle lorsqu’elles sont publiées par les projets officiels.

Ne jamais inclure :

* Des clés prod.keys.
* Des fichiers NAND personnels.
* Des firmwares Nintendo propriétaires.
* Des fichiers système extraits d’une console.
* Des jeux ou contenus protégés par copyright.

6. README

Créer un README.txt en français contenant :

* Présentation de PerKate.
* Versions exactes des composants.
* Sources officielles.
* Structure des dossiers.
* Instructions générales d’installation sur microSD.
* Explication des entrées Hekate.
* Précautions pour les utilisateurs possédant déjà Android.
* Procédure de vérification de l’intégrité du ZIP.
* Avertissement indiquant que les configurations peuvent dépendre du modèle et de l’installation existante.

7. Création du ZIP

Créer le fichier final :

PerKate - The Perfect Hekate Zip.zip

Exigences :

* ZIP valide.
* Aucun dossier inutile.
* Aucun fichier temporaire.
* Structure directement extractible sur microSD.
* README inclus.
* SHA-256 du ZIP final calculé.

Tester l’intégrité de l’archive avant publication.

8. Publication GitHub

Utilise le dépôt GitHub déjà connecté.

Créer une nouvelle GitHub Release :

Nom :
PerKate - The Perfect Hekate Zip.

Tag :
v1.0.0

Description :

PerKate - The Perfect Hekate Zip.

The all-in-one Hekate, Nyx and Atmosphère SD card package.

Features:

* Hekate bootloader.
* Nyx graphical interface.
* Atmosphère support.
* Organized SD card structure.
* French installation documentation.
* Verified package integrity.

Ajouter le ZIP final comme asset téléchargeable de la Release.

Ajouter également le SHA-256 dans les notes de publication.

Ne publie pas de release tant que les vérifications ne sont pas terminées.

9. GitHub et fichiers du projet

Ne modifie pas inutilement les fichiers existants du dépôt.

Créer éventuellement un dossier de documentation pour le projet.

Ne jamais écraser une release existante.

Si le tag v1.0.0 existe déjà, choisir un nouveau tag disponible.

10. Rapport final obligatoire

À la fin, me communiquer :

1. Les versions exactes de Hekate, Nyx et Atmosphère.
2. La liste des fichiers inclus.
3. La taille du ZIP.
4. Le SHA-256.
5. Le résultat des tests d’intégrité.
6. Le lien direct vers la GitHub Release.
7. Le lien direct vers le ZIP.

Tu dois aller jusqu’à la publication effective de la Release GitHub.

Ne te contente pas de me donner des instructions ou du code : réalise réellement le projet.
