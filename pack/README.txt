====================================================================
 PerKate - The Perfect Hekate Zip
 Pack microSD Hekate + Nyx + Atmosphère pour Nintendo Switch
 Version du pack : 1.0.0
====================================================================

SOMMAIRE
  1. Présentation
  2. Versions exactes des composants
  3. Sources officielles et sommes de contrôle
  4. Structure du pack
  5. Installation sur la microSD
  6. Entrées Hekate (hekate_ipl.ini)
  7. Vous utilisez déjà Android (switchroot)
  8. Vérifier l'intégrité du ZIP
  9. Ce que ce pack ne contient pas
 10. Avertissements


--------------------------------------------------------------------
1. PRÉSENTATION
--------------------------------------------------------------------

PerKate - The Perfect Hekate Zip est un pack microSD prêt à l'emploi
pour Nintendo Switch V1/V2 (Erista et Mariko, injection RCM ou puce).

Il regroupe, dans une arborescence directement extractible à la racine
de la carte microSD :

  - le bootloader hekate et son interface graphique Nyx ;
  - une installation Atmosphère complète et compatible ;
  - les payloads officiels hekate et fusee.bin ;
  - une configuration de démarrage hekate_ipl.ini pour la mémoire
    interne (SYSNAND), sans emuMMC ;
  - ce README en français.

Objectif : une installation simple, propre et vérifiable, sans mélange
de versions et sans fichier inventé.


--------------------------------------------------------------------
2. VERSIONS EXACTES DES COMPOSANTS
--------------------------------------------------------------------

hekate v6.5.4
  - Payload : hekate_ctcaer_6.5.4.bin
  - bootloader/update.bin est le même binaire hekate v6.5.4
  - Dernier firmware HOS annoncé comme pris en charge par hekate :
    HOS 23.0.1 (notes de version officielles hekate v6.5.4)

Nyx v1.9.4
  - Interface graphique de hekate, version publiée avec hekate v6.5.4
  - bootloader/sys/nyx.bin, res.pak et ressources associées issus du
    pack officiel « hekate_ctcaer_6.5.4_Nyx_1.9.4.zip »
  - Nyx et hekate proviennent donc exactement de la même publication

Atmosphère 1.12.0
  - atmosphere/package3
  - fusee.bin (et atmosphere/reboot_payload.bin, binaire identique)
  - hbl (nx-hbloader) 2.4.5 et hbmenu 3.6.1, inclus dans l'archive
    officielle Atmosphère
  - switch/daybreak.nro, switch/haze.nro, switch/reboot_to_payload.nro
  - Les notes de version officielles Atmosphère 1.12.0 annoncent la
    prise en charge de HOS 23.0.0. Consultez les notes officielles
    avant toute mise à jour du firmware de la console.

Aucune version n'a été remplacée, recompilée ni modifiée : tous les
binaires proviennent des archives officielles téléchargées, et leurs
sommes SHA-256 ont été vérifiées avant création du ZIP.


--------------------------------------------------------------------
3. SOURCES OFFICIELLES ET SOMMES DE CONTRÔLE
--------------------------------------------------------------------

hekate v6.5.4
  Dépôt    : https://github.com/CTCaer/hekate
  Release  : https://github.com/CTCaer/hekate/releases/tag/v6.5.4
  Fichiers :
    hekate_ctcaer_6.5.4.bin
      SHA-256 95f6e933e32e028f3ae90f0b0857ff47800e834bdace38a0ab019d8ed35a8c24
    hekate_ctcaer_6.5.4_Nyx_1.9.4.zip
      SHA-256 a5ee4faa956f1ffe49fdd31d795be3fd556c8dffd9cbed69cec7cff92b8b43f6

Atmosphère 1.12.0
  Dépôt    : https://github.com/Atmosphere-NX/Atmosphere
  Release  : https://github.com/Atmosphere-NX/Atmosphere/releases/tag/1.12.0
  Fichiers :
    atmosphere-1.12.0-master-28d6a2e11+hbl-2.4.5+hbmenu-3.6.1.zip
      SHA-256 14451a033935962a9ed800db6918706e372de4370e8d04ea3fc9728a937249e1
    fusee.bin
      SHA-256 6559017e4df5ac418ce09fb347c32d071649f8b6d3d4bac9a874505fc8bed1bd

