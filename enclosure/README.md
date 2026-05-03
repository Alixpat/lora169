# Boîtier impression 3D — lora169

Boîtier paramétrique modélisé en OpenSCAD pour la carte mère lora169
(80 × 55 mm), avec breakout E22 enfichable au-dessus.

## Caractéristiques

- Dimensions intérieures : 84 × 59 × 30,6 mm (PCB + breakout + marges)
- Dimensions extérieures : 88 × 63 × 32,6 mm (avec parois 2 mm)
- Couvercle séparé de 2,5 mm vissé par 4 vis M3 traversant les piliers
- Découpe USB-C rectangulaire 11 × 5 mm sur le bord gauche, à la
  hauteur du XIAO ESP32-S3
- Trou rond Ø 6,5 mm pour SMA bulkhead sur le bord droit, en face de
  l'USB-C, à 7 mm au-dessus du plan du PCB
- 4 piliers cylindriques Ø 6 mm avec perçage Ø 2,7 mm pour vis M3
  auto-taraudantes — alignés avec les trous M3 du PCB

## Usage

Ouvrir `boitier-lora169.scad` dans **OpenSCAD**.

Variables principales en haut du fichier (à ajuster selon tes besoins) :
- `pcb_width`, `pcb_height` : dimensions du PCB
- `breakout_clearance` : hauteur libre au-dessus du PCB pour le breakout
- `wall_thickness`, `floor_thickness`, `lid_thickness` : épaisseurs
- `usb_pos_y`, `sma_pos_y`, `sma_pos_z` : positions des découpes
- `show_mode` : `"box"` (boîtier seul), `"lid"` (couvercle seul),
  `"assembled"` (les deux empilés), `"exploded"` (les deux séparés
  pour visualiser)

## Modes de visualisation

- **F5** dans OpenSCAD : preview rapide
- **F6** : rendu complet (CGAL, plus lent)
- **Fichier → Exporter en STL** : produit le fichier `.stl` à imprimer

Pour imprimer le boîtier ET le couvercle séparément (deux STL distincts) :
1. Régler `show_mode = "box"`, F6, exporter en `boitier-lora169-box.stl`
2. Régler `show_mode = "lid"`, F6, exporter en `boitier-lora169-lid.stl`

## Paramètres d'impression recommandés

- Matériau : PLA ou PETG
- Hauteur de couche : 0,2 mm
- Remplissage : 20-30 % (pas critique mécaniquement)
- Supports : nécessaires pour le creux intérieur du boîtier (sinon le
  fond ne peut pas s'imprimer correctement). Couvercle imprimable sans
  support (pièce plate).
- Périmètres : 3-4 (pour la solidité des parois)

## Visserie

- 4 × vis M3 auto-taraudantes longueur 8-10 mm (pour fixer le PCB sur
  les piliers depuis le dessus à travers les trous du PCB), ou
- 4 × vis M3 longueur 16-20 mm pour traverser le couvercle ET le PCB
  jusqu'aux piliers (option « tout-en-un »)

À ce jour, le code prévoit l'option « tout-en-un » : la vis traverse
le couvercle (Ø 3,4), passe à travers le trou du PCB (Ø 3,2), et se
visse dans le pilier (Ø 2,7 — taraudage fait par la vis elle-même).
