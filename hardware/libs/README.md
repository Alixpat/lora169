# Librairies KiCad vendorisées

Symboles et empreintes des modules utilisés par le projet, copiés depuis
des sources upstream et adaptés au besoin. Ces librairies sont déclarées
au niveau du projet via `${KIPRJMOD}` dans `hardware/sym-lib-table` et
`hardware/fp-lib-table`, donc elles fonctionnent dès le clone du repo,
sans configuration manuelle dans KiCad.

## seeed/ — Seeed XIAO ESP32-S3

Source : https://github.com/Seeed-Studio/OPL_Kicad_Library
Commit : `3be8215` (2026-03-18) — dernier commit en format KiCad 9
(les commits ultérieurs sont en format KiCad 10 et ne se chargent pas
dans KiCad 9.0.2).
Licence : voir `LICENSE` de l'upstream.

Fichiers extraits de `Seeed Studio XIAO Series Library/` :

- `Seeed_Studio_XIAO_Series.kicad_sym` — symboles de toute la famille XIAO
- `footprints.pretty/XIAO-ESP32-S3-DIP.kicad_mod` — empreinte traversante
  (barrettes mâles), choix par défaut pour ce projet
- `footprints.pretty/XIAO-ESP32-S3-SMD.kicad_mod` — empreinte CMS, gardée
  en réserve

Pour mettre à jour : `git clone --depth 1` du dépôt upstream, recopier
les fichiers, mettre à jour le commit hash ci-dessus.

## ebyte/ — Ebyte E22-170M30S

Adaptés des merge requests soumises aux librairies officielles KiCad par
TheSillyMouse en 2020, **non encore mergées** au moment de la copie :

- Symbole : https://gitlab.com/kicad/libraries/kicad-symbols/-/merge_requests/2826
- Empreinte : https://gitlab.com/kicad/libraries/kicad-footprints/-/merge_requests/2345

Modifications appliquées :

- Renommé `E22-900M30S-SX1262` → `E22-170M30S-SX1262` (toute la famille
  `E22-xxxM30S` partage la même mécanique 24 × 38,5 mm et le même
  brochage, seule la fréquence porteuse change — voir datasheet E22-M
  section 3.3 « E22-170/400/900M30S(33S) »).
- Symbole converti du format legacy `.lib` vers `.kicad_sym` (format
  KiCad 9, version 20241209) via `kicad-cli sym upgrade`.
- Empreinte conservée en format `module/tedit` (KiCad 5/6) — KiCad 9
  le lit et le sauvegardera au format moderne au premier édit.
- Champ « Footprint » du symbole pointé sur `Ebyte_E22:E22-170M30S-SX1262`.
- Champ « Datasheet » pointé sur `${KIPRJMOD}/../docs/datasheets/E22-170M30S_UserManual.pdf`.

**À vérifier avant fabrication :** l'empreinte vient d'une MR communautaire
non validée par les mainteneurs KiCad. Mesurer un module physique au pied
à coulisse et confronter aux cotes de la datasheet (24 × 38,5 mm, pads
0,80 × 1,50 mm, pas vertical 2,54 mm avec creux central de 7,60 mm) avant
le premier envoi en fab.

**Variantes IPEX vs stamp hole :** l'empreinte couvre la version stamp
hole (pad 21 = ANT). Pour la version IPEX que nous utilisons, le pad 21
est laissé non connecté — la sortie RF passe par le connecteur U.FL
physique soudé au centre du module.
