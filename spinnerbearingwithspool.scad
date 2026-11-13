// =========================================================
// Integrated Wood Wheel Hub + Bottom-Mounted Rope Spool
// Top 20mm barrel remains completely clear for wheel bore
// =========================================================

$fn = 128; // Smooth circular resolution

// --- Existing Hub Dimensions (from your STL) ---
wheel_barrel_od = 25.4;  // 1-inch barrel that fits inside wooden wheel
wheel_barrel_h  = 20.0;  // Clear barrel height above the 3mm flange (23mm - 3mm)
mount_flange_od = 50.0;  // Existing 50mm flange (seats against wood wheel)
mount_flange_h  = 3.0;   // Existing 3mm flange thickness

// --- 608 Bearing Pocket Dimensions (from your STL) ---
bearing_od      = 22.4;  // 22.4mm press-fit bore
bearing_depth   = 7.0;   // Standard 608 bearing thickness
spacer_id       = 19.4;  // Internal spacer lip ID

// --- Bottom Spool Parameters (Customize These!) ---
spool_width     = 14.0;  // Inner vertical width for rope to wind
spool_core_od   = 25.4;  // Matches 25.4mm barrel (keeps 1.5mm wall around bearing)
bottom_rim_od   = 50.0;  // Bottom retention flange diameter
bottom_rim_h    = 3.0;   // Thickness of bottom outer lip
taper_h         = 6.0;   // Angled inner wall height to guide rope smoothly
rope_hole_d     = 4.0;   // Pass-through hole on bottom rim to tie off cord

// Calculated section heights (built from Z = 0 upward)
spool_section_h = bottom_rim_h + taper_h + spool_width;
total_h         = spool_section_h + mount_flange_h + wheel_barrel_h;

difference() {
    union() {
        // 1. Bottom Spool Retention Rim (Z = 0 to bottom_rim_h)
        cylinder(d = bottom_rim_od, h = bottom_rim_h);

        // 2. Bottom Spool Taper (guides rope away from bottom rim)
        translate([0, 0, bottom_rim_h])
            cylinder(d1 = bottom_rim_od, d2 = spool_core_od, h = taper_h);

        // 3. Upper Spool Taper (transitions out to the 50mm wheel flange)
        translate([0, 0, spool_section_h - taper_h])
            cylinder(d1 = spool_core_od, d2 = mount_flange_od, h = taper_h);

        // 4. Existing 50mm Wheel Mounting Flange
        translate([0, 0, spool_section_h])
            cylinder(d = mount_flange_od, h = mount_flange_h);

        // 5. Full-Height 25.4mm Central Barrel
        // Top 20mm extends cleanly above the 50mm flange into your wooden wheel
        cylinder(d = wheel_barrel_od, h = total_h);
    }

    // --- Internal Bearing Bores (Preserves exact 22.4mm / 19.4mm fit) ---
    // Full-length center spacer bore
    translate([0, 0, -1])
        cylinder(d = spacer_id, h = total_h + 2);

    // Bottom 608 Bearing Pocket (Flush with Z = 0 bottom face)
    translate([0, 0, -0.01])
        cylinder(d = bearing_od, h = bearing_depth + 0.01);

    // Top 608 Bearing Pocket (Flush with top of wooden wheel barrel)
    translate([0, 0, total_h - bearing_depth])
        cylinder(d = bearing_od, h = bearing_depth + 0.01);

    // --- Diagonal Rope Anchor Hole ---
    // Exits through the bottom rim so you can tie a stopper knot cleanly
    translate([spool_core_od/2 + 2, 0, bottom_rim_h + taper_h - 1])
        rotate([0, 155, 0])
            cylinder(d = rope_hole_d, h = bottom_rim_h + taper_h + 4);
}
