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
  selon les designs publics éprouvés (cf. Inspiration ci-dessous)
- 2× pin headers 1×11 broches au pas 2,54 mm sur les bords longs
- VCC alimenté en 5 V depuis VBUS du XIAO côté carte mère, pour
  permettre la pleine puissance 30 dBm hardware
- Plan de masse continu sur la face arrière

## Inspiration (créditée mais non réutilisée directement)

Avant de partir from scratch, on avait évalué le design open hardware
de [NanoVHF/Meshtastic-DIY](https://github.com/NanoVHF/Meshtastic-DIY)
(`PCB/ESP-32-devkit_EBYTE-E22/EBYTE-E22-adapter-board/`, format Eagle
9.6.2). Sources d'origine conservées dans `upstream-eagle/` à titre de
référence pour comparaison de l'empreinte et du placement des pads.

Raisons du choix de repartir from scratch plutôt que d'adapter ce design :

1. Repo NanoVHF sans licence déclarée → propriété intellectuelle floue
   incompatible avec un usage opérationnel ou une publication propre.
2. Design pensé pour un sandwich avec ESP32 dev kit complet (52 broches
   sur 4 pin headers), surdimensionné pour notre besoin (22 broches
   utiles + alim).
3. Pas de découplage VCC (les condos sont à mettre côté carte mère dans
   leur architecture), ce qui n'est pas adapté à notre alim 5 V.
4. Notre empreinte E22 est déjà vendorisée dans `hardware/libs/ebyte/`
   (issue de la MR officielle KiCad), donc directement utilisable sans
   dépendre des libs de NanoVHF.

## Valeurs de découplage — sources

Le combo **100 nF + 10 µF céramique 0805** est validé par la pratique
de plusieurs designs publics éprouvés à 30 dBm voire 33 dBm :

- [eigenlucy/e22900m30s](https://github.com/eigenlucy/e22900m30s) :
  E22-900M30S, alim 5 V, 10 µF (0805) + 100 nF (0402)
- [KaliAssistant/MeshAdv_piHAT_v2](https://github.com/KaliAssistant/MeshAdv_piHAT_v2) :
  E22-900M33S (33 dBm = 2 W !), 10 µF + 100 nF répartis sur les rails
- [andrew-moroz/xiao-ble-pcb](https://github.com/andrew-moroz/xiao-ble-pcb) :
  E22-900M30S, MiniBoost 5V + 100 µF buffering en sortie

Ni la datasheet E22 ni les notes Semtech (AN1200.37, AN1200.40) ne
donnent de valeurs explicites pour le découplage externe d'un module
E22 fini — la datasheet recommande juste un « external ceramic filter
capacitor ». Les 100 nF + 10 µF sont donc retenus comme convention
d'industrie validée empiriquement.

## À faire

- [ ] Créer le projet KiCad `breakout-e22.kicad_pro`
- [ ] Schéma : E22 + C1/C2 + J1/J2 + power flags
- [ ] PCB compact ~25 × 42 mm avec plan de masse continu
- [ ] Mesurer précisément l'espacement des pin headers pour matching
      avec la carte mère
