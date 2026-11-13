// =========================================================
// Exact Recreation of Existing Hub (spinnerbearing.stl)
// With Simplified Solid Circular Flange
// =========================================================

$fn = 128; // Smooth circular curves

// --- Outer Dimensions ---
flange_od       = 45.0;  // 25.0mm radius
flange_h        = 4.0;   // Z = 0 to 3mm
rim_h = 2.0; 
barrel_od       = 25.4;  // 12.7mm radius (1 inch)
total_h         = 25.0;  // Z = 0 to 23mm

// --- Internal Bearing Dimensions ---
bearing_od      = 22.4;  // 11.2mm radius (608 press-fit)
bearing_depth   = 7.0;   // 608 bearing thickness
spacer_id       = 19.4;  // 9.7mm radius internal shoulder

difference() {
    // 1. Solid Outer Body
    union() {
        // Bottom mounting flange (solid circle)
        translate([0, 0, rim_h])
        cylinder(d1 = flange_od,d2=barrel_od, h = flange_h);
        
        cylinder(d = flange_od, h = rim_h);
        
        // Main 1-inch barrel
    //    cylinder(d = barrel_od, h = total_h - bearing_depth);
        
    //    cylinder(d = bearing_od, h= total_h );
    }

    // 2. Internal Cutouts
    // Through-bore for the center spacer lip (Z = 0 to 23mm)
//    translate([0, 0, -1])
//        cylinder(d = spacer_id, h = total_h + 2);
    
        translate([0, 0, -1])
        cylinder(d = barrel_od, h = total_h + 2);

    // Bottom 608 bearing pocket (Z = 0 to 7mm)
 //   translate([0, 0, -0.01])
  //      cylinder(d = bearing_od, h = bearing_depth + 0.01);

    // Top 608 bearing pocket (Z = 16 to 23mm)
   // translate([0, 0, total_h - bearing_depth])
    //    cylinder(d = bearing_od, h = bearing_depth + 0.01);
}
