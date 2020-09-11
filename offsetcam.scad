

outerdiameter=120;
ringwidth=11;
height=6;
module axelpart()
{
    translate([25,0,2]) {
   difference(){
    cylinder(h=10, r=20, center=true);
     cube([6.4,6.4,100],true);
    }
}
}

module ring() {
    
    $fa =0.1;
    color("Lime") 
    
    difference() {
  
    cylinder(h=height, r=outerdiameter/2, center=true);
         cylinder(r=(outerdiameter/2)-ringwidth,h=height+2,center=true) ;  
}
}
union(){
ring();
spoke();
rotate(a=90, v=[0,0,1]) {spoke(); }

rotate(a=45, v=[0,0,1]){
axelpart();
}
}
module spoke()
{
 translate([0,0,-1.5]){
     cube([outerdiameter-5,11,3],true);
     }
}

echo(version=version());

