// ==========================================
// 608 Skateboard Bearing Pulley Ring
// ==========================================

/* [Bearing Dimensions] */
// Standard 608 outer diameter is 22mm. Add ~0.2mm - 0.3mm for press-fit tolerance.
bearing_od = 22.25; 
// Standard 608 width is 7mm.
bearing_width = 7.0; 

/* [Pulley Dimensions] */
// Outer diameter of the pulley flanges
pulley_od = 34.0;
// Diameter of the rope/string groove (must be larger than bearing_od)
groove_od = 26.0;
// Width of the flat bottom of the groove (adjust to your rope thickness)
groove_bottom_width = 1;
// Thickness of the outer rims/flanges
flange_rim_thickness = 0;

/* [Render Quality] */
$fn = 120;

// ==========================================
// Calculations & Geometry
// ==========================================
r_in = bearing_od / 2;
r_groove = groove_od / 2;
r_out = pulley_od / 2;

// Ensure groove width fits inside the bearing width
safe_groove_w = min(groove_bottom_width, bearing_width - (flange_rim_thickness * 2));

module bearing_pulley() {
    rotate_extrude() {
        polygon(points = [
            [r_in, 0],                                                   // Bottom inner corner
            [r_out, 0],                                                  // Bottom outer corner
            [r_out, flange_rim_thickness],                               // Lower flange rim
            [r_groove, (bearing_width - safe_groove_w) / 2],             // Bottom of V-groove
            [r_groove, (bearing_width + safe_groove_w) / 2],             // Top of V-groove
            [r_out, bearing_width - flange_rim_thickness],               // Upper flange rim
            [r_out, bearing_width],                                      // Top outer corner
            [r_in, bearing_width]                                        // Top inner corner
        ]);
    }
}

bearing_pulley();
