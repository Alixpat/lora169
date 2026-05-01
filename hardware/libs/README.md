# Bibliothèques KiCad vendorisées

## seeed/

Symboles et empreintes pour les modules Seeed XIAO, extraits de la
bibliothèque officielle Seeed Studio :

- Source : https://github.com/Seeed-Studio/OPL_Kicad_Library
- Commit : `3be8215` (2026-03-18) — dernier commit en format KiCad 9
  (les commits ultérieurs sont en format KiCad 10 et ne se chargent pas
  dans KiCad 9.0.2)
- Licence : voir `LICENSE` de l'upstream

Fichiers conservés ici (extraits de `Seeed Studio XIAO Series Library/`) :

- `Seeed_Studio_XIAO_Series.kicad_sym` — symboles de toute la famille XIAO
- `footprints.pretty/XIAO-ESP32-S3-DIP.kicad_mod` — empreinte traversante
  (barrettes mâles), choix par défaut pour ce projet
- `footprints.pretty/XIAO-ESP32-S3-SMD.kicad_mod` — empreinte CMS, gardée
  en réserve

Pour mettre à jour : `git clone --depth 1` du dépôt upstream, recopier les
fichiers, mettre à jour le commit hash ci-dessus.
