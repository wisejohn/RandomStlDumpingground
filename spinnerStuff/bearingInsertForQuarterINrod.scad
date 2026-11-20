// Parametric Dual-608 Bearing to 1/4" Threaded Rod Adapter
// Print 2 copies (one for each end of the dual-bearing hub)

$fn = 80;

// --- Dimensions (mm) ---
bearing_bore     = 7.95;   // 608 inner race is 8.0mm; 7.95 gives a snug slip fit
rod_diameter     = 6.45;   // Clearance for 1/4" (6.35mm) threaded rod
crush_rib_inset  = 0.20;   // How far each of the 3 ribs protrudes inward to grip threads
hub_total_height = 23.0;
//hub_total_height = 50;// Total span across both bearings + center spacer
gap_between_ends = 1.0;    // Center gap so the two halves don't bottom out before clamping

flange_od        = 11.5;   // Must stay <= 12.0mm so it only touches the 608 inner race!
flange_thickness = 2.0;    // Thickness of the washer/brim outside the bearing

// --- Calculated ---
barrel_length = (hub_total_height / 2) - (gap_between_ends / 2);

module top_hat_bushing() {
    difference() {
        union() {
            // Outer flange (clamps against bearing inner race)
            cylinder(d = flange_od, h = flange_thickness);
            
            // Main sleeve barrel (slides into 8mm bearing bore)
            translate([0, 0, flange_thickness])
                cylinder(d = bearing_bore, h = barrel_length);
        }
        
        // Center bore for 1/4" threaded rod
        translate([0, 0, -0.5])
            cylinder(d = rod_diameter, h = flange_thickness + barrel_length + 1);
    }
    
    // 3 internal crush ribs to eliminate thread slop and self-center the rod
  /*  for (angle = [0, 120, 240]) {
        rotate([0, 0, angle])
            translate([(rod_diameter / 2) - crush_rib_inset, 0, flange_thickness])
                cylinder(d = crush_rib_inset * 2.5, h = barrel_length);
    }*/
}
top_hat_bushing();

/*
// Render a pair side-by-side
translate([-8, 0, 0]) top_hat_bushing();
translate([8, 0, 0]) top_hat_bushing();

*/
