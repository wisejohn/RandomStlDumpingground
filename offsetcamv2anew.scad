

outerdiameter=120;
ringwidth=5.5;
height=5.5;
holerotation = 15;
//index=0;
//index=1;
index=2;
//index=3;
//index=4;
//index=5;

module axelpart()
{
    translate([25,0,2.25]) {
        difference(){
            cylinder(h=10, r=20, center=true);
            //union(){
            //cube([6.4,6.4,100],true);
            rotate(a=holerotation*index,v=[0,0,1]){
                cube([6.4,6.4,100],true);
            }
           // }
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
difference(){
union(){
    ring();
    spoke();
    rotate(a=90, v=[0,0,1]) {spoke(); }
    rotate(a=45, v=[0,0,1]){
        axelpart();
    }
}

 translate([25,10,5]) {
color("Lime")
linear_extrude(height=5, convexity=4)
                text("2", 
                     size=8,
                     font="Bitstream Vera Sans",
                     halign="center",
                     valign="center");
 }

}

module spoke()
{
     cube([outerdiameter-5,height,height],true);
}
