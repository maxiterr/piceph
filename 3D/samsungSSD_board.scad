use <ssd.scad>

module samsungSSD_drill(guide=false) {
  $fn=16;
  module drill_screw(d) {
    translate([2.7,26.7,0])
      cylinder(h=20,d=d, center=true);
    translate([50.8,33.6,0])
      cylinder(h=20,d=d,center=true);
  }
  module drill_positionnal(d) {
    translate([1.5,5.1,0])
      cylinder(h=20,d=d,center=true);
    translate([51.5,5.1,0])
      cylinder(h=20,d=d,center=true);
    translate([2.7,68.9,0])
      cylinder(h=20,d=d,center=true);
    translate([50.8,68.9,0])
      cylinder(h=20,d=d,center=true);
  }
  if(guide==true) drill_screw(0.1); else drill_screw(2.5);
  if(guide==true) drill_positionnal(0.1); else drill_positionnal(2.2);
}

module samsungSSD_sata () {
  difference() {
    cube([45,6.6,5.5]);
    translate([3.8,-1,-1]) cube([37.2,7,5.8]);
  }
}

module samsungSSD_board(guide=false) {
  difference() {
    color("green") cube([53,71,1]);
    samsungSSD_drill();
    translate([0.8,11.9,0]) cylinder(h=4,d=5.9,center=true);
  }
  if (guide==true) samsungSSD_drill(guide=true);
  translate([4.2,-2.6,-2.4]) samsungSSD_sata ();
  translate([5.9,-3.4,2.1]) rotate([180,0,0]) ssd_sata_usb();
}

samsungSSD_board(guide=true);