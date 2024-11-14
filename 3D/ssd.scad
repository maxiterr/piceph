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
    translate([4,91.6,4.5-10]) cylinder(d=d,h=10);
    translate([66,91.6,4.5-10]) cylinder(d=d,h=10);
    
    translate([4.5,14.3,3]) rotate([0,-90,0]) cylinder(d=d,h=10);
    translate([4.5,91.6,3]) rotate([0,-90,0]) cylinder(d=d,h=10);
    translate([70-4.5,14.3,3]) rotate([0,90,0]) cylinder(d=d,h=10);
    translate([70-4.5,91.6,3]) rotate([0,90,0]) cylinder(d=d,h=10);
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
//ssd_pack(n=6,guide=true,usb=true);

module ssd_flask(top=false) {
  $fn=50;
  module screw() {
    difference() {
      cylinder(h=3,d=6);
      translate([0,0,-2])cylinder(h=6,d=3);
    }
  }

  module panel(top=false) {
    difference() {
      cube([1.5,90,55]);
      for (i = [0:5]) {
        translate([-5,6.3,5+i*9]) rotate([0,90,0]) cylinder(h=10,d=3.7);
        translate([-5,83.6,5+i*9]) rotate([0,90,0]) cylinder(h=10,d=3.7);
      }
      hull() {
        translate([-7,22,7]) rotate([0,90,0]) cylinder(h=10,d=5);
        translate([-7,67,7]) rotate([0,90,0]) cylinder(h=10,d=5);
        translate([-7,44.5,20]) rotate([0,90,0]) cylinder(h=10,d=5);
      }
      hull () {
        translate([-7,22,45]) rotate([0,90,0]) cylinder(h=10,d=5);
        translate([-7,67,45]) rotate([0,90,0]) cylinder(h=10,d=5);
        translate([-7,44.5,32]) rotate([0,90,0]) cylinder(h=10,d=5);
      }
      hull () {
        translate([-7,15,15]) rotate([0,90,0]) cylinder(h=10,d=5);
        translate([-7,15,37]) rotate([0,90,0]) cylinder(h=10,d=5);
        translate([-7,34,26]) rotate([0,90,0]) cylinder(h=10,d=5);
      }
      hull () {
        translate([-7,74,15]) rotate([0,90,0]) cylinder(h=10,d=5);
        translate([-7,74,37]) rotate([0,90,0]) cylinder(h=10,d=5);
        translate([-7,55,26]) rotate([0,90,0]) cylinder(h=10,d=5);
      }
    }
    translate([3,-6,0]) screw();
    translate([0,-6,0]) cube([1.5,6,3]);
    translate([1.5,-3.5,0]) cube([2.5,5,3]);
    
    if (!top) {
      translate([3,95,0]) screw();
      translate([0,90,0]) cube([1.5,5,3]);
      translate([1.5,88,0]) cube([2.5,4.5,3]);
    }
  }
  
  
  translate([1,1.5,0]) cube([3,1.5,50]);
  translate([1,9.5,0]) cube([3,1.5,50]);

  translate([1,78.8,0]) cube([3,1.5,50]);
  translate([1,86.8,0]) cube([3,1.5,50]);

  panel(top=top);
}
ssd_flask(top=false);