Vérification effectuée : ces quatre sommes correspondent aux empreintes
SHA-256 publiées par GitHub pour les assets officiels de ces releases.

Quelques empreintes utiles à l'intérieur du pack :
  atmosphere/package3
    3cc9d6ca5688e403c36974bced1089397ef8b36a4252f720207ae3d41a6eb557
  atmosphere/reboot_payload.bin = fusee.bin
    6559017e4df5ac418ce09fb347c32d071649f8b6d3d4bac9a874505fc8bed1bd
  bootloader/sys/nyx.bin
    441d4ca58099f277de76c90c172f2804e9a809ec1db44ca6a011b0a92b93a4f4
  bootloader/hekate_ipl.ini
    3923bfda8b066a0e27957ffafbcfe686dea1455e6299063207f9065052f5f8b0
  hekate_ctcaer_6.5.4.bin = bootloader/update.bin
    95f6e933e32e028f3ae90f0b0857ff47800e834bdace38a0ab019d8ed35a8c24


--------------------------------------------------------------------
4. STRUCTURE DU PACK
--------------------------------------------------------------------

Le ZIP ne contient pas de dossier « PerKate/ » supplémentaire : son
contenu s'extrait directement à la racine de la microSD.

Racine de la microSD
├── atmosphere/
│   ├── config/                        (dossier officiel, vide au départ)
│   ├── config_templates/
│   │   ├── exosphere.ini
│   │   ├── override_config.ini
│   │   ├── stratosphere.ini
│   │   └── system_settings.ini
│   ├── fatal_errors/                  (dossier officiel, vide au départ)
│   ├── flags/                         (dossier officiel, vide au départ)
│   ├── hbl.nsp
│   ├── hbl_html/
│   │   └── accessible-urls/
│   │       └── accessible-urls.txt
│   ├── kip_patches/                   (dossier officiel, vide au départ)
│   ├── package3
│   ├── reboot_payload.bin             (= fusee.bin Atmosphère 1.12.0)
│   └── stratosphere.romfs
├── bootloader/
│   ├── hekate_ipl.ini                 (configuration PerKate)
│   ├── ini/                           (dossier officiel, vide au départ)
│   ├── payloads/
│   │   └── fusee.bin                  (Atmosphère 1.12.0)
│   ├── res/
│   │   ├── icon_payload.bmp
│   │   └── icon_switch.bmp
│   ├── sys/
│   │   ├── emummc.kipm
│   │   ├── l4t/
│   │   │   ├── bpmpfw.bin
│   │   │   ├── bpmpfw_b01.bin
│   │   │   ├── mtc_tbl_b01.bin
│   │   │   ├── sc7entry.bin
│   │   │   ├── sc7exit.bin
│   │   │   └── sc7exit_b01.bin
│   │   ├── libsys_lp0.bso
│   │   ├── libsys_minerva.bso
│   │   ├── nyx.bin
│   │   ├── res.pak
│   │   └── thk.bin
│   └── update.bin                     (hekate v6.5.4)
├── switch/
│   ├── daybreak.nro
│   ├── haze.nro
│   └── reboot_to_payload.nro
├── fusee.bin                          (Atmosphère 1.12.0)
├── hbmenu.nro                         (hbmenu 3.6.1)
├── hekate_ctcaer_6.5.4.bin            (payload hekate v6.5.4)
└── README.txt

Total : 33 fichiers. Les dossiers vides (atmosphere/config, flags,
fatal_errors, kip_patches, bootloader/ini) sont ceux livrés par les
archives officielles ; Atmosphère et hekate y écrivent ensuite leurs
fichiers.


--------------------------------------------------------------------
5. INSTALLATION SUR LA MICROSD
--------------------------------------------------------------------

