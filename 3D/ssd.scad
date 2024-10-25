module ssd_sata_usb() {
  translate([0.9,-5.8,0.9]) color("dodgerblue") cube([40,11,3.6]);
  difference() {
    color("#404040") cube([41.8,20.5,0.9]);
    translate([-1,16.6,-1]) cube([13,5,5]);
    translate([30,16.6,-1]) cube([13,5,5]);
  }
}

//ssd_sata_usb();
module ssd_drill(guide=false) {
  $fn=16;
  module drill(d) {
    translate([4,14.3,4.5-10]) cylinder(d=d,h=10);
    translate([66,14.3,4.5-10]) cylinder(d=d,h=10);
    translate([4,90.6,4.5-10]) cylinder(d=d,h=10);
    translate([66,90.6,4.5-10]) cylinder(d=d,h=10);
    
    translate([4.5,14.3,3]) rotate([0,-90,0]) cylinder(d=d,h=10);
    translate([4.5,90.6,3]) rotate([0,-90,0]) cylinder(d=d,h=10);
    translate([70-4.5,14.3,3]) rotate([0,90,0]) cylinder(d=d,h=10);
    translate([70-4.5,90.6,3]) rotate([0,90,0]) cylinder(d=d,h=10);
  }
  color("Gainsboro") if(guide==true) drill(0.1); else drill(3); 
  
}

module ssd(guide=false,usb=false) {
  difference() {
    color("#303030") cube([70,100,7]);
    translate([11.5,-1,-1]) cube([37.2,6,7.2]);
    ssd_drill();
  }
  if (usb==true) translate([9,0,4.7]) rotate([180,0,0])ssd_sata_usb();
  if (guide==true) ssd_drill(guide=true);
}


module ssd_pack(n,guide=false,usb=false) {
  for (i = [0:n-1])
    translate([0,0,i*9]) ssd(guide=guide,usb=usb);
}

ssd_pack(n=1,guide=true,usb=true);
