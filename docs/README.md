# PerKate - The Perfect Hekate Zip

Pack microSD prêt à l'emploi pour Nintendo Switch V1/V2 : hekate + Nyx +
Atmosphère, avec une configuration SYSNAND sans emuMMC et une documentation
française.

## Versions figées

| Composant | Version | Source |
| --- | --- | --- |
| hekate | v6.5.4 | [CTCaer/hekate](https://github.com/CTCaer/hekate/releases/tag/v6.5.4) |
| Nyx | v1.9.4 | incluse dans la release hekate v6.5.4 |
| Atmosphère | 1.12.0 | [Atmosphere-NX/Atmosphere](https://github.com/Atmosphere-NX/Atmosphere/releases/tag/1.12.0) |
| hbl / hbmenu | 2.4.5 / 3.6.1 | incluse dans la release Atmosphère 1.12.0 |

Les versions sont volontairement figées et vérifiées par SHA-256 dans
`scripts/build-perkate.sh`. Pour mettre à jour le pack, changez les versions et
les empreintes ensemble, puis rebuild : ne mélangez jamais deux versions.

## Contenu du dépôt

```
.github/workflows/release.yml   Publication automatique de la Release GitHub
docs/                           Documentation du projet et notes de release
pack/README.txt                 README.txt livré dans le ZIP
pack/hekate_ipl.ini             Configuration hekate livrée (SYSNAND, sans emuMMC)
scripts/build-perkate.sh        Build reproductible du ZIP
```

## Build local

Prérequis : `bash`, `curl`, `unzip`, `zip`, `sha256sum`.

```bash
bash scripts/build-perkate.sh
```

Le script :

1. télécharge les releases officielles épinglées ;
2. vérifie leur SHA-256 (assets GitHub officiels) ;
3. assemble l'arborescence à la racine de la carte SD ;
4. vérifie la structure, les fichiers obligatoires et la cohérence
   `package3` / `fusee.bin` / `nyx.bin` ;
5. crée `dist/PerKate - The Perfect Hekate Zip.zip` ;
6. teste l'archive (`unzip -t`) et compare une extraction complète à l'arbre
   assemblé ;
7. écrit `dist/SHA256SUMS.txt` et la somme SHA-256 du ZIP.

## Publication

Le workflow `.github/workflows/release.yml` se déclenche sur `push` vers `main`
(ou manuellement). Il :

- ne fait rien si la Release `v1.0.0` (ou son tag) existe déjà ;
- exécute le build et les vérifications ;
- crée la Release `PerKate - The Perfect Hekate Zip.` avec le tag `v1.0.0` ;
- joint le ZIP comme asset et ajoute sa taille et son SHA-256 aux notes.

Aucune Release existante n'est écrasée.

## Configuration hekate

`pack/hekate_ipl.ini` contient deux entrées SYSNAND :

- `Nintendo Stock (SYSNAND)` : `stock=1` + `emummc_force_disable=1` ;
- `Atmosphere SYSNAND` : `pkg3=atmosphere/package3` +
  `emummc_force_disable=1`.

Aucune entrée emuMMC, Android ou paramètre expérimental n'est ajouté. Le README
du ZIP explique les précautions pour une installation switchroot existante.

## Vérifications

- SHA-256 de chaque archive officielle comparé à l'empreinte publiée par GitHub.
- `nyx.bin` présent dans `bootloader/sys/` et identique à la release hekate.
- `atmosphere/package3` et `fusee.bin` issus de la même release Atmosphère ;
  `atmosphere/reboot_payload.bin` est byte-identique à `fusee.bin`.
- Aucun fichier vide, aucune clé, aucun firmware ni contenu protégé.
- ZIP testé et extraction comparée fichier par fichier.
