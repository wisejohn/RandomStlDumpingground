/* defautls
fn = 300;
totalHeight = 23;
flangeHeight = 3;
flangeDiameter = 50;
mainDiameter = 30;

bearingDiameter = 22.4;
bearingStopThickness = 3;
bearingHeight = 7;
*/




fn = 300;
$fn = 200;
totalHeight = 23;
flangeHeight = 3;
flangeDiameter = 50;
mainDiameter = 25.4;

bearingDiameter = 22.4;
bearingStopThickness = 3;
bearingHeight = 7;


module realdeal(){
    difference () {
        union ()     {
            cylinder (h = totalHeight, d = mainDiameter, center=false, $fn = fn);
            scale([1,.3])    cylinder (h = flangeHeight, d = flangeDiameter, center=false);
            scale([.3,1])    cylinder (h = flangeHeight, d = flangeDiameter, center=false);
        }
        union()    {
            cylinder (h = bearingHeight, d = bearingDiameter, center=false, $fn = fn);
            cylinder (h = 300, d = bearingDiameter - bearingStopThickness , center=false);
            
           // translate([0,0,16])
            translate([0,0,totalHeight - bearingHeight ])
            cylinder (h = bearingHeight, d = bearingDiameter, center=false, $fn = fn);
            
        }
    }

}
module quicktestprint(){
    
    difference () {
     
            cylinder (h = bearingHeight+2, d = mainDiameter, center=false, $fn = fn);

        union()    {
            cylinder (h = bearingHeight, d = bearingDiameter, center=false, $fn = fn);
            cylinder (h = 300, d = bearingDiameter - bearingStopThickness , center=false);
         
            
        }
    }
}

//run them


realdeal();
//quicktestprint();