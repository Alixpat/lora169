# Breakout E22 (carte fille)

Carte adaptatrice qui transforme le module Ebyte E22-170M30S (SMD, pads
en bord) en module DIP enfichable via deux pin headers 1×11 broches au
pas 2,54 mm. Permet de changer de fréquence (170 / 400 / 900 MHz) sur
la carte mère sans dessouder.

## Conception

Design propre fait pour ce projet, avec :

- 1× module E22-xxxM30S (mécanique commune à 170/400/900 MHz)
- 2× condensateurs de découplage 100 nF + 10 µF (céramique X7R 0805)
  au plus près des pins VCC, pour absorber le pic TX 30 dBm (~620 mA)
- 2× pin headers 1×11 broches au pas 2,54 mm sur les bords longs
- VCC alimenté en 5 V depuis VBUS du XIAO côté carte mère, pour
  permettre la pleine puissance 30 dBm hardware
- Plan de masse continu sur la face arrière

## Caractéristiques techniques

- Format PCB : **40,6 × 46,3 mm** (compact, à peine plus large que
  le module E22 lui-même de 24 × 38,5 mm)
- Espacement entre les deux pin headers J1/J2 : **32,1 mm** centre à
  centre — à respecter sur la carte mère (embases femelles 1×11)
- Pistes signal en 0,2 mm, piste alim +5V en 0,4 mm pour absorber le
  pic 620 mA en TX 30 dBm
- Pads GND en pleine connexion à la zone GND (sans thermal relief)
  pour minimiser l'inductance de retour

## Valeurs de découplage — sources

Le combo **100 nF + 10 µF céramique 0805** est validé par la pratique
de plusieurs designs publics éprouvés à 30 dBm voire 33 dBm :

- [eigenlucy/e22900m30s](https://github.com/eigenlucy/e22900m30s) :
  E22-900M30S, alim 5 V, 10 µF (0805) + 100 nF (0402)
- [KaliAssistant/MeshAdv_piHAT_v2](https://github.com/KaliAssistant/MeshAdv_piHAT_v2) :
  E22-900M33S (33 dBm = 2 W !), 10 µF + 100 nF répartis sur les rails
- [andrew-moroz/xiao-ble-pcb](https://github.com/andrew-moroz/xiao-ble-pcb) :
  E22-900M30S, MiniBoost 5 V + 100 µF buffering en sortie

Ni la datasheet E22 ni les notes Semtech (AN1200.37, AN1200.40) ne
donnent de valeurs explicites pour le découplage externe d'un module
E22 fini — la datasheet recommande juste un « external ceramic filter
capacitor ». Les 100 nF + 10 µF sont donc retenus comme convention
d'industrie validée empiriquement.

## Mapping J1 / J2 (côté carte mère)

| Pin header | Broche | Signal   | Pad E22 |
|------------|--------|----------|---------|
| J2         | 1-5, 11| GND      | 1-5, 11 |
| J2         | 6      | RXEN     | 6       |
| J2         | 7      | TXEN     | 7       |
| J2         | 8      | NC (DIO2)| 8       |
| J2         | 9-10   | +5V (VCC)| 9-10    |
| J1         | 1, 9, 11| GND     | 12, 20, 22 |
| J1         | 2      | DIO1     | 13      |
| J1         | 3      | BUSY     | 14      |
| J1         | 4      | NRST     | 15      |
| J1         | 5      | MISO     | 16      |
| J1         | 6      | MOSI     | 17      |
| J1         | 7      | SCK      | 18      |
| J1         | 8      | NSS      | 19      |
| J1         | 10     | NC (ANT) | 21 (sortie RF, non utilisée en IPEX) |

## Statut

- DRC : 0 erreur, 0 unconnected
- Gerbers générés : `breakout-e22-gerbers.zip`
- Prêt à fabriquer chez JLCPCB / PCBWay
