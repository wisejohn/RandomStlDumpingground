// ==========================================
// Parametric Dual-Bearing Pinched Cylinder
// ==========================================

/* [Bearing Dimensions (608 Standard)] */
// Outer diameter of bearing (22mm + press-fit clearance)
bearing_od = 22.3; 
// Width/depth of bearing pocket (7mm standard)
bearing_depth = 7.0; 

/* [Central Pinch & Wall Dimensions] */
// Inner diameter of the pinched center hole
center_hole_id = 9.0; 
// Uniform wall thickness maintained throughout the part
wall_thickness = 1.52; 
// Slope angle for the pinch transition (45 deg = ideal for overhang printing)
slope_angle = 45.0; 
// Extra flat straight section at the very center (0 for a sharp V-pinch)
center_flat_length = 3.0; 
extra_shaft = 20;

rope_hole_d     = 1.5;
/* [Print Quality] */
$fn = 120; // Circle smoothness

// ==========================================
// Calculated Geometry
// ==========================================
r_bearing = bearing_od / 2;
r_center = center_hole_id / 2;

// Radial change from bearing pocket to center hole
radial_step = r_bearing - r_center;

// Axial length required to achieve the slope_angle
slope_height = radial_step / tan(slope_angle);

// Total height of the cylinder
total_height = (bearing_depth * 2) + (slope_height * 2) + center_flat_length;

rope_hole_r = rope_hole_d /2;
// ==========================================
// 3D Model Generation
// ==========================================
module pinched_bearing_hub() {
    // Define the 2D cross-section profile (inner wall + outer wall)
    // Drawn from bottom (z = 0) to top (z = total_height)
    inner_points = [
        [r_bearing, 0],
        [r_bearing, bearing_depth],
        [r_center,  bearing_depth + slope_height],
        [r_center,  bearing_depth + slope_height + center_flat_length],
        [r_bearing-2, total_height - bearing_depth],
    [r_bearing-2, total_height+extra_shaft - bearing_depth],
   [r_bearing, total_height+extra_shaft - bearing_depth],
        [r_bearing, total_height+extra_shaft]
    ];

    // Offset the inner profile outward along X by wall_thickness
    // to guarantee constant radial wall thickness at every height
    outer_points = [
        [r_bearing + wall_thickness, total_height+extra_shaft],
        [r_bearing + wall_thickness, total_height - bearing_depth],
        [r_center  + wall_thickness, bearing_depth + slope_height + center_flat_length],
    
        [r_center  + wall_thickness, bearing_depth + slope_height],
        [r_bearing + wall_thickness, bearing_depth + (slope_height/2)],
        [r_bearing + wall_thickness, 0]
    ];

    
    
    difference() {
    rotate_extrude(convexity = 10) {
        polygon(points = concat(inner_points, outer_points));
    }
    
    translate([r_center+wall_thickness+rope_hole_r, 0, 0])
   
            cylinder(d = rope_hole_d, h = bearing_depth + slope_height);
    
}
    
    
    
}

module bearing_joiner() {
    difference(){
cylinder(d = bearing_od+0.4, h = bearing_depth * 2);
         translate([0, 0, -1])
cylinder(d = bearing_od-3, h = (bearing_depth * 2) + 2);

}
}





pinched_bearing_hub();
    
 
//translate([0,0,total_height+extra_shaft-bearing_depth])
//bearing_joiner();


// Echo key calculated dimensions to the console
echo(str("Total Part Height: ", total_height, " mm"));
echo(str("Outer Cylinder Diameter: ", (r_bearing + wall_thickness) * 2, " mm"));
echo(str("Pinched Outer Diameter: ", (r_center + wall_thickness) * 2, " mm"));
