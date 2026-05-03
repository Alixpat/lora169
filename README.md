# lora169

Carte LoRa 169 MHz autonome. Conformité ARCEP 2007-0689 (bande 169,4–169,475 MHz, 27 dBm p.a.r. max).

## Hardware

- **MCU** : Seeed XIAO ESP32-S3 (USB-C natif)
- **Radio** : Ebyte E22-170M30S (SX1262, IPEX), enfichable sur breakout démontable
- **Antenne** : Ebyte TX170-JKD-20 (3 dBi, fouet 200 mm), via pigtail U.FL → SMA bulkhead
- **Boîtier** : impression 3D paramétrique

## État du projet

| Pièce | Source | DRC / vérif | Statut |
|-------|--------|-------------|--------|
| Carte mère (80 × 55 mm) | `hardware/lora169.kicad_*` | 0 erreur | Commandée JLCPCB |
| Breakout E22 (40,6 × 46,3 mm) | `hardware/breakout-e22/*.kicad_*` | 0 erreur | Commandé JLCPCB |
| Boîtier 3D (94 × 69 × 32,6 mm) | `enclosure/boitier-lora169.scad` | — | Commandé JLC3DP |

## Structure

```
docs/datasheets/        Datasheets PDF (E22, SX1262, AN Semtech)
hardware/               Projet KiCad carte mère
hardware/libs/          Symboles + empreintes vendorisés (Seeed, Ebyte)
hardware/breakout-e22/  Projet KiCad de la carte fille E22
enclosure/              Boîtier OpenSCAD paramétrique
```

## Outils (Debian 13)

```bash
sudo apt install kicad kicad-libraries kicad-symbols kicad-footprints kicad-packages3d openscad
```

## Ouvrir le projet

`hardware/lora169.kicad_pro` (carte mère) ou `hardware/breakout-e22/breakout-e22.kicad_pro` (breakout). Les libs `Seeed_XIAO` et `Ebyte_E22` sont déjà déclarées via `${KIPRJMOD}`.

Pour le boîtier : `openscad enclosure/boitier-lora169.scad` — modifier `show_mode` (`"box"` / `"lid"` / `"assembled"` / `"exploded"`), F6, exporter en STL.

## Régénérer les Gerbers

```bash
cd hardware
kicad-cli pcb export gerbers --output fab/ \
  --layers "F.Cu,B.Cu,F.Paste,B.Paste,F.Silkscreen,B.Silkscreen,F.Mask,B.Mask,Edge.Cuts" \
  lora169.kicad_pcb
kicad-cli pcb export drill --output fab/ lora169.kicad_pcb
cd fab && python3 -m zipfile -c ../lora169-gerbers.zip *.g* *.drl
```

## Journal des commandes

| Date       | Composant                          | Qté | Source     | Sous-total | Frais (livr./douane/PayPal) | Réduction | Total   |
|------------|------------------------------------|-----|------------|-----------:|----------------------------:|----------:|--------:|
| 2026-05-01 | Seeed XIAO ESP32-S3                | 2   | AliExpress (Seeedstudio AI Hardware Store) | 15,49 € | 4,41 € | −0,87 € | 19,03 € |
| 2026-05-01 | Ebyte E22-170M30S                  | 2   | AliExpress (Boutique officielle EBYTE) | 13,78 € | 4,17 € | −0,77 € | 17,18 € |
| 2026-05-03 | Antenne Ebyte TX170-JKD-20         | 6   | AliExpress (CDSENET) | — | — | — | 13,30 € |
| 2026-05-03 | PCB carte mère + breakout + 2 boîtiers 3D (groupé W2026050322580094) | 5+5+2+2 | JLCPCB / JLC3DP | 14,64 € | 15,08 € | −8,52 € | 21,20 € |

**Total engagé : 70,71 €**
