# lora169

Carte d'émission/réception LoRa autonome sur la bande 169,4–169,475 MHz
(ARCEP 2007-0689, harmonisée CE 2005/928), alimentée et programmée en USB-C.

## Hardware

- MCU : Seeed XIAO ESP32-S3
- Radio : Ebyte E22-170M30S (SX1262, IPEX)
- Antenne : pigtail U.FL → SMA femelle bulkhead, fouet 169 MHz
- Boîtier : Hammond 1455 ou impression 3D

## État du projet

Phase 0 — schéma KiCad en cours, librairies des modules en place.

## Structure du dépôt

```
docs/datasheets/        Datasheets PDF (E22-170M30S, SX1262, AN Semtech)
hardware/               Projet KiCad principal (carte mère)
hardware/libs/seeed/    Symbole + empreintes XIAO ESP32-S3 (vendorisés)
hardware/libs/ebyte/    Symbole + empreinte E22-170M30S (vendorisés)
hardware/breakout-e22/  Carte fille adaptatrice E22 SMD vers DIP enfichable
```

Chaque lib vendorisée et le breakout ont leur propre `README.md` qui
documente la source upstream et les éventuelles modifications appliquées.

Le breakout E22 est une **adaptation du design open hardware de
[NanoVHF/Meshtastic-DIY](https://github.com/NanoVHF/Meshtastic-DIY)**
(sous-dossier `PCB/ESP-32-devkit_EBYTE-E22/EBYTE-E22-adapter-board/`,
format Eagle 9.6.2). Il rend le module E22 démontable, permettant de
changer de fréquence (170 / 400 / 900 MHz) sans modifier la carte mère.
Voir `hardware/breakout-e22/README.md` pour la note sur la licence
upstream non déclarée et les étapes de conversion vers KiCad.

## Installation de KiCad (Debian 13 / Trixie)

KiCad 9 est dans les dépôts officiels Debian 13 :

```bash
sudo apt update
sudo apt install kicad kicad-libraries kicad-symbols kicad-footprints kicad-packages3d
```

Vérification :

```bash
kicad-cli --version
```

## Ouvrir le projet

Ouvre `hardware/lora169.kicad_pro` dans KiCad. Les librairies spécifiques
au projet (`Seeed_XIAO`, `Ebyte_E22`) sont déjà déclarées dans
`hardware/sym-lib-table` et `hardware/fp-lib-table` via la variable
`${KIPRJMOD}` — rien à reconfigurer manuellement après un clone.

## Journal des commandes

| Date       | Composant                          | Qté | Source     | Prix    |
|------------|------------------------------------|-----|------------|---------|
| 2026-05-01 | Seeed Studio XIAO ESP32-S3         | 2   | AliExpress | 19,03 € |
| 2026-05-01 | Ebyte E22-170M30S                  | 2   | AliExpress | 17,18 € |