1. Sauvegardez votre carte microSD (en particulier bootloader/,
   atmosphere/contents/ si vous avez des sysmodules, et tout fichier
   personnel).

2. Formatez de préférence la carte en FAT32. exFAT fonctionne aussi,
   mais FAT32 est le format le plus universellement recommandé.

3. Extrayez le contenu du ZIP à la racine de la microSD. N'extrayez
   pas le ZIP dans un sous-dossier : les dossiers atmosphere/,
   bootloader/ et switch/, ainsi que hbmenu.nro et les fichiers .bin,
   doivent se trouver directement à la racine.

4. Si la carte contient déjà hekate/Atmosphère, fusionnez et remplacez
   les fichiers. Sauvegardez auparavant votre bootloader/hekate_ipl.ini
   existant si vous l'avez personnalisé (voir section 7 pour Android).

5. Démarrez hekate :
   - Switch V1 (RCM) : injectez hekate_ctcaer_6.5.4.bin avec votre
     outil habituel (TegraRcmGUI, Rekado, etc.).
   - Switch avec puce : le payload hekate est chargé par la puce.
   - Vous pouvez aussi placer hekate_ctcaer_6.5.4.bin sur la carte et
     le lancer depuis un autre payload.

6. Nyx (l'interface graphique de hekate) doit s'afficher. Le menu
   « Launch » propose les entrées décrites ci-dessous.

7. Pour Atmosphère, lancez « Atmosphere SYSNAND ». Le premier démarrage
   peut être plus long ; laissez la console terminer son boot.

Mise à jour ultérieure : remplacez le dossier bootloader/ et le dossier
atmosphere/ par les versions officielles plus récentes, puis vérifiez
que fusee.bin et package3 proviennent bien de la même version. Ne
mélangez jamais deux versions d'Atmosphère.


--------------------------------------------------------------------
6. ENTRÉES HEKATE (hekate_ipl.ini)
--------------------------------------------------------------------

Le fichier bootloader/hekate_ipl.ini fourni contient deux entrées.

[Nintendo Stock (SYSNAND)]
  pkg3=atmosphere/package3
  stock=1
  emummc_force_disable=1

  Démarre le système officiel sur la mémoire interne, en mode « stock »
  de hekate : les patches kernel et les kips CFW sont désactivés.
  emummc_force_disable=1 garantit l'usage de la SYSNAND même si une
  configuration emuMMC existait sur la carte.

  IMPORTANT : ce n'est PAS un démarrage 100 % officiel au sens Nintendo.
  hekate charge ici package3 et, selon le modèle et le firmware, peut
  utiliser exosphère/warmboot d'Atmosphère en mode stock. C'est la
  configuration la plus proche du firmware officiel proposée par hekate,
  mais elle ne doit pas être présentée comme un boot Nintendo totalement
  d'origine.

[Atmosphere SYSNAND]
  pkg3=atmosphere/package3
  emummc_force_disable=1

  Démarre Atmosphère (CFW) sur la mémoire interne. Aucune entrée emuMMC
  n'est fournie et aucun paramètre expérimental n'est activé.

Autres points :
  - Le payload fusee.bin est présent à la racine et dans
    bootloader/payloads/ : il est visible dans le menu « Payloads » de
    Nyx et peut être chaîné directement si vous le souhaitez.
  - La section [config] reprend les valeurs par défaut du modèle officiel
    hekate : autoboot désactivé, attente de 3 s au démarrage, etc.
  - Aucune entrée Android n'est créée par ce pack : voir section 7.


--------------------------------------------------------------------
7. VOUS UTILISEZ DÉJÀ ANDROID (SWITCHROOT)
--------------------------------------------------------------------

Ce pack ne contient ni Android, ni configuration Android, et il ne
détecte pas automatiquement une installation switchroot. Il n'invente
donc aucune entrée Android.

Si Android est déjà installé sur votre carte :
  - vos partitions et vos fichiers switchroot ne font pas partie de ce
    ZIP et ne sont pas modifiés par son extraction ;
  - les entrées Android générées par votre installateur switchroot
    (généralement dans bootloader/ini/, visibles dans « More configs »
    de Nyx) sont conservées tant que vous ne les supprimez pas ;
  - le fichier bootloader/hekate_ipl.ini de ce pack REMPLACE un éventuel
    fichier du même nom. Si votre installation Android y avait ajouté
    une entrée, sauvegardez d'abord votre ancien hekate_ipl.ini, puis
    recopiez votre entrée Android dans le nouveau fichier, ou gardez vos
    entrées dans bootloader/ini/.

Ne recopiez jamais une entrée Android trouvée sur Internet : elle dépend
de votre version de switchroot, de la disposition de vos partitions et
des fichiers L4T installés. Utilisez celle fournie par votre
installateur. Ne reformatez jamais la carte depuis hekate sans
sauvegarde complète.


--------------------------------------------------------------------
8. VÉRIFIER L'INTÉGRITÉ DU ZIP
--------------------------------------------------------------------

La somme SHA-256 du ZIP publié est indiquée dans les notes de la Release
GitHub « PerKate - The Perfect Hekate Zip » (tag v1.0.0) :

  https://github.com/ClmentCch/PerKate---The-Perfect-Hekate-Zip/releases/tag/v1.0.0

Calculez la somme du fichier téléchargé :

  Linux :
    sha256sum "PerKate - The Perfect Hekate Zip.zip"

  macOS :
    shasum -a 256 "PerKate - The Perfect Hekate Zip.zip"

  Windows PowerShell :
    Get-FileHash -Algorithm SHA256 "PerKate - The Perfect Hekate Zip.zip"

  Windows (invite de commandes) :
    certutil -hashfile "PerKate - The Perfect Hekate Zip.zip" SHA256

La valeur obtenue doit être identique, caractère pour caractère, à celle
publiée dans la Release.

Vous pouvez aussi tester l'archive avant extraction :

  unzip -t "PerKate - The Perfect Hekate Zip.zip"

Les empreintes des composants officiels sont listées en section 3 : vous
pouvez vérifier individuellement les fichiers extraits avec la même
méthode.


--------------------------------------------------------------------
9. CE QUE CE PACK NE CONTIENT PAS
--------------------------------------------------------------------

Volontairement exclus :
  - clés de console (prod.keys, title.keys, etc.) ;
  - sauvegardes ou dumps de NAND personnels ;
  - firmwares Nintendo propriétaires ;
  - fichiers système extraits d'une console ;
  - jeux, DLC, contenus ou thèmes protégés par copyright ;
  - sigpatches, sysmodules personnalisés et homebrews autres que ceux
    livrés officiellement par Atmosphère (hbmenu, daybreak, haze,
    reboot_to_payload) ;
  - toute configuration emuMMC, Android ou Linux inventée.

Vous devez disposer de votre propre firmware et de vos propres clés pour
les usages qui en nécessitent ; ce pack ne les fournit pas.


--------------------------------------------------------------------
10. AVERTISSEMENTS
--------------------------------------------------------------------

- Les configurations de démarrage dépendent du modèle de console
  (Erista/Mariko), du firmware installé, des fusibles grillés et de
  l'installation existante sur la carte. Testez toujours sur une
  configuration dont vous avez une sauvegarde.
- Une console modifiée peut être bloquée ou bannie par Nintendo ; vous
  restez seul responsable de l'usage de ce pack et des conséquences
  (garantie, compte Nintendo, mise à jour système).
- N'utilisez pas ce pack pour contourner la loi ou les conditions
  d'utilisation de Nintendo. Aucun contenu protégé n'est inclus.
- Les projets hekate, Nyx, Atmosphère, hbl et hbmenu sont distribués
  par leurs auteurs respectifs sous leurs licences d'origine. Ce pack
  ne fait que les assembler sans les modifier.
- Aucune garantie n'est fournie : utilisez ce pack à vos risques.

====================================================================
 PerKate - The Perfect Hekate Zip — v1.0.0
 hekate v6.5.4 / Nyx v1.9.4 / Atmosphère 1.12.0
====================================================================
