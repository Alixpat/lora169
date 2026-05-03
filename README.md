# lora169

Carte d'émission/réception LoRa autonome sur la bande 169,4–169,475 MHz
(ARCEP 2007-0689, harmonisée CE 2005/928), alimentée et programmée en USB-C.

## Hardware

- MCU : Seeed XIAO ESP32-S3
- Radio : Ebyte E22-170M30S (SX1262, IPEX)
- Antenne : pigtail U.FL → SMA femelle bulkhead, fouet 169 MHz
- Boîtier : Hammond 1455 ou impression 3D

## État du projet

Phase 0 — design hardware terminé, en attente de fabrication.

| Pièce | Fichier source | Gerbers | DRC | Statut |
|-------|---------------|---------|-----|--------|
| Carte mère | `hardware/lora169.kicad_pcb` (80 × 55 mm) | `hardware/lora169-gerbers.zip` | 0 erreur | Prête à fabriquer |
| Breakout E22 | `hardware/breakout-e22/breakout-e22.kicad_pcb` (40,6 × 46,3 mm) | `hardware/breakout-e22/breakout-e22-gerbers.zip` | 0 erreur | Prêt à fabriquer |
| Boîtier 3D | `enclosure/boitier-lora169.scad` (90 × 65 × 27,6 mm) | — | — | À imprimer |

## Architecture

- **Carte mère** : XIAO ESP32-S3 + 2 embases femelles 1×11 qui reçoivent le breakout. Alim USB-C (5 V via VBUS). Format compact 80 × 55 mm. PCB 2 couches, plan de masse continu en face arrière, routage manuel en F.Cu.
- **Breakout E22** : carte fille démontable (40,6 × 46,3 mm) qui adapte le module Ebyte E22-xxxM30S (SMD avec pads en bord) en module DIP enfichable via 2 pin headers mâles 1×11 au pas 2,54 mm. Permet de changer de fréquence (170 / 400 / 900 MHz) sans toucher à la carte mère, en bénéficiant de la mécanique commune à toute la famille E22-xxxM30S. Découplage local 100 nF + 10 µF céramique X7R 0805 sur VCC.
- **Antenne** : sortie RF du module E22 (version IPEX) vers connecteur SMA femelle bulkhead via pigtail U.FL ; antenne fouet 169 MHz vissée à l'extérieur du boîtier.
- **Boîtier** : impression 3D en deux pièces (cuvette + couvercle), couvercle plat avec rebord intérieur d'engagement par friction (sans vis, sans clip). Découpe USB-C alignée XIAO en bord gauche, trou SMA Ø 6,5 mm centré sur la face droite.

## Structure du dépôt

```
docs/datasheets/        Datasheets PDF (E22-170M30S, SX1262, AN Semtech)
hardware/               Projet KiCad carte mère (.kicad_pro/.sch/.pcb)
hardware/fab/           Gerbers + drill carte mère (régénérables, voir .gitignore)
hardware/libs/seeed/    Symbole + empreintes XIAO ESP32-S3 (vendorisés)
hardware/libs/ebyte/    Symbole + empreinte E22-170M30S (vendorisés)
hardware/breakout-e22/  Carte fille adaptatrice E22 (KiCad + Gerbers)
enclosure/              Boîtier OpenSCAD paramétrique
```

Chaque lib vendorisée et le breakout ont leur propre `README.md` qui
documente la source upstream et les éventuelles modifications appliquées.

## Outils nécessaires (Debian 13 / Trixie)

### KiCad 9 (schéma + PCB)

```bash
sudo apt update
sudo apt install kicad kicad-libraries kicad-symbols kicad-footprints kicad-packages3d
```

Vérification : `kicad-cli --version`

### OpenSCAD (modélisation du boîtier 3D paramétrique)

Le boîtier est défini par code paramétrique dans `enclosure/boitier-lora169.scad`.
OpenSCAD permet de visualiser le rendu 3D, ajuster les paramètres, et exporter
en STL pour l'impression 3D.

```bash
sudo apt install openscad
```

Usage : ouvrir le `.scad` dans OpenSCAD, F5 pour preview, F6 pour render
complet, **Fichier → Exporter en STL** pour l'impression.

## Ouvrir le projet

Ouvre `hardware/lora169.kicad_pro` dans KiCad. Les librairies spécifiques
au projet (`Seeed_XIAO`, `Ebyte_E22`) sont déjà déclarées dans
`hardware/sym-lib-table` et `hardware/fp-lib-table` via la variable
`${KIPRJMOD}` — rien à reconfigurer manuellement après un clone.

## Journal des commandes

| Date       | Composant                          | Qté | Source     | Sous-total | Livraison | Réduction | Total   |
|------------|------------------------------------|-----|------------|-----------:|----------:|----------:|--------:|
| 2026-05-01 | Seeed Studio XIAO ESP32-S3         | 2   | AliExpress (Seeedstudio AI Hardware Store) | 15,49 €    | 4,41 €    | −0,87 €   | 19,03 € |
| 2026-05-01 | Ebyte E22-170M30S                  | 2   | AliExpress (Boutique officielle EBYTE) | 13,78 €    | 4,17 €    | −0,77 €   | 17,18 € |
| 2026-05-03 | Antenne Ebyte TX170-JKD-20 (3 dBi, 200 mm, fouet flexible 169 MHz, SMA) | 6 | AliExpress (CDSENET) | — | — | — | 13,30 € |
