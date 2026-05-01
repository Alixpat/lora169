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
hardware/               Projet KiCad (.kicad_pro, .kicad_sch, .kicad_pcb)
hardware/libs/seeed/    Symbole + empreintes XIAO ESP32-S3 (vendorisés)
hardware/libs/ebyte/    Symbole + empreinte E22-170M30S (vendorisés)
```

Chaque lib vendorisée a son `README.md` qui documente la source upstream
et les éventuelles modifications appliquées.

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
