# lora169

Carte d'émission/réception LoRa autonome sur la bande 169,4–169,475 MHz
(ARCEP 2007-0689, harmonisée CE 2005/928), alimentée et programmée en USB-C.

## Hardware

- MCU : Seeed XIAO ESP32-S3
- Radio : Ebyte E22-170M30S (SX1262, IPEX)
- Antenne : pigtail U.FL → SMA femelle bulkhead, fouet 169 MHz
- Boîtier : Hammond 1455 ou impression 3D

## État du projet

Phase 0 — démarrage du PCB sous KiCad.

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
