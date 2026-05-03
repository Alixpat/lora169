// =============================================================
//  Boîtier paramétrique pour la carte mère lora169
//
//  PCB 80 × 55 mm (mesuré depuis hardware/lora169.kicad_pcb).
//  4 trous M3 aux coins : (5,5) (75,5) (5,51) (75,51) en repère PCB.
//  USB-C XIAO en bord gauche, à Y=27,5 du PCB.
//  SMA bulkhead centré sur la face droite du boîtier.
//
//  Système de fermeture : couvercle plat avec un rebord intérieur
//  qui s'engage par friction dans le creux du boîtier (comme un
//  couvercle de bocal). Pas de vis, pas de clip.
// =============================================================

// ---------- Paramètres ajustables ----------

// Dimensions PCB carte mère (mesurées dans KiCad)
pcb_width  = 80;
pcb_height = 55;
pcb_thickness = 1.6;

// Trous M3 du PCB (positions relatives au coin bas-gauche du PCB)
hole_offset_x        = 5;   // X depuis le bord gauche/droit
hole_offset_y_top    = 5;   // Y depuis le bord HAUT
hole_offset_y_bottom = 4;   // Y depuis le bord BAS (asymétrie : J2 broche 11 trop proche)

// Hauteur libre nécessaire au-dessus du PCB pour breakout E22 + module enfiché
// 25 mm = ~14 mm pour le breakout + ~11 mm de marge pour le saisir à la main
// et l'extraire facilement du boîtier
breakout_clearance = 25;

// Position de l'USB-C (centre, depuis le coin bas-gauche du PCB)
usb_pos_y = 27.5;     // alignement Y avec le centre du XIAO
usb_cutout_w = 13;    // largeur découpe — accommode le boîtier plastique du câble
usb_cutout_h = 8;     // hauteur découpe — accommode les câbles renforcés

// SMA bulkhead — centré sur la face droite
sma_diameter = 6.5;

// Épaisseurs
wall_thickness  = 2;
floor_thickness = 2;
lid_thickness   = 2;
inner_margin    = 5;  // jeu autour du PCB sur les 4 côtés

// Piliers de centrage du PCB (2 étages, sans vis)
pillar_d_lower = 6;   // Ø étage bas (épaulement du PCB)
pillar_h_lower = 4;   // hauteur étage bas
pillar_d_upper = 3;   // Ø étage haut (passe dans le trou Ø 3,2 du PCB)
pillar_h_above_pcb = 1.5;  // dépassement de la partie fine au-dessus du PCB

// Couvercle (rebord intérieur d'engagement par friction)
lid_lip_height    = 3;     // hauteur du rebord descendant dans le boîtier
lid_lip_clearance = 0.3;   // jeu du rebord avec les parois (impression 3D)

// Ventilation du couvercle (fentes parallèles centrées)
vent_count   = 6;          // nombre de fentes
vent_length  = 40;         // longueur d'une fente (mm)
vent_width   = 2;          // largeur d'une fente (mm)
vent_spacing = 3;          // espacement entre fentes (mm)

// Mode d'affichage : "box" | "lid" | "assembled" | "exploded"
show_mode = "exploded";

// ---------- Calculs internes ----------

inner_width  = pcb_width + 2 * inner_margin;
inner_height = pcb_height + 2 * inner_margin;
inner_depth  = pillar_h_lower + pcb_thickness + breakout_clearance;

outer_width  = inner_width + 2 * wall_thickness;
outer_height = inner_height + 2 * wall_thickness;
outer_depth  = inner_depth + floor_thickness;

pcb_x = wall_thickness + inner_margin;
pcb_y = wall_thickness + inner_margin;
pcb_z = floor_thickness + pillar_h_lower;

// ---------- Modules ----------

// Boîte rectangulaire à coins verticaux arrondis (rayon r en XY)
module rounded_box(w, h, d, r) {
    hull() {
        for (x = [r, w - r])
            for (y = [r, h - r])
                translate([x, y, 0])
                    cylinder(r = r, h = d, $fn = 48);
    }
}

module pillar() {
    h_top = pillar_h_lower + pcb_thickness + pillar_h_above_pcb;
    union() {
        cylinder(h = pillar_h_lower, d = pillar_d_lower, $fn = 48);
        cylinder(h = h_top, d = pillar_d_upper, $fn = 32);
    }
}

module pillars() {
    for (px = [hole_offset_x, pcb_width - hole_offset_x])
        for (py = [hole_offset_y_top, pcb_height - hole_offset_y_bottom])
            translate([pcb_x + px, pcb_y + py, floor_thickness])
                pillar();
}

// Découpe USB-C dans la paroi gauche (X = 0), avec coins arrondis r=1 mm
module usb_cutout() {
    r = 1;  // rayon des coins arrondis
    translate([
        -1,
        pcb_y + usb_pos_y - usb_cutout_w / 2,
        pcb_z + pcb_thickness - 0.5
    ])
        hull() {
            for (cy = [r, usb_cutout_w - r])
                for (cz = [r, usb_cutout_h - r])
                    translate([0, cy, cz])
                        rotate([0, 90, 0])
                            cylinder(h = wall_thickness + 2, r = r, $fn = 32);
        }
}

// Trou SMA dans la paroi droite — centré
module sma_hole() {
    translate([outer_width + 1, outer_height / 2, outer_depth / 2])
        rotate([0, -90, 0])
            cylinder(h = wall_thickness + 2, d = sma_diameter, $fn = 48);
}

// Boîtier (cuvette ouverte sur le dessus, arêtes verticales arrondies)
module box() {
    difference() {
        rounded_box(outer_width, outer_height, outer_depth, 2);

        // Creux intérieur (arêtes verticales légèrement arrondies aussi)
        translate([wall_thickness, wall_thickness, floor_thickness])
            rounded_box(inner_width, inner_height, inner_depth + 1, 1);

        usb_cutout();
        sma_hole();
    }
    pillars();
}

// Fentes de ventilation centrées sur le couvercle
module vents() {
    block_h = vent_count * vent_width + (vent_count - 1) * vent_spacing;
    y_start = (outer_height - block_h) / 2;
    x_start = (outer_width - vent_length) / 2;

    for (i = [0 : vent_count - 1])
        translate([
            x_start,
            y_start + i * (vent_width + vent_spacing),
            -1
        ])
            rounded_box(vent_length, vent_width, lid_thickness + 2, 0.5);
}

// Couvercle plat avec rebord intérieur d'engagement par friction
// Arêtes verticales arrondies + fentes de ventilation centrées
module lid() {
    difference() {
        union() {
            // Plaque supérieure : couvre toute la surface du boîtier
            rounded_box(outer_width, outer_height, lid_thickness, 2);

            // Rebord intérieur qui descend dans le creux par friction
            translate([
                wall_thickness + lid_lip_clearance,
                wall_thickness + lid_lip_clearance,
                -lid_lip_height
            ])
                rounded_box(
                    inner_width - 2 * lid_lip_clearance,
                    inner_height - 2 * lid_lip_clearance,
                    lid_lip_height,
                    1
                );
        }

        // Soustraction des fentes de ventilation
        vents();
    }
}

// ---------- Affichage ----------
if (show_mode == "box") {
    box();
}
else if (show_mode == "lid") {
    lid();
}
else if (show_mode == "assembled") {
    box();
    translate([0, 0, outer_depth])
        lid();
}
else if (show_mode == "exploded") {
    box();
    translate([0, 0, outer_depth + 25])
        lid();
}
